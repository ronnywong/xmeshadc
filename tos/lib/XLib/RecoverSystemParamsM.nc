/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * Copyright (c) 2004 by Sensicast, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: RecoverSystemParamsM.nc,v 1.3.4.4 2007/04/25 23:42:32 njain Exp $
 */

//
// @Author: Michael Newman, Hu Siquan
//
// $Id: RecoverSystemParamsM.nc,v 1.3.4.4 2007/04/25 23:42:32 njain Exp $

#define RecoverSystemParamsMedit 1

includes config;
#include "xcmd_platform.h"

module RecoverSystemParamsM {
  provides interface StdControl as XEESubControl;
  provides interface ConfigInt8 as SystemGroupNumber;
  provides interface ConfigInt16 as SystemMoteID;
  provides interface ConfigInt8 as SystemModelType;
  provides interface ConfigInt8 as SystemSuModelType;
  provides interface ConfigInt8 as SystemMoteCPUType;
  provides interface ConfigInt8 as SystemRadioType;
  provides interface ConfigInt16 as SystemVendorID;
  provides interface Config as SystemSerialNumber;
  provides interface Config as SystemCPUOscillatorFrequency;

  provides interface ConfigInt8 as RadioChannel; // 8 bits of rf channel, 
  provides interface ConfigInt8 as RadioPower; // 8 biss of rf power, from 0x0 to 0xff

  provides interface Config as CrossbowFactoryInfo1; // 16 bytes of factory information (printable ascii)
  provides interface Config as CrossbowFactoryInfo2; // 16 bytes of factory information (printable ascii)
  provides interface Config as CrossbowFactoryInfo3; // 16 bytes of factory information (printable ascii)
  provides interface Config as CrossbowFactoryInfo4; // 16 bytes of factory information (printable ascii)


  provides interface Config as XmeshAppTimerRate; //    32 bits of xmesh apps' timer rate


  uses {
  	interface StdControl as CommControl;
  	interface XCMD_CC_CONTROL;
    // SerialID
	interface StdControl as DS2401;
	interface HardwareId;
  	}
}
implementation {

#ifndef MIN
#define MIN(_a,_b) ((_a < _b) ? _a : _b)
#endif

uint8_t DSSerialID[8];

    command result_t XEESubControl.init()
    {
		call DS2401.init();
		return SUCCESS;
    }

    command result_t XEESubControl.start()
    {
    	call DS2401.start();
    	call HardwareId.read(&DSSerialID[0]);
		return SUCCESS;
    }

    command result_t XEESubControl.stop()
    {
    	call DS2401.stop();

		return SUCCESS;
    }



  command uint16_t SystemMoteID.get() {
//  	SODbg(DBG_TEMP,"SystemMoteID.get =  %d\n",TOS_LOCAL_ADDRESS);
    return TOS_LOCAL_ADDRESS;
  }

  command result_t SystemMoteID.set(uint16_t value) {
//      if (value == TOS_BCAST_ADDR) {
//	  // Not allowed to set address to broadcast address
//	  return FAIL;
//      }
      atomic {
	  TOS_LOCAL_ADDRESS = value;
//		memcpy(&TOS_LOCAL_ADDRESS,&value,2);
      }
      return SUCCESS;
  }

  command uint8_t SystemGroupNumber.get() {
//  	SODbg(DBG_TEMP,"SystemGroup = 0x%x \n",TOS_AM_GROUP);
//			SODbg(DBG_TEMP,"TOS_AM_GROUP: 0x%x  \n",TOS_AM_GROUP);
      return TOS_AM_GROUP;
  }

  command result_t SystemGroupNumber.set(uint8_t value) {
      atomic TOS_AM_GROUP = value;
      return SUCCESS;
  }

  uint8_t sysModelType = TOS_MODEL_UNKNOWN; // default value
  command uint8_t SystemModelType.get() {
  	return sysModelType;
  }

  command result_t SystemModelType.set(uint8_t value) {
  	  sysModelType = value;
  	  return SUCCESS;
  }

  uint8_t sysSubModelType = TOS_SUBMODEL_UNKNOWN; // default value
  command uint8_t SystemSuModelType.get() {
  	return sysSubModelType;
  }

  command result_t SystemSuModelType.set(uint8_t value) {
  	  sysSubModelType = value;
  	  return SUCCESS;
  }

  uint8_t sysMoteCPUType = TOS_CPU_TYPE_UNKNOWN; // default value
  command uint8_t SystemMoteCPUType.get() {
  	return sysMoteCPUType;
  }

  command result_t SystemMoteCPUType.set(uint8_t value) {
  	  sysMoteCPUType = value;
  	  return SUCCESS;
  }

  uint8_t sysRadioType = TOS_RADIO_TYPE_UNKNOWN; // default value
  command uint8_t SystemRadioType.get() {
  	return sysRadioType;
  }

  command result_t SystemRadioType.set(uint8_t value) {
  	  sysRadioType = value;
  	  return SUCCESS;
  }

  uint16_t sysVendorID = TOS_VENDOR_UNKNOWN; // default value
  command uint16_t SystemVendorID.get() {
  	return sysVendorID;
  }

  command result_t SystemVendorID.set(uint16_t value) {
  	  sysVendorID = value;
  	  return SUCCESS;
  }


  command size_t SystemSerialNumber.get(void *buffer, size_t size) {
	if (buffer != NULL) {
 		memcpy(buffer,&DSSerialID[0],8);
    }
	return 8;
  }

    event result_t HardwareId.readDone(uint8_t *id, result_t success)
  {
  	call DS2401.stop();
    return SUCCESS;
  }

  command result_t SystemSerialNumber.set(void *buffer, size_t size) {
	return SUCCESS;
  }

  uint32_t sysCPUOscillatorFrequency = 0; // default value

  command size_t SystemCPUOscillatorFrequency.get(void *buffer, size_t size) {

	if (buffer != NULL) {
	    memcpy(buffer,&sysCPUOscillatorFrequency, MIN(size,sizeof(sysCPUOscillatorFrequency)));
    };
	return sizeof(sysCPUOscillatorFrequency);
  }

  command result_t SystemCPUOscillatorFrequency.set(void *buffer, size_t size) {
	int32_t value;
	if (size != sizeof sysCPUOscillatorFrequency)
	    return FAIL;
	value = *(int32_t *)buffer;
	sysCPUOscillatorFrequency = value;
	return SUCCESS;
  }



  command uint8_t RadioPower.get() {
    return XCMD_GET_RF_POWER;
  }

  command result_t RadioPower.set(uint8_t value) {
      XCMD_SET_RF_POWER(value)
      return SUCCESS;
  }

    command uint8_t RadioChannel.get(){
    // read the registers to get CC2420 channel
    // For operation in channel k, the FSCTRL.FREQ
    // register should therefore be set to: FSCTRL.FREQ = 357 + 5 (k-11)
    // Valid channel values are 11 through 26.
    return XCMD_GET_CC_CHANNEL;
  }

  command result_t RadioChannel.set(uint8_t value) {
	XCMD_SET_CC_CHANNEL(value)
	return SUCCESS;
  }


  uint8_t xbowFacInfo1[16] = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,}; // default value

  command size_t CrossbowFactoryInfo1.get(void *buffer, size_t size) {
	if (buffer != NULL) {
	    memcpy(buffer,xbowFacInfo1, MIN(size,16*sizeof(uint8_t)));
    };
	return 16*sizeof(uint8_t);
  }

  command result_t CrossbowFactoryInfo1.set(void *buffer, size_t size) {
	uint8_t *value;
	int i;

	if (size != 16*sizeof(uint8_t))
	    return FAIL;
	value = (uint8_t *)buffer;
	for(i=0;i<16;i++) xbowFacInfo1[i] = value[i];
	return SUCCESS;
  }

  uint8_t xbowFacInfo2[16] = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,}; // default value

  command size_t CrossbowFactoryInfo2.get(void *buffer, size_t size) {
	if (buffer != NULL) {
	    memcpy(buffer,xbowFacInfo2, MIN(size,16*sizeof(uint8_t)));
    };
	return 16*sizeof(uint8_t);
  }

  command result_t CrossbowFactoryInfo2.set(void *buffer, size_t size) {
	uint8_t *value;
	int i;
	if (size != 16*sizeof(uint8_t))
	    return FAIL;
	value = (uint8_t *)buffer;
	for(i=0;i<16;i++) xbowFacInfo2[i] = value[i];
	return SUCCESS;
  }

  uint8_t xbowFacInfo3[16] = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,}; // default value

  command size_t CrossbowFactoryInfo3.get(void *buffer, size_t size) {
	if (buffer != NULL) {
	    memcpy(buffer,xbowFacInfo3, MIN(size,16*sizeof(uint8_t)));
    };
	return 16*sizeof(uint8_t);
  }

  command result_t CrossbowFactoryInfo3.set(void *buffer, size_t size) {
	uint8_t *value;
	int i;
	if (size != 16*sizeof(uint8_t))
	    return FAIL;
	value = (uint8_t *)buffer;
	for(i=0;i<16;i++) xbowFacInfo3[i] = value[i];
	return SUCCESS;
  }

  uint8_t xbowFacInfo4[16] = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,}; // default value

  command size_t CrossbowFactoryInfo4.get(void *buffer, size_t size) {
	if (buffer != NULL) {
	    memcpy(buffer,xbowFacInfo4, MIN(size,16*sizeof(uint8_t)));
    };
	return 16*sizeof(uint8_t);

  }

  command result_t CrossbowFactoryInfo4.set(void *buffer, size_t size) {
	uint8_t *value;
	int i;
	if (size != 16*sizeof(uint8_t))
	    return FAIL;
	value = (uint8_t *)buffer;
	for(i=0;i<16;i++) xbowFacInfo4[i] = value[i];
	return SUCCESS;
  }

  //uint32_t myrate = 18430;
  command size_t XmeshAppTimerRate.get(void *buffer, size_t size) {

	if (buffer != NULL) {
	    memcpy(buffer,&timer_rate, MIN(size,4));
    };
	return 4*sizeof(uint8_t);
  }

  command result_t XmeshAppTimerRate.set(void *buffer, size_t size) {
	int32_t value;
	if (size != 4)
	    return FAIL;
	value = *(int32_t *)buffer;
	timer_rate = value;
	return SUCCESS;
  }

}
