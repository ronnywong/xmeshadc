/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: IntersemaPressureM.nc,v 1.1.4.1 2007/04/27 05:20:13 njain Exp $
 */

/*
 *
 * Authors:		Joe Polastre
 *
 * $Id: IntersemaPressureM.nc,v 1.1.4.1 2007/04/27 05:20:13 njain Exp $
 */

includes sensorboard;
module IntersemaPressureM {
  provides {
    interface ADC as Temperature;
    interface ADC as Pressure;
    interface ADCError as TemperatureError;
    interface ADCError as PressureError;
    interface SplitControl;
    interface Calibration;
  }
  uses {
    interface StdControl as LowerControl;
    interface Calibration as LowerCalibrate;
    interface ADC as LowerPressure;
    interface ADC as LowerTemp;
    interface ADCError as PressError;
    interface ADCError as TempError;
    interface Timer;
    interface StdControl as TimerControl;
    interface Leds;
  }
}
implementation {

  enum {POWER_OFF = 0, IDLE, SAMPLE, WARM_UP};

  norace char state;
  norace uint32_t average_total;
  norace uint8_t counter;

  task void initDone() {
	signal SplitControl.initDone();
  }

  task void stopDone() {
 	signal SplitControl.stopDone();
  }
  
  task void LowerStart()
  {
  call LowerControl.start();
  }
  task void LowerStop()
  {
  call LowerControl.stop();
  }

  async event result_t LowerTemp.dataReady(uint16_t data) {
    // each sensor should be sampled 8 times and averaged
    if (state == SAMPLE) {
        counter++;
	//call Leds.greenToggle();
        average_total += data;
        if (counter < 8) {
          call LowerTemp.getData();
          return SUCCESS;
        }
        else {
          uint16_t value = ((average_total >> 3) & 0x0FFFF);
	  //call Leds.greenOff();
          post LowerStop();
	  state = IDLE;
	  signal Temperature.dataReady(value);
        }
    }
    return SUCCESS;
  }

 async  event result_t LowerPressure.dataReady(uint16_t data) {
    if (state == SAMPLE) {
        counter++;
        average_total += data;
        if (counter < 8) {
	  //call Leds.redToggle();
          call LowerPressure.getData();
          return SUCCESS;
        }
        else {
          uint16_t value = ((average_total >> 3) & 0x0FFFF);
	  //call Leds.redOff();
          post LowerStop();
	  state = IDLE;
	  signal Pressure.dataReady(value);
        }
    }
    return SUCCESS;
  }

  command result_t SplitControl.init() {
    state = POWER_OFF;
    call LowerControl.init();
    call TimerControl.init();
    post initDone();
    return SUCCESS;
  }

  command result_t SplitControl.start() {
    if(state == POWER_OFF) {
      PRESSURE_POWER_ON();
      state = WARM_UP;
      call Timer.start(TIMER_ONE_SHOT, 500);
      return SUCCESS;
    }
    return FAIL;
  }

  command result_t SplitControl.stop() {
    if(state == IDLE) {
      state = POWER_OFF;
      call LowerControl.stop();
      PRESSURE_POWER_OFF();
      post stopDone();
      return SUCCESS;
    }
    return FAIL;
  }

  event result_t Timer.fired() {
   if (state == WARM_UP) {
     state = IDLE;
     signal SplitControl.startDone();
   }
   return SUCCESS;
  }

  // no such thing
  async command result_t Pressure.getContinuousData() {
    return FAIL;
  }

  // no such thing
  async command result_t Temperature.getContinuousData() {
    return FAIL;
  }

  command result_t Calibration.getData() {
    if (state == IDLE)
    {
      call LowerControl.start();
      state = SAMPLE;
      call LowerCalibrate.getData();
      return SUCCESS;
    }
    return FAIL;
  }

  async command result_t Temperature.getData() {
    if (state == IDLE)
    {
      counter = 0;
      average_total = 0;
      post LowerStart();
      state = SAMPLE;
      call LowerTemp.getData();
      return SUCCESS;
    }
    return FAIL;
  }

  async command result_t Pressure.getData() {
    if (state == IDLE)
    {
      counter = 0;
      average_total = 0;
      post LowerStart();
      state = SAMPLE;
      call LowerPressure.getData();
      return SUCCESS;
    }
    return FAIL;
  }

  event result_t LowerCalibrate.dataReady(char word, uint16_t value) {
    // on the last byte of calibration data, shut down the I/O interface
    if (word == 4) {
      call LowerControl.stop();
      state = IDLE;
      signal Calibration.dataReady(word, value);
    }
    else {
      call LowerControl.stop();
      signal Calibration.dataReady(word, value);
    }
    return SUCCESS;
  }

  command result_t PressureError.enable() {
    return call PressError.enable();
  }

  command result_t PressureError.disable() {
    return call PressError.disable();
  }

  command result_t TemperatureError.enable() {
    return call TempError.enable();
  }

  command result_t TemperatureError.disable() {
    return call TempError.disable();
  }

  event result_t PressError.error(uint8_t token) {
    call LowerControl.stop();
    state = IDLE;
    return signal PressureError.error(token);
  }

  event result_t TempError.error(uint8_t token) {
    call LowerControl.stop();
    state = IDLE;
    return signal TemperatureError.error(token);
  }

  default event result_t PressureError.error(uint8_t token) { return SUCCESS; }

  default event result_t TemperatureError.error(uint8_t token) { return SUCCESS; }

  default event result_t Calibration.dataReady(char word, uint16_t value) {
    return SUCCESS;
  }

  default async event result_t Temperature.dataReady(uint16_t data)
  {
    return SUCCESS;
  }

  default async event result_t Pressure.dataReady(uint16_t data)
  {
    return SUCCESS;
  }

}
