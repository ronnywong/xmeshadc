/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: IntTempHumM.nc,v 1.1.4.1 2007/04/27 05:19:40 njain Exp $
 */

/*
 *
 * Authors:		Mohammad Rahmim, Joe Polastre
 *
 */

module IntTempHumM
{
  provides {
    interface StdControl;
    interface ADC as TempSensor;
    interface ADC as HumSensor;
    interface ADCError as HumError;
    interface ADCError as TempError;
  }
  uses {
    interface Leds;
    interface Timer;
    interface StdControl as TimerControl;
  }
}

implementation
{
  //states
  enum {READY=0, TEMP_MEASUREMENT=1, HUM_MEASUREMENT=2, POWER_OFF};

  norace char state;
  norace uint8_t timeout;
  norace uint8_t errornum;
  norace uint32_t timeval;
  int16_t data;

  norace bool humerror,temperror;

  task void signalHumError() {
    signal HumError.error(errornum);
  }

  task void signalTempError() {
    signal TempError.error(errornum);
  }
  
  task void TimerRepeat()
  {
  	call Timer.start(TIMER_REPEAT, timeval);
  }

  static inline void  ack()
  {
    INTHUMIDITY_MAKE_DATA_OUTPUT();
    INTHUMIDITY_CLEAR_DATA();
    TOSH_wait_250ns();
    INTHUMIDITY_SET_CLOCK();
    TOSH_wait_250ns();
    INTHUMIDITY_CLEAR_CLOCK();
    INTHUMIDITY_MAKE_DATA_INPUT();
    INTHUMIDITY_SET_DATA();
  }

  static inline void initseq()
  { 
    HUMIDITY_MAKE_DATA_OUTPUT();
    INTHUMIDITY_SET_DATA();
    INTHUMIDITY_CLEAR_CLOCK();   
    TOSH_wait_250ns();         
    INTHUMIDITY_SET_CLOCK();
    TOSH_wait_250ns();
    INTHUMIDITY_CLEAR_DATA();
    TOSH_wait_250ns();
    INTHUMIDITY_CLEAR_CLOCK();
    TOSH_wait_250ns();
    INTHUMIDITY_SET_CLOCK();
    TOSH_wait_250ns(); 
    INTHUMIDITY_SET_DATA();
    TOSH_wait_250ns(); 
    INTHUMIDITY_CLEAR_CLOCK();
  }

  static inline void reset()
  {
    int i;
    INTHUMIDITY_MAKE_DATA_OUTPUT();
    INTHUMIDITY_SET_DATA();
    INTHUMIDITY_CLEAR_CLOCK();
    for (i=0;i<9;i++) {
      INTHUMIDITY_SET_CLOCK();
      TOSH_wait_250ns();
      INTHUMIDITY_CLEAR_CLOCK();
    }
  }

  static inline char processCommand(int cmd)
  {
    int i;
    int CMD = cmd;
    cmd &= 0x1f;
    INTHUMIDITY_INT_DISABLE();
    reset();           
    initseq();        //sending the init sequence
    for(i=0;i<8;i++){
      if(cmd & 0x80) INTHUMIDITY_SET_DATA();
      else INTHUMIDITY_CLEAR_DATA();
      cmd = cmd << 1 ;
      INTHUMIDITY_SET_CLOCK();
      TOSH_wait_250ns();              
      TOSH_wait_250ns();              
      INTHUMIDITY_CLEAR_CLOCK();        
    }
    INTHUMIDITY_MAKE_DATA_INPUT();
    INTHUMIDITY_SET_DATA();
    TOSH_wait_250ns();
    INTHUMIDITY_SET_CLOCK();
    TOSH_wait_250ns();
    if(INTHUMIDITY_GET_DATA()) 
    { 
      reset(); 
      errornum = 2;
      if ((CMD == TOSH_INTHUMIDITY_ADDR) && (humerror == TRUE))
        post signalHumError();
      else if ((CMD == TOSH_INTHUMIDTEMP_ADDR) && (temperror == TRUE))
        post signalTempError();
      return 0; 
    }
    TOSH_wait_250ns();
    INTHUMIDITY_CLEAR_CLOCK();
    if((CMD == TOSH_INTHUMIDITY_ADDR) || (CMD == TOSH_INTHUMIDTEMP_ADDR) ){
      if ((CMD == TOSH_INTHUMIDITY_ADDR) && (humerror == TRUE)) {
        timeout = 0;
        timeval=HUMIDITY_TIMEOUT_MS;
	post TimerRepeat();
      }
      else if ((CMD == TOSH_INTHUMIDTEMP_ADDR) && (temperror == TRUE)) {
        timeout = 0;
        timeval=HUMIDITY_TIMEOUT_MS;
	post TimerRepeat();
      }
      INTHUMIDITY_INT_ENABLE();
    }
    return 1;
  }

  command result_t StdControl.init() {
    humerror = FALSE;
    temperror = FALSE;
    state = POWER_OFF;
    return call TimerControl.init();
  }

  command result_t StdControl.start() {
    state=READY;
    INTHUMIDITY_CLEAR_CLOCK();
    INTHUMIDITY_MAKE_CLOCK_OUTPUT();
    INTHUMIDITY_SET_DATA();
    INTHUMIDITY_MAKE_DATA_INPUT();
    INTHUMIDITY_INT_DISABLE();
    reset();
    processCommand(TOSH_INTHUMIDITY_RESET);
    return SUCCESS;
  }

  command result_t StdControl.stop() {
    state = POWER_OFF;
    INTHUMIDITY_CLEAR_CLOCK();
    INTHUMIDITY_MAKE_CLOCK_INPUT();
    INTHUMIDITY_MAKE_DATA_INPUT();
    INTHUMIDITY_CLEAR_DATA();
    return SUCCESS;
  }

  default async event result_t TempSensor.dataReady(uint16_t tempData) 
  {
    return SUCCESS;
  }

  default async event result_t HumSensor.dataReady(uint16_t humData) 
  {
    return SUCCESS;
  }

  task void readSensor()
  {
    char i;
    char CRC=0;  
    data=0; 

    call Timer.stop();

    for(i=0;i<8;i++){
      INTHUMIDITY_SET_CLOCK();   
      TOSH_wait_250ns();
      data |= INTHUMIDITY_GET_DATA();
      data = data << 1;
      INTHUMIDITY_CLEAR_CLOCK();
    }
    ack();
    for(i=0;i<8;i++){
      INTHUMIDITY_SET_CLOCK();   
      TOSH_wait_250ns();
      data |= INTHUMIDITY_GET_DATA();
      //the last byte of data should not be shifted
      if(i!=7) data = data << 1;  
      INTHUMIDITY_CLEAR_CLOCK();
    }
    ack();
    for(i=0;i<8;i++){
      INTHUMIDITY_SET_CLOCK();   
      TOSH_wait_250ns();
      CRC |= INTHUMIDITY_GET_DATA();
      if(i!=7)CRC = CRC << 1;
      INTHUMIDITY_CLEAR_CLOCK();
    }
    // nack with high as it should be for the CRC ack
    INTHUMIDITY_MAKE_DATA_OUTPUT();
    INTHUMIDITY_SET_DATA();          
    TOSH_wait_250ns();
    INTHUMIDITY_SET_CLOCK();
    TOSH_wait_250ns();
    INTHUMIDITY_CLEAR_CLOCK();

    // some code that calculated crcs used to be here but
    // it was commented out and some related dead code was
    // causing a 256 byte crctable to be linked in.

    if(state==TEMP_MEASUREMENT) {
      signal TempSensor.dataReady(data);
    } else if(state==HUM_MEASUREMENT) {
      signal HumSensor.dataReady(data);
    }
    state=READY;
  }

#ifndef PLATFORM_PC
  TOSH_SIGNAL(INTHUMIDITY_INTERRUPT)
  {
    INTHUMIDITY_INT_DISABLE();
    post readSensor();
    return;
  }
#endif

  // no such thing
  async command result_t TempSensor.getContinuousData() {
    return FAIL;
  }

  // no such thing
  async command result_t HumSensor.getContinuousData() {
    return FAIL;
  }

  async command result_t TempSensor.getData()
  {
    if(state!= READY ){
      reset();
    }
    state=TEMP_MEASUREMENT;
    processCommand(TOSH_INTHUMIDTEMP_ADDR);
    return SUCCESS;
  }

  async command result_t HumSensor.getData()
  {
    if(state!= READY ){
      reset();
    }
    state=HUM_MEASUREMENT;
    processCommand(TOSH_INTHUMIDITY_ADDR);
    return SUCCESS;
  }

  command result_t HumError.enable() {
    if (humerror == FALSE) {
      atomic humerror = TRUE;
      return SUCCESS;
    }
    return FAIL;
  }

  command result_t TempError.enable() {
    if (temperror == FALSE) {
      atomic temperror = TRUE;
      return SUCCESS;
    }
    return FAIL;
  }

  command result_t HumError.disable() {
    if (humerror == TRUE) {
      atomic humerror = FALSE;
      return SUCCESS;
    }
    return FAIL;
  }

  command result_t TempError.disable() {
    if (temperror == TRUE) {
      atomic temperror = FALSE;
      return SUCCESS;
    }
    return FAIL;
  }

  event result_t Timer.fired() {
    timeout++;
    if (timeout > HUMIDITY_TIMEOUT_TRIES) {
      if ((state == HUM_MEASUREMENT) && (humerror == TRUE)) {
        call Timer.stop();
        INTHUMIDITY_INT_DISABLE();
        state = READY;
        errornum = 1;
        post signalHumError();
      }
      else if ((state == TEMP_MEASUREMENT) && (temperror == TRUE)) {
        call Timer.stop();
        INTHUMIDITY_INT_DISABLE();
        state = READY;
        errornum = 1;
        post signalTempError();
      }
    }
    return SUCCESS;
  }

  default event result_t HumError.error(uint8_t token) { return SUCCESS; }

  default event result_t TempError.error(uint8_t token) { return SUCCESS; }

}
