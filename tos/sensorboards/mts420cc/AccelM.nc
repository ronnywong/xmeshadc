/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: AccelM.nc,v 1.1.2.2 2007/04/27 05:48:35 njain Exp $
 */

includes sensorboard;
module AccelM {
  provides  {
   interface StdControl;
   interface I2CSwitchCmds as AccelCmd;
 
  }
  uses {
    interface ADCControl;
	interface Timer;
	interface StdControl as SwitchControl;
    interface Switch as Switch1;

  }
}
implementation {

//#include "SODebug.h"
//#define DBG_USR2  0  
 
 enum {ACCEL_SWITCH_IDLE,                      //I2C switches are not using the I2C bus 
       ACCEL_PWR_SWITCH_WAIT,                  //Couldn't get GPS I2C bus
       ACCEL_PWR_SWITCH,                       //Got I2C bus, power turning on
	   BUSY,  
       POWEROFF,
       TIMER};
 
  uint8_t state_accel;
  uint8_t power_accel;

  command result_t StdControl.init() {
	state_accel = ACCEL_SWITCH_IDLE; 
    power_accel = 0;
//	SODbg(DBG_USR2, "ACCEL initialized.\n");
    call SwitchControl.init();
    return call ADCControl.init();
  }

  command result_t StdControl.start() {
    call SwitchControl.start();
//    SODbg(DBG_USR2, "AccelM: I2C switch init \n");
    return SUCCESS;
  }

  command result_t StdControl.stop() {
    return SUCCESS;
  }

/******************************************************************************
 * Turn Accel power  on/off
 * PowerState = 0 then accel power off, 
 *            = 1 then accel power on
 * ADXL202E has turn on time of 160*Cflt+0.3 ms
 *         Cflt = 0.1 uF
 *         Turn on time = ~16 msec.
 *****************************************************************************/
command result_t AccelCmd.PowerSwitch(uint8_t PowerState){
//    SODbg(DBG_USR2, "AccelM: PowerSwitch \n");
    if (state_accel == ACCEL_SWITCH_IDLE){
	   state_accel = ACCEL_PWR_SWITCH;
       power_accel = PowerState;
       if (!call Switch1.set(MICAWB_ACCEL_POWER,power_accel) == SUCCESS) state_accel = ACCEL_PWR_SWITCH_WAIT;
       return SUCCESS;
    }
    return FAIL;
} 

 event result_t Switch1.getDone(char value) {
    return SUCCESS;
  }

/******************************************************************************
 * Power switch set on or off
 * If turning power on then wait 100 msec for ADXL202 turn-on before returning
 * else return immediately.
 *****************************************************************************/
 event result_t Switch1.setDone(bool local_result) {
//   SODbg(DBG_USR2, "AccelM: setDone: state %i \n", state_accel);
    if (state_accel == ACCEL_PWR_SWITCH_WAIT){        //try again to get I2C bus
//       SODbg(DBG_USR2, "AccelM: setDone: I2C retry \n ");
	   state_accel = ACCEL_PWR_SWITCH;
	   if (!call Switch1.set(MICAWB_ACCEL_POWER,power_accel) == SUCCESS) state_accel = ACCEL_PWR_SWITCH_WAIT;
       return SUCCESS;
	}
	if (state_accel == ACCEL_PWR_SWITCH){
      if (power_accel) {
	    return call Timer.start(TIMER_ONE_SHOT, 100);
      }
	  state_accel = ACCEL_SWITCH_IDLE;
	  signal AccelCmd.SwitchesSet(power_accel);
    }
	return SUCCESS;
  }

 
  event result_t Switch1.setAllDone(bool local_result) {
    return SUCCESS;
  }


 // sensor is now warmed up
 event result_t Timer.fired() {
	state_accel = ACCEL_SWITCH_IDLE;
    signal AccelCmd.SwitchesSet(power_accel);
    return SUCCESS;
  } 


 }

