/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: AccelM.nc,v 1.1.4.1 2007/04/27 05:17:59 njain Exp $
 */

/*
 *
 * Authors:		Joe Polastre
 *
 */

includes sensorboard;

module AccelM
{
  provides {
    interface ADC[uint8_t id];
    interface SplitControl;
  }
  uses {
    interface ADC as Accel1;
    interface ADC as Accel2;
    interface ADCControl;
    interface Timer;
    interface StdControl as TimerControl;
  }
}

implementation
{

  norace char state;

  enum { IDLE = 0, WARM_UP, SAMPLE, POWEROFF };

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
    ACCEL_POWER_OFF();
    call ADCControl.init();
    call TimerControl.init();
    post initDone();
    return SUCCESS;
  }

  command result_t SplitControl.start() {
    if(state == POWEROFF) {
      ACCEL_POWER_ON();
      state = WARM_UP;
      call Timer.start(TIMER_ONE_SHOT, 10);
      return SUCCESS;
    }
    return FAIL;
  }

  command result_t SplitControl.stop() {
    if(state == IDLE) {
      state = POWEROFF;
      ACCEL_POWER_OFF();
      post stopDone();
      return SUCCESS;
    }
    return FAIL;
  }

  event result_t Timer.fired() {
    if (state == WARM_UP) {
      state = IDLE;
      post startDone();
    }
    return SUCCESS;
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
      case 1: return call Accel1.getData();
      case 2: return call Accel2.getData();
      }
    }
    //state = IDLE;
    return FAIL;
  }

  default async event result_t ADC.dataReady[uint8_t id](uint16_t data)
  {
    return SUCCESS;
  }

  async event result_t Accel1.dataReady(uint16_t data){ 
    if (state == SAMPLE) {
	state = IDLE;
	signal ADC.dataReady[1](data);
    }
    return SUCCESS;
  }
  async event result_t Accel2.dataReady(uint16_t data){ 
    if (state == SAMPLE) {
	state = IDLE;
	signal ADC.dataReady[2](data);
    }
    return SUCCESS;
  }

}

