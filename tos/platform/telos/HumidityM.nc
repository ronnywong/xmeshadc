/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: HumidityM.nc,v 1.1.4.1 2007/04/26 22:20:58 njain Exp $
 */
 
/*
 *
 * Authors:		Joe Polastre
 *
 * $Id: HumidityM.nc,v 1.1.4.1 2007/04/26 22:20:58 njain Exp $
 */

module HumidityM {
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
    interface StdControl as BusControl;

    interface StdControl as TimerControl;
    interface Timer;
  }
}
implementation {

  norace char state;
  norace char id;

  enum { IDLE = 0, WARM_UP, POWER_OFF, SAMPLE, 
         MICAWB_HUMIDITY, MICAWB_HUMIDITY_TEMP, WAIT_FOR_BUS };

  task void initDone() {
    signal SplitControl.initDone();
  }

  task void startDone() {
    signal SplitControl.startDone();
  }

  task void stopDone() {
    signal SplitControl.stopDone();
  }
  
  task void sensorStart()
  {
	  call SensorControl.start();
	  call Timer.start(TIMER_ONE_SHOT, 11);
  }
  task void sensorStop()
  {
  	call SensorControl.stop();
  }

  command result_t SplitControl.init() {
    state = POWER_OFF;
    call TimerControl.init();
    call SensorControl.init();
    post initDone();
    return SUCCESS;
  }

  command result_t SplitControl.start() {
    // turn the sensor on
    TOSH_MAKE_HUM_PWR_OUTPUT();
    TOSH_SET_HUM_PWR_PIN();
    state = WARM_UP;
    call Timer.start(TIMER_ONE_SHOT, 80);
    return SUCCESS;
  }

  command result_t SplitControl.stop() {
    state = POWER_OFF;
    // turn the sensor off
    call SensorControl.stop();
    TOSH_CLR_HUM_PWR_PIN();
    post stopDone();
    return SUCCESS;
  }

  event result_t Timer.fired() {
    if (state == WARM_UP) {
      state = IDLE;
      post startDone();
    }
    else if (state == SAMPLE) {
      if (id == MICAWB_HUMIDITY) {
        return call HumSensor.getData();
      }
      else if (id == MICAWB_HUMIDITY_TEMP)
        return call TempSensor.getData();
    }
    return SUCCESS;
  }

  // no such thing
  async command result_t Humidity.getContinuousData() {
    return FAIL;
  }

  // no such thing
  async command result_t Temperature.getContinuousData() {
    return FAIL;
  }

  async command result_t Humidity.getData() {
    if (state == IDLE)
    {
      state = SAMPLE;
      id = MICAWB_HUMIDITY;
      post sensorStart();
      return SUCCESS;
    }
//state = IDLE;
    return FAIL;
  }

  async command result_t Temperature.getData() {
    if (state == IDLE)
    {
      state = SAMPLE;
      id = MICAWB_HUMIDITY_TEMP;
      post sensorStart();
      return SUCCESS;
    }
    return FAIL;
  }

  default async event result_t Humidity.dataReady(uint16_t data)
  {
    return SUCCESS;
  }

  default async event result_t Temperature.dataReady(uint16_t data)
  {
    return SUCCESS;
  }

  async event result_t TempSensor.dataReady(uint16_t data) {
    if (state == SAMPLE) {
	state = IDLE;
        post sensorStop();
	signal Temperature.dataReady(data);
    }
    return SUCCESS;
  }

  async event result_t HumSensor.dataReady(uint16_t data) {
    if (state == SAMPLE) {
	state = IDLE;
        post sensorStop();
	signal Humidity.dataReady(data);
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
    state = IDLE;
    call SensorControl.stop();
    return signal HumidityError.error(token);
  }

  event result_t TempError.error(uint8_t token) {
    state = IDLE;
    call SensorControl.stop();
    return signal TemperatureError.error(token);
  }

  default event result_t HumidityError.error(uint8_t token) { return SUCCESS; }

  default event result_t TemperatureError.error(uint8_t token) { return SUCCESS; }

}

