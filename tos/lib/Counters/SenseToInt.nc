/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: SenseToInt.nc,v 1.1.4.1 2007/04/25 23:36:58 njain Exp $
 */
 
/*
 * Authors:		Jason Hill, David Gay, Philip Levis
 * Date last modified:  6/25/02
 *
 */

/**
 * @author Jason Hill
 * @author David Gay
 * @author Philip Levis
 */


module SenseToInt {
  provides {
    interface StdControl;
  }
  uses {
    interface Timer;
    interface StdControl as TimerControl;
    interface ADC;
    interface StdControl as ADCControl;
    interface IntOutput;
  }
}
implementation {
  uint16_t reading;
  
  command result_t StdControl.init() {
    return rcombine (call ADCControl.init(), call TimerControl.init());
    return SUCCESS;
  }

  command result_t StdControl.start() {
    call ADCControl.start();
    call TimerControl.start();
    return call Timer.start(TIMER_REPEAT, 250);
  }

  command result_t StdControl.stop() {
    call ADCControl.stop();
    return call Timer.stop();
  }

  event result_t Timer.fired() {
    call ADC.getData();
    return SUCCESS;
  }

  void task outputTask() {
    uint16_t rCopy;
    atomic {
      rCopy = reading;
    }
    call IntOutput.output(rCopy >> 7);
  }
  
  async event result_t ADC.dataReady(uint16_t data) {
    atomic {
      reading = data;
    }
    post outputTask();
    return SUCCESS;
  }

  event result_t IntOutput.outputComplete(result_t success) {
    return SUCCESS;
  }
}

