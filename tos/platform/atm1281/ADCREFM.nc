/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: ADCREFM.nc,v 1.3.2.2 2007/04/26 00:04:03 njain Exp $
 */
/*
 *
 * Authors:		Jason Hill, David Gay, Philip Levis, Phil Buonadonna
 * Version:		$Id: ADCREFM.nc,v 1.3.2.2 2007/04/26 00:04:03 njain Exp $
 *
 */

/*  OS component abstraction of the analog to digital converter using a 
 *  fixed reference input.  I assumes the presence of a TOS_ADC_BANDGAP_PORT
 *  to provide that referenced reading. This module was designed to 
 *  accomodate platforms that use varying/unstable ADC references. It also
 *  works around limitations where the measured variable cannot be larger than
 *  the actual ADC reference
 *
 *  The conversion result is given by the equation:
 * 
 *	   ADC = (Vport * 1024) / Vref
 * 
 *  Where Vport can be between zero and (2^6-1)*Vref (I.E. Vport CAN be larger
 *  than Vref)
 * 
 *  Note: On the ATmega128, Vref (using this module) is 1.23 Volts
 */

/*  ADC_INIT command initializes the device */
/*  ADC_GET_DATA command initiates acquiring a sensor reading. */
/*  It returns immediately.   */
/*  ADC_DATA_READY is signaled, providing data, when it becomes */
/*  available. */
/*  Access to the sensor is performed in the background by a separate */
/* TOS task. */

module ADCREFM 
{
  provides {
    interface ADC[uint8_t port];		// The RAW ADC interface
    interface ADC as CalADC[uint8_t port];
    interface ADCControl;
  }
  uses {
    interface HPLADC;
    interface Timer;
  }

}

implementation
{

//   enum {
//     IDLE = 0,
//     SINGLE_CONVERSION = 1,
//     CONTINUOUS_CONVERSION = 2,
//   };

  uint16_t ReqPort;
  uint16_t ReqVector;
  uint16_t ContReqMask;
  uint16_t CalReqMask;
  uint32_t RefVal;

  task void CalTask() {

    call ADCControl.manualCalibrate();

    return;
  }

  command result_t ADCControl.init() {
    atomic {
      ReqPort = 0;
      ReqVector = ContReqMask = CalReqMask= 0;
      RefVal = 381; // Reference value assuming 3.3 Volt power source
    }
    dbg(DBG_BOOT, ("ADC initialized.\n"));
    
    return call HPLADC.init();
  }

  command result_t ADCControl.setSamplingRate(uint8_t rate) {
    return call HPLADC.setSamplingRate(rate);
  }

  command result_t ADCControl.bindPort(uint8_t port, uint8_t adcPort) {
    return call HPLADC.bindPort(port, adcPort);
  }

  default async event result_t ADC.dataReady[uint8_t port](uint16_t data) {
    return FAIL; // ensures ADC is disabled if no handler
  }

  default async event result_t CalADC.dataReady[uint8_t port](uint16_t data) {
    return FAIL; // ensures ADC is disabled if no handler
  }

  event result_t Timer.fired() {

    post CalTask();

    return SUCCESS;
  }

  async event result_t HPLADC.dataReady(uint16_t data) {
    uint16_t doneValue = data;
    uint8_t donePort;
    uint8_t nextPort = 0xff;
    bool fCalResult = FALSE;
    result_t Result = SUCCESS;
    uint32_t batTransTemp;
    // BEGIN atomic
    atomic { 
      if (ReqPort == TOS_ADC_BANDGAP_PORT) {
        RefVal = data;
      }
      donePort = ReqPort;
      // Check to see if this port has requested continous conversio
      if (((1<<donePort) & ContReqMask) == 0) { 
	ReqVector ^= (1<<donePort); 
      }
      
      // Check for calibrated result
      if ((1<<donePort) & CalReqMask) {
	fCalResult = TRUE;
	if (((1<<donePort) & ContReqMask) == 0) { 
	  CalReqMask ^= (1<<donePort);
	}
      }

      if (ReqVector) {
	// Always ensure we rotate through the reference port 
	//ReqVector |= (1<<TOS_ADC_BANDGAP_PORT); 
	do {
	  ReqPort++;
          ReqPort = (ReqPort == TOSH_ADC_PORTMAPSIZE) ? 0 : ReqPort;
	} while (((1<<ReqPort) & ReqVector) == 0);
	nextPort = ReqPort;
      }
    }
    // END atomic

    if (nextPort != 0xff) {
      call HPLADC.samplePort(nextPort);  // This function is interupt-safe  
    }
  
    dbg(DBG_ADC, "adc_tick: port %d with value %i \n", donePort, (int)data);
    if (donePort != TOS_ADC_BANDGAP_PORT) {
      if (fCalResult) {
	uint32_t tmp = (uint32_t) data;
	tmp = tmp << 10;  // data * 1024
	atomic tmp = (tmp / RefVal);  // doneValue = data * 1024/ref
	doneValue = (uint16_t) tmp;
	Result = signal CalADC.dataReady[donePort](doneValue);
      }
      else {      
     if(donePort==TOS_ADC_VOLTAGE_PORT){
      	batTransTemp=doneValue;
      	doneValue = (batTransTemp*1223)/1100;
        }
	Result = signal ADC.dataReady[donePort](doneValue);
      }
    }
   
    atomic {
      if ((ContReqMask & (1<<donePort)) && (Result == FAIL)) {
      ContReqMask ^= (1<<donePort);
      }
    }

    return SUCCESS;
  }

 
  result_t startGet(uint8_t port) {
    uint16_t PortMask, oldReqVector = 1;
    result_t Result = SUCCESS;
    
    PortMask = (1<<port);

    if ((PortMask & ReqVector) != 0) {
      // Already a pending request on this port
      Result = FAIL;
    }
    else {
      oldReqVector = ReqVector;
      ReqVector |= PortMask;
      if (oldReqVector == 0) {
	if((Result = call HPLADC.samplePort(port))){
  	    ReqPort = port;
	}
      }
    }
    
    return Result;

  }

  async command result_t ADC.getData[uint8_t port]() {
    result_t Result;
    if (port > TOSH_ADC_PORTMAPSIZE) {
      return FAIL;
    }

    atomic {
      Result = startGet(port);
    }
    return Result;
  }

  async command result_t CalADC.getData[uint8_t port]() {
    result_t Result = SUCCESS;

    if (port > TOSH_ADC_PORTMAPSIZE) {
      return FAIL;
    }
    atomic {
      CalReqMask |= (1<<port);
      Result = startGet(port);
      if (Result == FAIL) {
	CalReqMask ^= (1<<port);
      }
    }
    return Result;
  }

  async command result_t ADC.getContinuousData[uint8_t port]() {
    result_t Result = SUCCESS;

    if (port > TOSH_ADC_PORTMAPSIZE) {
      return FAIL;
    }
    atomic {
      ContReqMask |= (1<<port);
      Result = startGet(port);
      if (Result == FAIL) {
	ContReqMask ^= (1<<port);
      }
    }
    return Result;
  }

  async command result_t CalADC.getContinuousData[uint8_t port]() {
    result_t Result = SUCCESS;

    if (port > TOSH_ADC_PORTMAPSIZE) {
      return FAIL;
    }
    atomic {
      ContReqMask |= (1<<port);
      CalReqMask  |= (1<<port);
      Result = startGet(port);
      if (Result == FAIL) {
	ContReqMask ^= (1<<port);
	CalReqMask ^= (1<<port);
      }
    }
    return Result;
  }

  async command result_t ADCControl.manualCalibrate() {
    result_t Result;

    atomic {
      Result = startGet(TOS_ADC_BANDGAP_PORT);
    }

    return Result;

  }

  async command result_t ADCControl.autoCalibrate(uint16_t interval) {
    result_t Result;

    if (interval == 0) {
      Result = call Timer.stop();
    }
    else {
      Result = call Timer.start(TIMER_REPEAT,interval);
    }

    return Result;

  }

}
