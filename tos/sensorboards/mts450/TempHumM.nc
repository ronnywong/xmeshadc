/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: TempHumM.nc,v 1.1.4.1 2007/04/27 05:53:56 njain Exp $
 */

/*
 *
 * Authors:		Mohammad Rahmim, Joe Polastre
 *
 */

module TempHumM {
  provides {
    interface StdControl;
    interface ADC as TempSensor;
    interface ADC as HumSensor;
    interface ADCError as HumError;
    interface ADCError as TempError;
  }
  uses {
    interface Timer;
    interface StdControl as TimerControl;
  }

}
implementation {
//#include "SODebug.h"  
//#define DBG_USR2  0                        //comment this out to enable debug 

  //states
  enum {READY=0, TEMP_MEASUREMENT=1, HUM_MEASUREMENT=2, POWER_OFF};

  char state;
  uint8_t timeout;
  norace uint8_t errornum;
  norace uint32_t timeval;
  int16_t data;

  bool humerror,temperror;

  char calc_crc(char current, char in) {
    return crctable[current ^ in];
  }

  task void signalHumError() {
    atomic signal HumError.error(errornum);
  }

  task void signalTempError() {
    atomic signal TempError.error(errornum);
  }
  
  task void TimerRepeat()
  {
  	call Timer.start(TIMER_REPEAT, timeval);
  }

  // Enable Mote INT3 which is INT7 on the Atmega128
  static inline void HumidityIntEnable(){
    sbi(EICRB , 7);
	   cbi(EICRB , 6);        //low level detect
	   sbi(EIMSK , 7);        //enable INT7

  }

  static inline void  ack()
  {
    HUMIDITY_MAKE_DATA_OUTPUT();
    HUMIDITY_CLEAR_DATA();
    TOSH_wait_250ns();
    HUMIDITY_SET_CLOCK();
    TOSH_wait_250ns();
    HUMIDITY_CLEAR_CLOCK();
    HUMIDITY_MAKE_DATA_INPUT();
    HUMIDITY_SET_DATA();
  }

  static inline void initseq()
  { 
    HUMIDITY_MAKE_DATA_OUTPUT();
    HUMIDITY_SET_DATA();
    HUMIDITY_CLEAR_CLOCK();   
    TOSH_wait_250ns();         
    HUMIDITY_SET_CLOCK();
    TOSH_wait_250ns();
    HUMIDITY_CLEAR_DATA();
    TOSH_wait_250ns();
    HUMIDITY_CLEAR_CLOCK();
    TOSH_wait_250ns();
    HUMIDITY_SET_CLOCK();
    TOSH_wait_250ns(); 
    HUMIDITY_SET_DATA();
    TOSH_wait_250ns(); 
    HUMIDITY_CLEAR_CLOCK();
  }

  static inline void reset()
  {
    int i;
    HUMIDITY_MAKE_DATA_OUTPUT();
    HUMIDITY_SET_DATA();
    HUMIDITY_CLEAR_CLOCK();
    for (i=0;i<9;i++) {
      HUMIDITY_SET_CLOCK();
      TOSH_wait_250ns();
      HUMIDITY_CLEAR_CLOCK();
    }
  }
/******************************************************************************
 * processCommand
 *  -Send a command to the Sensirion
 *  -Toggles SCLK and SDA serial signals to Sensirion
 *  -Start by sending bus reset command (9 clocks)
 *  -Start timer to check error condition where Sensirion doesn't complete measurement
 *  -Enable SDA as interrupt, this line goes low when Sensirion completes measurement
 ******************************************************************************/
  static inline char processCommand(int cmd)
  {
    int i;
    int CMD = cmd;
    cmd &= 0x1f;
    HUMIDITY_INT_DISABLE();
    reset();           
    initseq();              //reset the serial interface, 9 clocks
    for(i=0;i<8;i++){       //xmit addr and cmd data
      if(cmd & 0x80) HUMIDITY_SET_DATA();
      else HUMIDITY_CLEAR_DATA();
      cmd = cmd << 1 ;
      HUMIDITY_SET_CLOCK();
      TOSH_wait_250ns();              
      TOSH_wait_250ns();              
      HUMIDITY_CLEAR_CLOCK();        
    }
    HUMIDITY_MAKE_DATA_INPUT(); //make SDA an input
    HUMIDITY_SET_DATA();
    TOSH_wait_250ns();
    HUMIDITY_SET_CLOCK();
    TOSH_wait_250ns();
    if(HUMIDITY_GET_DATA())    //if SDA hi then Sensirion is not responding
    { 
      //SODbg(DBG_USR2, "TempHumM.processCommand: No response from Sensirion \n"); 
	  
	     reset(); 
      atomic errornum = 2;
      if ((CMD == TOSH_HUMIDITY_ADDR) && (humerror == TRUE))
        post signalHumError();
      else if ((CMD == TOSH_HUMIDTEMP_ADDR) && (temperror == TRUE))
        post signalTempError();
      return 0; 
    }
    TOSH_wait_250ns();
    HUMIDITY_CLEAR_CLOCK();
    if((CMD == TOSH_HUMIDITY_ADDR) || (CMD == TOSH_HUMIDTEMP_ADDR) ){
      if ((CMD == TOSH_HUMIDITY_ADDR) && (humerror == TRUE)) {
        //SODbg(DBG_USR2, "TempHumM.processCommand: cmd complete, starting timer for measurement \n"); 
		      atomic timeout = 0;
        timeval=HUMIDITY_TIMEOUT_MS;
        post TimerRepeat();
      }
      else if ((CMD == TOSH_HUMIDTEMP_ADDR) && (temperror == TRUE)) {
      atomic  timeout = 0;
        timeval=HUMIDITY_TIMEOUT_MS;
        post TimerRepeat();
      }
 //    HUMIDITY_INT_ENABLE();
       HumidityIntEnable();
    }
    return 1;
  }

  command result_t StdControl.init() {
    atomic{
       humerror = FALSE;
       temperror = FALSE;
       state = POWER_OFF;
    }
    return call TimerControl.init();
  }

  command result_t StdControl.start() {
    atomic state=READY;
    HUMIDITY_CLEAR_CLOCK();
    HUMIDITY_MAKE_CLOCK_OUTPUT();
    HUMIDITY_SET_DATA();
    HUMIDITY_MAKE_DATA_INPUT();
    HUMIDITY_INT_DISABLE();
	   cbi(EICRA, ISC30);              //enable falling edge interrupt
    sbi(EICRA, ISC31);
    reset();
    processCommand(TOSH_HUMIDITY_RESET);
    return SUCCESS;
  }

  command result_t StdControl.stop() {
    atomic state = POWER_OFF;
    HUMIDITY_CLEAR_CLOCK();
    HUMIDITY_MAKE_CLOCK_INPUT();
    HUMIDITY_MAKE_DATA_INPUT();
    HUMIDITY_CLEAR_DATA();
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
/******************************************************************************
 * readSensor
 *  -Read data from Sensirion
 ******************************************************************************/
  task void readSensor()
  {
    char i;
    char CRC=0;  
    data=0; 

    //SODbg(DBG_USR2, "TempHumM.readSensor: reading data \n"); 
    
   	call Timer.stop();

    for(i=0;i<8;i++){
      HUMIDITY_SET_CLOCK();   
      TOSH_wait_250ns();
      data |= HUMIDITY_GET_DATA();
      data = data << 1;
      HUMIDITY_CLEAR_CLOCK();
    }
    ack();
    for(i=0;i<8;i++){
      HUMIDITY_SET_CLOCK();   
      TOSH_wait_250ns();
      data |= HUMIDITY_GET_DATA();
      //the last byte of data should not be shifted
      if(i!=7) data = data << 1;  
      HUMIDITY_CLEAR_CLOCK();
    }
    ack();
    for(i=0;i<8;i++){
      HUMIDITY_SET_CLOCK();   
      TOSH_wait_250ns();
      CRC |= HUMIDITY_GET_DATA();
      if(i!=7)CRC = CRC << 1;
      HUMIDITY_CLEAR_CLOCK();
    }
    // nack with high as it should be for the CRC ack
    HUMIDITY_MAKE_DATA_OUTPUT();
    HUMIDITY_SET_DATA();          
    TOSH_wait_250ns();
    HUMIDITY_SET_CLOCK();
    TOSH_wait_250ns();
    HUMIDITY_CLEAR_CLOCK();
  
    atomic{
      if(state==TEMP_MEASUREMENT)     signal TempSensor.dataReady(data);
      else if(state==HUM_MEASUREMENT) signal HumSensor.dataReady(data);
      state=READY;
    }
  }

/******************************************************************************
 * TOSH_SIGNAL(HUMIDITY_INTERRUPT)
 *  -Enter here when Sensirion completes measurement
 *  -Sensirion SDA line goes low when it completes measurement
 ******************************************************************************/
// #ifndef PLATFORM_PC
  TOSH_SIGNAL(HUMIDITY_INTERRUPT)
  {

//spurious int?
    if(HUMIDITY_GET_DATA()){
     //call Leds.yellowOff();
     //call Leds.yellowOn();
     //call Leds.yellowOff();
	 //call Leds.yellowOn();
	 return;
    }
    
	HUMIDITY_INT_DISABLE();
    //SODbg(DBG_USR2, "TempHumM.TOSH_SIGNAL(HUMIDITY INTERRUPT): measurment complete \n"); 
    //call Leds.redOff();
    //call Leds.yellowOff();
    //call Leds.yellowOn();
    //call Leds.yellowOff();
    post readSensor();
    return;
  }
// #endif



  // no such thing
async  command result_t TempSensor.getContinuousData() {
    return FAIL;
  }

  // no such thing
 async  command result_t HumSensor.getContinuousData() {
    return FAIL;
  }

  async command result_t TempSensor.getData()
  {
    atomic{
      if(state!= READY ) reset();
   	  state=TEMP_MEASUREMENT;
      processCommand(TOSH_HUMIDTEMP_ADDR);
    }
    return SUCCESS;
  }

  async command result_t HumSensor.getData()
  {
   atomic{
      if(state!= READY )  reset();
	     //SODbg(DBG_USR2, "TempHumM.getData: starting to get humidity data \n"); 
	     state=HUM_MEASUREMENT;
      processCommand(TOSH_HUMIDITY_ADDR);
   }
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
/******************************************************************************
 * Timer.fired
 *  Sensirion should lower the data line to signal that the measurement is done
 *  This timer event used to signal a timout that senirion did not complete
 ******************************************************************************/
  event result_t Timer.fired() {
   atomic{
   timeout++;
	  if (timeout > HUMIDITY_TIMEOUT_TRIES) {
 		  if ((state == HUM_MEASUREMENT) && (humerror == TRUE)) {
          call Timer.stop();
          HUMIDITY_INT_DISABLE();
          state = READY;
          errornum = 1;
          post signalHumError();
          //SODbg(DBG_USR2, "TempHumM.Timer.fired: No response from Sensirion humidity   \n"); 
     }
     else if ((state == TEMP_MEASUREMENT) && (temperror == TRUE)) {
          call Timer.stop();
          HUMIDITY_INT_DISABLE();
          state = READY;
          errornum = 1;
          post signalTempError();
          //SODbg(DBG_USR2, "TempHumM.Timer.fired: No response from Sensirion temp   \n"); 
      }
    }
    } //atomic
    return SUCCESS;
  }

  default event result_t HumError.error(uint8_t token) { return SUCCESS; }

  default event result_t TempError.error(uint8_t token) { return SUCCESS; }

}
