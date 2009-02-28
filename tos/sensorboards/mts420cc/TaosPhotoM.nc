/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: TaosPhotoM.nc,v 1.1.2.2 2007/04/27 05:51:23 njain Exp $
 */

/*
 *
 * Authors:		Joe Polastre
 *
 */

includes sensorboard;
module TaosPhotoM {
  provides {
    interface ADC[uint8_t id];
    interface SplitControl;
  }
  uses {
    interface StdControl as SwitchControl;
    interface StdControl as I2CPacketControl;
    interface Switch;
    interface Timer;
    interface I2CPacket;
	interface StdControl as TimerControl;  //For TimerC initialization    
  }
}
implementation {
//#include "SODebug.h"
//#define DBG_USR2  0  

  enum {IDLE, START_TAOS, SWITCH_POWER_ON, SWITCH_POWER_OFF, SWITCH_WAIT,
        READ_0, READ_1};

  char state;
  char tempvalue;
  bool power;
  char data_adc;
  

  task void DataReady_0(){
//       SODbg(DBG_USR2, "TaosPhoto:Ch0:, %i \n", (uint16_t)data_adc);
	   signal ADC.dataReady[0](data_adc);
	   return;
     }
  
  task void DataReady_1(){
//       SODbg(DBG_USR2, "TaosPhoto:Ch1:, %i \n", (uint16_t)data_adc);
	   signal ADC.dataReady[1](data_adc);
	   return;
     }
     
  task void TaosRead()
  {
  	call I2CPacket.writePacket(1,(char*)&tempvalue,0x01);
  }


  command result_t SplitControl.init() {
    atomic state = IDLE;
    power = FALSE;

//	SODbg(DBG_USR2, "TaosPhoto:init \n"); 

    call TimerControl.init(); // Explicitly initialize the TOS Timer
    call I2CPacketControl.init();
    call SwitchControl.init();
    signal SplitControl.initDone();                //don't need this.
	return SUCCESS;;
  }
/******************************************************************************
 * Start: 
 * - turn on power 
 * - if can't set switch then state = SWITCH_WAIT
 *****************************************************************************/
  command result_t SplitControl.start() {
    
//	   SODbg(DBG_USR2, "TaosPhoto:start \n"); 

	   atomic state = SWITCH_POWER_ON;    
    call I2CPacketControl.start();
    call SwitchControl.start();
    if (call Switch.set(MICAWB_LIGHT_POWER,1) != SUCCESS) atomic state = SWITCH_WAIT;
    return SUCCESS;
  }

  command result_t SplitControl.stop() {
    power = FALSE;
    // turn the sensor off
   	atomic state = SWITCH_POWER_OFF;
    return call Switch.set(MICAWB_LIGHT_POWER,0);
  }

  event result_t Switch.getDone(char value) {
    return SUCCESS;
  }
/******************************************************************************
 * Swtich control done
 * - if state= SWITCH_POWER_ON:
 *     power just turned on, xmit cmd to start Taos
 * - if state= SWITCH_POWER_OFF:
 *     notify completion
 *****************************************************************************/
  event result_t Switch.setDone(bool result) {
    uint8_t l_state;
    
    atomic l_state = state;
    if (l_state == SWITCH_POWER_OFF){                    //asb
	    atomic state = IDLE;
	    return signal SplitControl.stopDone();                    
    }
    if (l_state == SWITCH_POWER_ON) {
      atomic state = START_TAOS;
      TOSH_uwait(1000);                                             // wait for sensor  to power up
      atomic tempvalue = 0x03;
      return call I2CPacket.writePacket(1,(char*)&tempvalue,0x01);

	   }
    else if (l_state == SWITCH_WAIT) {
     if (call Switch.set(MICAWB_LIGHT_POWER,1) != SUCCESS)  atomic state = SWITCH_WAIT;
     else    atomic state = SWITCH_POWER_ON;
    }
    return SUCCESS;
  }

  event result_t Switch.setAllDone(bool result) {
    return SUCCESS;
  }

  // no such thing
 async command result_t ADC.getContinuousData[uint8_t id]() {
    return FAIL;
  }
/******************************************************************************
 * Read Taos adc data
 * Cmd to read channel 0 + enable adc/power = 0x43
 * Cmd to read channel 1 + enable adc/power = 0x83
 *****************************************************************************/
  async command result_t ADC.getData[uint8_t id]() {
    
  
    uint8_t l_state;
//    SODbg(DBG_USR2, "TaosPhoto:getData \n"); 
    atomic l_state = state;
	   if (l_state == IDLE){
      if (id == 0){
	        atomic {
           tempvalue = 0x43;                       //read channel 0
           state = READ_0;
	        }
	 post TaosRead();
         return SUCCESS;
      }
      else if (id == 1){
		      atomic{
           tempvalue = 0x83;                      //read channel 1
           state = READ_1;
	       }
	 post TaosRead();
         return SUCCESS;
      }
    }
    atomic state = IDLE;
    return FAIL;
  }
/******************************************************************************
 * I2C write packet complete
 *  If state = START_TAOS then fire timer to wait 800msec for conversion complete
 * 
 *****************************************************************************/
  event result_t I2CPacket.writePacketDone(bool result) {
   uint8_t l_state;

    atomic l_state = state;    
	   if (l_state == START_TAOS) return call Timer.start(TIMER_ONE_SHOT, 900);
   
    if (l_state == READ_0) {
	     return call I2CPacket.readPacket(1,0x01);
	   }
	   else if (l_state == READ_1){
   	  return call I2CPacket.readPacket(1,0x01);
	  }
   return FAIL;
 }
/******************************************************************************
 * I2C read packet complete
 *  If state = 
 * 
 *****************************************************************************/

event result_t I2CPacket.readPacketDone(char length, char* data) {
   atomic
   { 
		if (state == READ_0){
//      SODbg(DBG_USR2, "TaosPhoto:getData 0, %i \n", (int)data[0]); 
			data_adc = data[0];
			post DataReady_0();
		}
		else if (state == READ_1){
//	     SODbg(DBG_USR2, "TaosPhoto:getData 1, %i \n", (int)data[0]); 
			data_adc = data[0];
			post DataReady_1();
		}
	    state = IDLE; 
    } // atomic
    return SUCCESS;
   }
/******************************************************************************
 * Timer fired.
 *  Taos ready for readout
 * 
 *****************************************************************************/
  event result_t Timer.fired() {
       atomic state = IDLE;
       signal SplitControl.startDone();                            // asb
       return SUCCESS;
  }

  
  default async event result_t ADC.dataReady[uint8_t id](uint16_t data)
  {
    return SUCCESS;
  }

}

