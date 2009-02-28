/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: HamamatsuM.nc,v 1.1.4.1 2007/04/27 05:18:33 njain Exp $
 */

/*
 *
 * Authors:		Joe Polastre
 *
 */

includes sensorboard;
module HamamatsuM {
  provides {
    interface ADC[uint8_t id];
    interface SplitControl;
  }
  uses {
    interface ADC as Hamamatsu1;
    interface ADC as Hamamatsu2;
    interface ADC as Hamamatsu3;
    interface ADC as Hamamatsu4;
    interface ADCControl;
  }
}
implementation {

  norace char state;

  enum { IDLE = 0, SAMPLE, POWEROFF };

  task void initDone() {
    signal SplitControl.initDone();
  }

  task void startDone() {
    signal SplitControl.startDone();
  }

  task void stopDone() {
    signal SplitControl.stopDone();
  }

  command result_t SplitControl.init() {
    state = POWEROFF;
    call ADCControl.init();
    post initDone();
    return SUCCESS;
  }

  command result_t SplitControl.start() {
    if(state == POWEROFF) {
      state = IDLE;
      post startDone();
      return SUCCESS;
    }
    return FAIL;
  }

  command result_t SplitControl.stop() {
    if(state == IDLE) {
      state = POWEROFF;
      post stopDone();
      return SUCCESS;
    }
    return FAIL;
  }

  // no such thing
  async command result_t ADC.getContinuousData[uint8_t id]() {
    return FAIL;
  }

  async command result_t ADC.getData[uint8_t id]() {
    if (state == IDLE)
    {
      state = SAMPLE;
      switch(id) {
      case 1: return call Hamamatsu1.getData();
      case 2: return call Hamamatsu2.getData();
      case 3: return call Hamamatsu3.getData();
      case 4: return call Hamamatsu4.getData();
      }
    }
    // state = IDLE;
    return FAIL;
  }

  default async event result_t ADC.dataReady[uint8_t id](uint16_t data)
  {
    return SUCCESS;
  }

  async event result_t Hamamatsu1.dataReady(uint16_t data){ 
    if (state == SAMPLE) {
	state = IDLE;
	signal ADC.dataReady[1](data);
    }
    return SUCCESS;
  }
  async event result_t Hamamatsu2.dataReady(uint16_t data){ 
    if (state == SAMPLE) {
	state = IDLE;
	signal ADC.dataReady[2](data);
    }
    return SUCCESS;
  }
  async event result_t Hamamatsu3.dataReady(uint16_t data){ 
    if (state == SAMPLE) {
	state = IDLE;
	signal ADC.dataReady[3](data);
    }
    return SUCCESS;
  }

  async event result_t Hamamatsu4.dataReady(uint16_t data){ 
    if (state == SAMPLE) {
	state = IDLE;
	signal ADC.dataReady[4](data);
    }
    return SUCCESS;
  }

}

