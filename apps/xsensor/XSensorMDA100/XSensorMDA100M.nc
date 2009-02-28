/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: XSensorMDA100M.nc,v 1.3.4.1 2007/04/26 20:25:07 njain Exp $
 */

/** 
 * XSensor single-hop application for MDA100 sensorboard.
 *
 * @author Pi Peng
 */

/******************************************************************************
 *
 *****************************************************************************/
#include "appFeatures.h"
includes sensorboard;
module XSensorMDA100M {
  provides {
    interface StdControl;
  }
  uses {
  
//communication
	interface StdControl as CommControl;
	interface SendMsg as Send;
	interface ReceiveMsg as Receive;

// Battery                              
    interface ADC as ADCBATT;           
    interface StdControl as BattControl;

//Temp                                              
	interface StdControl as TempControl;        
	interface ADC as Temperature;               
                                                    
//Light                                             
	interface StdControl as PhotoControl;       
	interface ADC as Light;                     
    
    interface ADC as ADC2;
    interface ADC as ADC3;
    interface ADC as ADC4;
    interface ADC as ADC5;
    interface ADC as ADC6;
    interface ADCControl;
    
    interface Timer;
    interface Leds;
  }
}

implementation {
	
  enum { START, BUSY, BATT_DONE, TEMP_DONE, LIGHT_DONE};

  #define MSG_LEN  29 

   TOS_Msg msg_buf;
   TOS_MsgPtr msg_ptr;

   bool sending_packet;
   bool bIsUart;
   uint8_t state;
   XDataMsg *pack; 

   static void start() 
    {
  	atomic state = START;
  	call BattControl.start(); 
  	call TempControl.start(); 
  	call PhotoControl.start(); 
    }
/****************************************************************************
 * Task to xmit radio message
 *
 ****************************************************************************/
   task void send_radio_msg(){
    atomic sending_packet=TRUE;  
    call Send.send(TOS_BCAST_ADDR,sizeof(XDataMsg),msg_ptr);
    return;
  }
/****************************************************************************
 * Task to uart as message
 *
 ****************************************************************************/
   task void send_uart_msg(){
    if(sending_packet) return;    
    atomic sending_packet=TRUE;
    call Leds.yellowToggle();
    call Send.send(TOS_UART_ADDR,sizeof(XDataMsg),msg_ptr);
    return;
  }

 /****************************************************************************
 * Initialize the component. Initialize ADCControl, Leds
 *
 ****************************************************************************/
  command result_t StdControl.init() {
  	
  	atomic {
    msg_ptr = &msg_buf;
    pack=(XDataMsg *)msg_ptr->data;
    }
// usart1 is also connected to external serial flash
// set usart1 lines to correct state
    TOSH_MAKE_FLASH_OUT_OUTPUT();             //tx output
    TOSH_MAKE_FLASH_CLK_OUTPUT();             //usart clk
    sending_packet=FALSE;   
    call ADCControl.bindPort(TOS_ADC2_PORT, TOSH_ACTUAL_ADC2_PORT);
    call ADCControl.bindPort(TOS_ADC3_PORT, TOSH_ACTUAL_ADC3_PORT);
    call ADCControl.bindPort(TOS_ADC4_PORT, TOSH_ACTUAL_ADC4_PORT);
    call ADCControl.bindPort(TOS_ADC5_PORT, TOSH_ACTUAL_ADC5_PORT);
    call ADCControl.bindPort(TOS_ADC6_PORT, TOSH_ACTUAL_ADC6_PORT);
    call BattControl.init();      
    call Leds.init();             
    call CommControl.init();      
    call TempControl.init();      
    call ADCControl.init();
    
   	return SUCCESS;

  }
 /****************************************************************************
 * Start the component. Start the clock.
 *
 ****************************************************************************/
  command result_t StdControl.start(){
  		call Leds.redOn();
    call Leds.yellowOn();
    call Leds.greenOn();
    atomic state = START;
    bIsUart=TRUE;
    call BattControl.start(); 
    call PhotoControl.start(); 
    call CommControl.start();
    
    call Timer.start(TIMER_REPEAT, 2000);
    pack->xSensorHeader.board_id = SENSOR_BOARD_ID;
    pack->xSensorHeader.packet_id = 1;     // Only one packet for MDA500
    pack->xSensorHeader.node_id = TOS_LOCAL_ADDRESS;
    pack->xSensorHeader.rsvd = 0;
    return SUCCESS;	
  }
 /****************************************************************************
 * Stop the component.
 *
 ****************************************************************************/
  command result_t StdControl.stop() {
    call BattControl.stop(); 
    call TempControl.stop();  
    call PhotoControl.stop();  
    return SUCCESS;    
  }
/****************************************************************************
 * Measure Temp, Light  
 *
 ****************************************************************************/
event result_t Timer.fired() {
    uint8_t l_state;
        
    atomic l_state = state;
	
    if ( l_state == START) {

    	atomic state = BUSY;
    	start();
        call ADCBATT.getData();           //get sensor data;
        atomic l_state = state;
    }
	  return SUCCESS;  
  }
  
/****************************************************************************
 * Battery Ref  or thermistor data ready 
 ****************************************************************************/
  async event result_t ADCBATT.dataReady(uint16_t data) {
      pack->xData.datap1.vref = data ;
      atomic state = BATT_DONE;
      call Temperature.getData();
      return SUCCESS;
  }
    
/****************************************************************************
 * Temperature ADC data ready 
 * Read and get next channel.
 * Send data packet
 ****************************************************************************/ 
  async event result_t Temperature.dataReady(uint16_t data) {
       pack->xData.datap1.thermistor = data ;
       
       atomic state = TEMP_DONE; 
       call Light.getData();
       return SUCCESS;
  }

  
/****************************************************************************
 * Photocell ADC data ready 
 * Read and get next channel.
 * Send data packet
 ****************************************************************************/ 
  async event result_t Light.dataReady(uint16_t data) {
       pack->xData.datap1.photo = data ;
              
       call ADC2.getData();
       TOSH_uwait(100);  
       
       return SUCCESS;
  }
  

  async event result_t ADC2.dataReady(uint16_t data) {
       pack->xData.datap1.adc2 = data ;
       call ADC3.getData();
       return SUCCESS;     
  }
  async event result_t ADC3.dataReady(uint16_t data) {
       pack->xData.datap1.adc3 = data ;
       call ADC4.getData();
       return SUCCESS;        
  }
  async event result_t ADC4.dataReady(uint16_t data) {
       pack->xData.datap1.adc4 = data ;
       call ADC5.getData();
       return SUCCESS;        
  }
  async event result_t ADC5.dataReady(uint16_t data) {
       pack->xData.datap1.adc5 = data ;
       call ADC6.getData();
       return SUCCESS;        
  }
  async event result_t ADC6.dataReady(uint16_t data) {
       atomic state = START;   
       pack->xData.datap1.adc6 = data ;
       post send_uart_msg();
       TOSH_uwait(100);  
       return SUCCESS;        
  }
  
/****************************************************************************
 * if Uart msg xmitted,Xmit same msg over radio
 * if Radio msg xmitted, issue a new round measuring
 ****************************************************************************/
  event result_t Send.sendDone(TOS_MsgPtr msg, result_t success) {
      //atomic msg_uart = msg;

      
      //if message have sent by UART, send the message once again by radio.
      if(bIsUart)
      { 
        bIsUart=FALSE;  
        post send_radio_msg();
      }
      else
      {
        bIsUart=TRUE;  
        atomic msg_ptr = msg;
      atomic state = START;
      atomic sending_packet=FALSE;
      }
      return SUCCESS;
  }

/****************************************************************************

 * Uart msg rcvd. 
 * This app doesn't respond to any incoming uart msg
 * Just return
 ****************************************************************************/
  event TOS_MsgPtr Receive.receive(TOS_MsgPtr data) {
      return data;
  }
}

