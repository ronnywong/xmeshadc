/*
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: InternalFlashC.nc,v 1.1.4.1 2007/04/26 22:06:49 njain Exp $
 */


/**
 * InternalFlashC.nc - Internal flash implementation for telos msp
 * platform. On the msp, the flash must first be erased before a value
 * can be written. However, the msp can only erase the flash at a
 * segment granularity (128 bytes for the information section). This
 * module allows transparent read/write of individual bytes to the
 * information section by dynamically switching between the two
 * provided segments in the information section.
 *
 * Valid address range is 0x1000 - 0x107E (0x107F is used to store the
 * version number of the information segment).
 *
 * @author Jonathan Hui <jwhui@cs.berkeley.edu>
 */

includes InternalFlash;

module InternalFlashC {
  provides interface InternalFlash;
}

implementation {

  enum {
    IFLASH_BOUND_LOW  = 0x00,
    IFLASH_BOUND_HIGH = 0x7e,
    IFLASH_OFFSET     = 0x1000,
    IFLASH_SIZE       = 128,
    IFLASH_SEG0_VNUM_ADDR = 0x107f,
    IFLASH_SEG1_VNUM_ADDR = 0x10ff,
  };

  uint8_t chooseSegment() {
    uint8_t vnum0 = *(uint8_t*)IFLASH_SEG0_VNUM_ADDR;
    uint8_t vnum1 = *(uint8_t*)IFLASH_SEG1_VNUM_ADDR;
    if (vnum0 != 0xff && vnum1 != 0xff)
      return (vnum0 >= vnum1) ? 0 : 1;
    else if (vnum0 == 0 && vnum1 == 0xff)
      return 0;
    else if (vnum0 == 0xff && vnum1 == 0)
      return 1;
    return 0;
  }

  command result_t InternalFlash.write(void* addr, void* buf, uint16_t size) {

    volatile uint8_t* addrPtr;
    uint8_t *bufPtr = (uint8_t*)buf;
    uint8_t secToUpd = 0;
    uint16_t i;

    if ((uint16_t)addr < IFLASH_BOUND_LOW || IFLASH_BOUND_HIGH + 2 <= (uint16_t)addr + size - 1)
      return FAIL;

    if (chooseSegment() == 0) {
      addr = (void*)((uint16_t)addr + IFLASH_SIZE);
      secToUpd = 1;
    }
    addr = (void*)((uint16_t)addr + IFLASH_OFFSET);

    addrPtr = (uint8_t*)((uint16_t)addr & ~0x7f);

    atomic {
      FCTL2 = FWKEY + FSSEL1 + FN2;
      FCTL3 = FWKEY;// | (FCTL3 & 0x0FF);
      FCTL1 = FWKEY + ERASE;
      *addrPtr = 0;
      FCTL1 = FWKEY + WRT;
      for (i = 0; i < IFLASH_SIZE-1; i++) {
	if ((uint16_t)addrPtr < (uint16_t)addr 
	    || (uint16_t)addr+size <= (uint16_t)addrPtr) {
	  *addrPtr = (secToUpd == 0) ? *(addrPtr + IFLASH_SIZE) : *(addrPtr - IFLASH_SIZE);
	}
	else {
	  *addrPtr = *bufPtr;
	  bufPtr++;
	}
	addrPtr++;
      }
      *addrPtr = (secToUpd == 0) ? (*(uint8_t*)IFLASH_SEG1_VNUM_ADDR)+1 : (*(uint8_t*)IFLASH_SEG0_VNUM_ADDR)+1;
      FCTL1 = FWKEY;
      FCTL3 = (FWKEY + LOCK);// | (FCTL3 & 0x0FF);
    }

    return SUCCESS;

  }

  command result_t InternalFlash.read(void* addr, void* buf, uint16_t size) {

    if ((uint16_t)addr < IFLASH_BOUND_LOW || IFLASH_BOUND_HIGH + 2 <= (uint16_t)addr + size)
      return FAIL;

    if (chooseSegment() == 1)
      addr = (void*)((uint16_t)addr + IFLASH_SIZE);
    addr = (void*)((uint16_t)addr + IFLASH_OFFSET);

    memcpy(buf, addr, size);

    return SUCCESS;

  }

}
