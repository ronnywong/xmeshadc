/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: IntersemaPressureM.nc,v 1.1.4.1 2007/04/27 05:41:05 njain Exp $
 */

/*
 *
 * Authors:		Joe Polastre
 *
 */

includes sensorboard;

module IntersemaPressureM {
  provides {
    interface ADC as Temperature;
    interface ADC as Pressure;
    interface SplitControl;
    interface Calibration;
  }
  uses {
    interface StdControl as SwitchControl;
    interface StdControl as LowerControl;
    interface Calibration as LowerCalibrate;
    interface Switch;
    interface Switch as IOSwitch;
    interface ADC as LowerPressure;
    interface ADC as LowerTemp;
	interface Timer;
    interface StdControl as TimerControl;
  }
}
implementation {

//  #include "SODebug.h"  
//  #define DBG_USR2    0               //disables printf msgs

  enum { IDLE, WARM_UP, WAIT_SWITCH_ON, WAIT_SWITCH_OFF, BUSY, 
	 MAIN_SWITCH_ON, MAIN_SWITCH_OFF, SWITCH_IO1, SWITCH_IO2, SWITCH_IO3, 
	 POWERON, POWEROFF, IOON = 1, IOOFF = 0 };

  char state;
  char sensor;
  char iostate;
  char c_word;

  uint16_t temp,pressure;
  uint16_t c_value;


  task void initDone() {
	signal SplitControl.initDone();
  }

  task void stopDone() {
 	signal SplitControl.stopDone();
  }

  task void startDone(){
    signal SplitControl.startDone();
  }
  
  task void LowerStop()
  {
  	call LowerControl.stop();
  }
  task void LowerStart()
  {
  	call LowerControl.start();
  }

  task void IOBus() {
  	char l_state, l_iostate;
  	
  	atomic {
  		l_state = state;
  		l_iostate = iostate;
  	}
    if (l_state == BUSY) {
      atomic state = SWITCH_IO1;
      call IOSwitch.set(MICAWB_PRESSURE_SCLK, l_iostate);
    }
    else if (l_state == SWITCH_IO1) {
//	  SODbg(DBG_USR2, "IntesemaPressure.IoBus.SCLK switch set \n"); 
      atomic state = SWITCH_IO2;
      call IOSwitch.set(MICAWB_PRESSURE_DIN, l_iostate);
    }
    else if (l_state == SWITCH_IO2) {
//	  SODbg(DBG_USR2, "IntesemaPressure.IoBus.Din switch set \n"); 
      atomic state = SWITCH_IO3;
      call IOSwitch.set(MICAWB_PRESSURE_DOUT, l_iostate);
    }
    else if (l_state == SWITCH_IO3) {
//	    SODbg(DBG_USR2, "IntesemaPressure.IOBus.all switches set \n"); 
		atomic state = IDLE;
		if (l_iostate == IOOFF){
	      call LowerControl.stop();
    	  post stopDone();
        }
        else {
       	 post startDone();
	    }
    }
//    else if (iostate == IOOFF) {
//	      call LowerControl.stop();
//	      state = IDLE;
//	  post stopDone();
//      state = POWEROFF;



    //}

  }


command result_t SplitControl.init() {
    atomic {
    	state = IDLE;
    	iostate = IOOFF;
    }
    call LowerControl.init();
    call SwitchControl.init();
	call TimerControl.init();
	post initDone();
	return SUCCESS;
  }

  command result_t SplitControl.start() {
//    SODbg(DBG_USR2, "IntesemaPressure.start: turning on power \n"); 
    atomic state = MAIN_SWITCH_ON;
    call SwitchControl.start();
    if (call Switch.set(MICAWB_PRESSURE_POWER,1) != SUCCESS) {
      atomic state = WAIT_SWITCH_ON;
    }
    return SUCCESS;
  }

  command result_t SplitControl.stop() {
//    SODbg(DBG_USR2, "IntesemaPressure.stop: turning off power \n"); 
    atomic state = MAIN_SWITCH_OFF;
    call SwitchControl.start();
    if (call Switch.set(MICAWB_PRESSURE_POWER,0) != SUCCESS) {
//      SODbg(DBG_USR2, "IntesemaPressure.stop: failed to get bus \n"); 
      atomic state = WAIT_SWITCH_OFF;
    }
    return SUCCESS;
  }


 
  event result_t Switch.getDone(char value) {
    return SUCCESS;
  }

  event result_t Switch.setDone(bool l_result) {
  	char l_state;
  	atomic l_state = state;
    
    if (l_state == WAIT_SWITCH_ON) {
      if (call Switch.set(MICAWB_PRESSURE_POWER,1) == SUCCESS) {
	     atomic state = MAIN_SWITCH_ON;
      }
    }
    else if (l_state == WAIT_SWITCH_OFF) {
      if (call Switch.set(MICAWB_PRESSURE_POWER,0) == SUCCESS) {
	     atomic state = MAIN_SWITCH_OFF;
      }
    }
    else if (l_state == MAIN_SWITCH_ON) {
//	  SODbg(DBG_USR2, "IntesemaPressure.start: power on, timer activated \n"); 
        atomic {
        	iostate = IOON;
        	state = BUSY;
        }
        post IOBus();          //turn on other switches
		return SUCCESS;
    }
    else if (l_state == MAIN_SWITCH_OFF) {
    	atomic {
        	state = BUSY;
        	iostate = IOOFF;
        }
		post IOBus();	  
//	  post stopDone();
//      state = POWEROFF;
    }
    return SUCCESS;
  }

  event result_t Switch.setAllDone(bool l_result) {
    return SUCCESS;
  }

  event result_t IOSwitch.getDone(char value) {
    return SUCCESS;
  }


//turn on/off all the I/O switches
  event result_t IOSwitch.setDone(bool l_result) {
  	atomic if ((state == SWITCH_IO1) || (state == SWITCH_IO2) || (state == SWITCH_IO3)) {
      post IOBus();
    }
    return SUCCESS;
  }

  event result_t IOSwitch.setAllDone(bool l_result) {
    return SUCCESS;
  }


 event result_t Timer.fired() {
 	char l_state;
 	atomic l_state = state;
   if (l_state == WARM_UP) {
//	    SODbg(DBG_USR2, "IntesemaPressure.Timer.fired \n"); 
		atomic state = BUSY;
        post IOBus();
   }
   return SUCCESS;
  }



/******************************************************************************
 * Get temperature or pressure data from sensor
 *****************************************************************************/
async  command result_t Temperature.getData() {
	char l_state;
 	atomic l_state = state;
    if (l_state == IDLE)
    {
      atomic state = BUSY;
      post LowerStart();
      call LowerTemp.getData();
      return SUCCESS;
    }
    return FAIL;
  }

 async event result_t LowerTemp.dataReady(uint16_t data) {
    atomic state = IDLE;
	signal Temperature.dataReady(data);
    return SUCCESS;
  }

 async command result_t Pressure.getData() {
	char l_state;
 	atomic l_state = state;
    if (l_state == IDLE)
    {
      atomic {
      	state = BUSY;
      	sensor = MICAWB_PRESSURE;
      	iostate = IOON;
      }
      post LowerStart();
	  call LowerPressure.getData();
      return SUCCESS;
    }
    return FAIL;
  }

  async event result_t LowerPressure.dataReady(uint16_t data) {
    atomic state = IDLE;
    signal Pressure.dataReady(data);
    return SUCCESS;
  }

  // no such thing
 async command result_t Temperature.getContinuousData() {
    return FAIL;
  }

  // no such thing
  async command result_t Pressure.getContinuousData() {
    return FAIL;
  }

 default async event result_t Temperature.dataReady(uint16_t data)
  {
    return SUCCESS;
  }

  default async event result_t Pressure.dataReady(uint16_t data)
  {
    return SUCCESS;
  }

/******************************************************************************
 * Read calibration words (4) from sensor
 *****************************************************************************/
command result_t Calibration.getData() {
	char l_state;
 	atomic l_state = state;
	
    if (l_state == IDLE)
//	 SODbg(DBG_USR2, "IntesemaPressure.Calibration.getData \n"); 
    {
      atomic state = BUSY;
      call LowerControl.start();
	  call LowerCalibrate.getData();
      return SUCCESS;
    }
    return FAIL;
  }

 // on the last byte of calibration data, shut down the I/O interface
  event result_t LowerCalibrate.dataReady(char word, uint16_t value) {
    if (word == 4) {
      call LowerControl.stop();
	  atomic state = IDLE;
	  signal Calibration.dataReady(word, value);
    }
    else {
	  call LowerControl.stop();
      signal Calibration.dataReady(word, value);
    }
    return SUCCESS;
  }

  default event result_t Calibration.dataReady(char word, uint16_t value) {
    return SUCCESS;
  }

 
}

