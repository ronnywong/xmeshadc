/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: SensirionHumidityM.nc,v 1.1.4.1 2007/04/27 05:53:40 njain Exp $
 */

/*
 *
 * Authors:		Joe Polastre
 *
 * modified by shenxf to test mts450 sensor board , 2005/7/14
 */

includes sensorboard;
module SensirionHumidityM {
  provides {
    interface ADC as Humidity;
    interface ADC as Temperature;
    interface SplitControl;
    interface ADCError as HumidityError;
    interface ADCError as TemperatureError;
  }
  uses {
    interface ADC as HumSensor;
    interface ADC as TempSensor;
    interface ADCError as HumError;
    interface ADCError as TempError;
    interface StdControl as SensorControl;

    interface Timer;
    interface StdControl as SwitchControl;
  }
}
implementation {

//#include "SODebug.h"  
//#define DBG_USR2  0  

 
  enum {IDLE, BUSY, BUSY_0, BUSY_1, GET_SAMPLE_0, GET_SAMPLE_1,
        OPENSCK, OPENDATA, CLOSESCK, CLOSEDATA,  POWEROFF,
	MAIN_SWITCH_ON, MAIN_SWITCH_OFF, WAIT_SWITCH_ON, WAIT_SWITCH_OFF, TIMER};

uint16_t result;
char id;
char state;
  task void initDone() {
    signal SplitControl.initDone();
  }

  command result_t SplitControl.init() {
    atomic state = POWEROFF;
    call SensorControl.init();
    post initDone();
    return SUCCESS;
  }

  command result_t SplitControl.start() {
   
    atomic state = IDLE;
    call SensorControl.start() ;
	// turn the sensor on;
    HUMIDITY_MAKE_POWER_OUTPUT();
    HUMIDITY_SET_POWER();
    signal SplitControl.startDone();
    return SUCCESS;
  }

  command result_t SplitControl.stop() {
   atomic state = MAIN_SWITCH_OFF;
   //turn the sensor off
    HUMIDITY_CLEAR_POWER();
     call SensorControl.stop();
     signal SplitControl.stopDone();
    return SUCCESS;
  }

  task void switchState() {
  	char l_state;
	uint16_t l_result;
	char l_id;
  	atomic l_state = state;
	
	switch (l_state) {
		case OPENSCK:
			atomic state = OPENDATA;
        		HUMIDITY_SET_DATA();
			post switchState();
			break;
		case OPENDATA:
			atomic state = TIMER;
			call Timer.start(TIMER_ONE_SHOT, 100);
			break;
		case CLOSESCK:
			atomic state = CLOSEDATA;
          		HUMIDITY_CLEAR_DATA();
         		post switchState();
			break;	
		case CLOSEDATA:
			atomic {
        			 l_result = result;
        			 state = IDLE;
        			 l_id = id;
        	       }
	    		if (l_id == MICAWB_HUMIDITY)
	       		signal Humidity.dataReady(l_result);         //everything complete, humidity data ready
	    		else if (l_id == MICAWB_HUMIDITY_TEMP)
	       		signal Temperature.dataReady(l_result);     //everything complete, temp data ready
	       	break;
	       default:
			
        }
  	}		

  event result_t Timer.fired() {
  	uint8_t l_id;
  	
       atomic {
       	state = BUSY;
       	l_id = id;
       }
      if (l_id == MICAWB_HUMIDITY)
      {
	      //SODbg(DBG_USR2, "SensirionHumidityM.Timer.fired: get humidity data \n"); 
		 return call HumSensor.getData();
      }
      else if (l_id == MICAWB_HUMIDITY_TEMP)
      {
	      return call TempSensor.getData();
      }
      atomic state = IDLE;
      return SUCCESS;
  }


  // no such thing
async command result_t Humidity.getContinuousData() {
    return FAIL;
  }

  // no such thing
async  command result_t Temperature.getContinuousData() {
    return FAIL;
  }

async  command result_t Humidity.getData() {
	char l_state;
	atomic l_state = state;
	if (l_state == IDLE)
	{
        atomic {
	   	state = OPENSCK;
		id = MICAWB_HUMIDITY;
       	}
	HUMIDITY_SET_CLOCK();
	post switchState(); 
	return SUCCESS;
     } 
    atomic state = IDLE;
    return FAIL;
  }

async  command result_t Temperature.getData() {
      	char l_state;
	atomic l_state = state;
    if (l_state == IDLE)
    {
      atomic {
      	id = MICAWB_HUMIDITY_TEMP;
      	state = OPENSCK;
      }
	  HUMIDITY_SET_CLOCK();
	  post switchState(); 
	   return SUCCESS;
    }
    atomic state = IDLE;
    return FAIL;
  }

  default async event result_t Temperature.dataReady(uint16_t data)
  {
    return SUCCESS;
  }

 async event result_t TempSensor.dataReady(uint16_t data) {
 	char l_state;
 	
    atomic {
    	result = data;
    	l_state = state;
    }
    if (l_state == BUSY) {
      atomic state = CLOSESCK;
      HUMIDITY_CLEAR_CLOCK();
	post switchState();
	
      return SUCCESS;
			 
    }
    return SUCCESS;
  }

/******************************************************************************
 * HumSensor.dataReady
 *  -Data ready from humidity sensor
 *  -Start to turn-off SCK,SDA serial lines
 ******************************************************************************/
 async event result_t HumSensor.dataReady(uint16_t data) {
 	char l_state;
 
	atomic {
		result = data;
		l_state = state;
	}
    if (l_state == BUSY) {
      atomic state = CLOSESCK;
      HUMIDITY_CLEAR_CLOCK();
      post switchState();
      return SUCCESS;
			 
    }
    return SUCCESS;
  }

  command result_t HumidityError.enable() {
    return call HumError.enable();
  }

  command result_t HumidityError.disable() {
    return call HumError.disable();
  }

  command result_t TemperatureError.enable() {
    return call TempError.enable();
  }

  command result_t TemperatureError.disable() {
    return call TempError.disable();
  }

 event result_t HumError.error(uint8_t token) {
    atomic state = IDLE;
    call SensorControl.stop();
    return signal HumidityError.error(token);
  }

 event result_t TempError.error(uint8_t token) {
    atomic state = IDLE;
    call SensorControl.stop();
    return signal TemperatureError.error(token);
  }

  default  event result_t HumidityError.error(uint8_t token) { return SUCCESS; }

  default event result_t TemperatureError.error(uint8_t token) { return SUCCESS;
 }

}

