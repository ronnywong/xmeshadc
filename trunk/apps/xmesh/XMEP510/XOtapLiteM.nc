/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: XOtapLiteM.nc,v 1.1.2.2 2007/04/26 20:13:05 njain Exp $
 */

/**
 * Otap-Lite module: accept otap reboot command and boot into the image in the specified slot
 *
 * @file   XOtapLiteM.nc
 * @author Ning Xu
 * @date   May 30, 2006
 *
 * $Id: XOtapLiteM.nc,v 1.1.2.2 2007/04/26 20:13:05 njain Exp $
 */

#include "XOtapParam.h"

module XOtapLiteM 
{
  provides {
    interface StdControl;
    interface XOtapLoader;
  }
  uses {
    interface ParamOpI as ParamRead;
    interface ParamOpI as ParamSave;
    interface ReceiveMsg as OTAPReceive;
    interface RouteControl;
    interface Timer;
    interface Send as BootAckSend;
    interface XMAL_CC_CONTROL;
  }
    XMAL_USE_BOUNDARY_INTERFACE
}

implementation
{
  XMAL_DECLARE_MSGPTR(otap_resp_msg)
  uint8_t imageId = MAX_SLOT_NUM+1;

  command result_t StdControl.init () {
        uint16_t addr;
        uint8_t  group;

//defeat OTAPLITE component for non-otap apps. At low battery
//voltages (<2.7V) eeprom read/writes are corrupted resulting
//in permenent loss of mote if note_id is corrupted.
		return SUCCESS;                  

        XMAL_ALLOC_TOS_BUF(otap_resp_msg,4);
	addr = call ParamRead.nodeid();
        // if the eeprom has 0xFFFF as its address, save the current information to eeprom
 	if (addr == BOOT_FLASH_ERASE) {		
            call ParamSave.channel();
            call ParamSave.nodeid();
            call ParamSave.groupid();
            call ParamSave.rfpower();
	}
        else {
	    group =  call ParamRead.groupid();
	    atomic {
               TOS_LOCAL_ADDRESS = addr;
	       TOS_AM_GROUP =  group;
            }
            XMAL_SET_CC_CHANNEL(call ParamRead.channel())
 	    XMAL_SET_RF_POWER(call ParamRead.rfpower())
        }
     return SUCCESS;
  }
  command result_t StdControl.start () {
     return SUCCESS;
  }
  command result_t StdControl.stop () {
     return SUCCESS;
   }

  task void request_boot() {
      // can we reboot, dear Mr. application?
       signal XOtapLoader.boot_request(imageId);
  }

/**
 * intercept the otap command
 */
  event TOS_MsgPtr OTAPReceive.receive(TOS_MsgPtr pMsg) {
    TOS_MHopMsg *pMHMsg = (TOS_MHopMsg *)pMsg->data;
    TOS_MHopMsg *pMHOtapRespMsg = (TOS_MHopMsg *)otap_resp_msg->data;
    Mote_Mgmt *pMgmt = (Mote_Mgmt *)pMHMsg->data;
    uint8_t len = pMsg->length - offsetof(TOS_MHopMsg,data);

    if ( pMgmt->op == BOOT_IMAGE_CMD) {
     // send the ack (XMGMT_RESP type) back, here we mimic the bahivior of the full otap code
       memcpy(pMHOtapRespMsg->data, pMHMsg->data, len); 
       call BootAckSend.send(otap_resp_msg, len);
       imageId = pMgmt->imgId;
    }
    return pMsg;
  } 


/**
 * perform the actual boot action
 */
  task void boot_me() {
    uint8_t *dirp, ebyte;
    uint32_t new_addr;


    dirp = EE_DIR_SLOT (imageId);
    while (!eeprom_is_ready ());
    ebyte = eeprom_read_byte (dirp + offsetof (struct image_dir, flags));
   
    if (ebyte & 1) {  // If the Image is *Bootable* 

      while (!eeprom_is_ready ());
      eeprom_write_byte ((uint8_t *)EE_BOOT_INFO_LOC, imageId);
      /*
       * Now tell the Boot-Loader that the Image is at a specific location.
       */
      while (!eeprom_is_ready ());
      /*
       * The start address is in 2K blocks. First convert it to
       * a byte offset, then convert it to Page addres (external).
       */
      new_addr = eeprom_read_byte (dirp + offsetof (struct image_dir, fpage_start));
      new_addr |= eeprom_read_byte (dirp + offsetof (struct image_dir, fpage_start) + 1) << 8l;

      new_addr <<= (long)(EXT_FLASH_BLOCK_SHIFT);
      new_addr /= (long)(BL_EXTERNAL_PAGE_SIZE);
      eeprom_write_byte ((uint8_t *)BL_NEW_IMG_START_PAGE_ADDR,
			 (uint8_t)new_addr);
      eeprom_write_byte ((uint8_t *)BL_NEW_IMG_START_PAGE_ADDR+1,
			 (new_addr >> 8));
      eeprom_write_byte ((uint8_t *)BL_LOAD_IMG_ADDR, 0xAB);
      while (!eeprom_is_ready ());
    }

    // Reboot to invoke Bootloader
    cli ();
    wdt_enable (0);
    while (1) { 
      __asm__ __volatile__("nop" "\n\t" ::);
    }
  }

/**
 * Otap reboot command
 * get the go ahead signal from the application.
 * schedule the boot time according to the depth of the node in the tree.
 * -if it is one hop away, it will boot after 10 seconds
 * -if it is two hops away, it will boot after 8 seconds,
 * ...
 * -if it is 5 or more hops away, it will boot after 2 seconds.
 *
 */
  command result_t XOtapLoader.boot(uint8_t id) {
    uint32_t wait_time = REBOOT_INTERVAL;
    uint8_t depth = call RouteControl.getDepth();

    imageId = id;
    // schedule a boot time based on how deep the node is
    // the farther away it is from the base, the less delay to boot
    if (depth > BOOT_DELAY_FACTOR) depth = BOOT_DELAY_FACTOR;
    wait_time *= (BOOT_DELAY_FACTOR-depth+1);
        
    if (imageId <=MAX_SLOT_NUM) { 
      call Timer.start(TIMER_ONE_SHOT, wait_time);
      return SUCCESS;
    } else 
      return FAIL;
  }

  event result_t Timer.fired() {
        post boot_me();
        return SUCCESS;
  }

  event result_t BootAckSend.sendDone (TOS_MsgPtr pMsg, result_t success) {
#ifndef MOTE_MGMT
// response only when XMgmt is not wired in
        if (imageId <= MAX_SLOT_NUM) {
            post request_boot();
        }
#endif
        return SUCCESS;
  }
  default event result_t XOtapLoader.boot_request(uint8_t imgID) {
        call XOtapLoader.boot(imgID);
        return SUCCESS;
   }
}
