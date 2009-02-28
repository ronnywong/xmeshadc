/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: XSensorMTS300M.nc,v 1.3.4.1 2007/04/26 20:32:56 njain Exp $
 */

/** 
 * XSensor single-hop application for MTS310 sensorboard.
 *
 * @author Martin Turon, Alan Broad, Hu Siquan, Pi Peng
 */


#include "appFeatures.h"
includes sensorboard;
module XSensorMTS300M {
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
	
// Mic
	interface StdControl as MicControl;
	interface Mic;
	interface ADC as MicADC;
	
// Sounder
	interface StdControl as Sounder;
	
// Accel   
	interface StdControl as AccelControl;
	interface ADC as AccelX;
	interface ADC as AccelY;
	
// Mag
	interface StdControl as MagControl;
	interface ADC as MagX;
	interface ADC as MagY;
	
	interface Timer;
	interface Leds;
    }
}

implementation {
    
  enum { START, BUSY, SERIALID_DONE,SOUND_DONE};
    
  TOS_Msg msg_buf_uart;
  TOS_MsgPtr msg_uart;
    
  char main_state;
  bool sound_state, sending_packet, IsUART;
        
  XDataMsg *pack;
  
   static void start() 
    {
      call BattControl.start();
      call Mic.gainAdjust(64);  // Set the gain of the microphone. (refer to Mic) 
      call MicControl.start();
      call TempControl.start();  
      call PhotoControl.start(); 
#ifdef MTS310
      call AccelControl.start();
      call MagControl.start();
#endif
    }  


    task void battstop()
    {
  	call BattControl.stop();
    }
    task void tempstop()
    {
  	call TempControl.stop();
    }
    task void photostop()
    {
  	call PhotoControl.stop();
    }
	
/****************************************************************************
 * Task to uart as message
 ****************************************************************************/
  task void send_msg(){
    
    if (sending_packet) return;
    atomic sending_packet = TRUE;
    
    call Leds.yellowToggle();
    if (IsUART) call Send.send(TOS_UART_ADDR,sizeof(XDataMsg),msg_uart);
    else call Send.send(TOS_BCAST_ADDR,sizeof(XDataMsg),msg_uart);
    return;
  }
    
/****************************************************************************
 * Initialize the component. 
 ****************************************************************************/
  command result_t StdControl.init() {
      
      atomic {
	  msg_uart = &msg_buf_uart;
      }

      call BattControl.init();    
      call Leds.init();
      call CommControl.init();
      call TempControl.init();
      call MicControl.init();
      call Mic.muxSel(1);  // Set the mux so that raw microhpone output is selected
      call Mic.gainAdjust(64);  // Set the gain of the microphone. 
      
#if FEATURE_SOUNDER
      call Sounder.init();
#endif
      atomic {
	  main_state = START;
  	  sound_state = TRUE;
	  sending_packet = FALSE;
	  pack = (XDataMsg *)msg_uart->data;
      }
      
#ifdef MTS310
      call AccelControl.init();
      call MagControl.init();
#endif
      
      return SUCCESS;
      
  }
 /****************************************************************************
 * Start the component. Start the clock.
 ****************************************************************************/
  command result_t StdControl.start()
  {
      call Leds.redOn();
      start();  	
      call CommControl.start();
      call Timer.start(TIMER_REPEAT, 2000);
      pack->xSensorHeader.board_id = SENSOR_BOARD_ID;
      pack->xSensorHeader.node_id = TOS_LOCAL_ADDRESS;
      pack->xSensorHeader.rsvd = 0;
      IsUART = TRUE;
      
      call Leds.greenOn();

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
#ifdef MTS310
      call AccelControl.stop();
      call MagControl.stop();
#endif 
      call CommControl.stop();
       return SUCCESS;    
  }
/****************************************************************************
 * Measure Temp, Light, Mic, toggle sounder  
 ****************************************************************************/
  event result_t Timer.fired() {
      char l_state;
       
      call Leds.redToggle();
      
      atomic l_state = main_state;
      
      if (sending_packet) 
	  return SUCCESS;                //don't overrun buffers

      switch (l_state) {
      case SOUND_DONE:
	atomic main_state = START;
	
      case START:
	atomic main_state = BUSY; 
	start();
	pack->xSensorHeader.packet_id = 1;      
//	call BattControl.start(); 
	call ADCBATT.getData();     //get sensor data;
	break;
		
      case BUSY:
      default:
	      break;
      }

      return SUCCESS;
  }
  
/****************************************************************************
 * Battery Ref ADC data ready 
 * Issue a command to sample the Temperature ADC data. 
 ****************************************************************************/
  async event result_t ADCBATT.dataReady(uint16_t data) {
    
    pack->xData.datap1.vref = data;
    post battstop();
    call Temperature.getData(); 
    return SUCCESS;
  }
  
    
/****************************************************************************
 * Temperature ADC data ready 
 * Issue a command to sample the Photocell ADC data. 
 ****************************************************************************/ 
  async event result_t Temperature.dataReady(uint16_t data) {
    
    pack->xData.datap1.thermistor = data;	
    post tempstop(); 
    call Light.getData(); 
    return SUCCESS;
  }

  
/****************************************************************************
 * Photocell ADC data ready 
 * Issue a command to sample the MicroPhone ADC data. 
 ****************************************************************************/ 
  async event result_t Light.dataReady(uint16_t data) {
       pack->xData.datap1.light = data;
              
       post photostop(); 
       call MicADC.getData(); 

       return SUCCESS;
  }

/****************************************************************************
 * MicroPhone ADC data ready 
 *****************************************************************************/   
 async event result_t MicADC.dataReady(uint16_t data) {
      pack->xData.datap1.mic = data;            
#ifdef MTS310
      call AccelX.getData();
#else      
      // This is the final sensor reading for the MTS300...

      if (!sending_packet)
	  post send_msg();
      atomic main_state = START;

#if FEATURE_SOUNDER
	{
    bool local_sound_state;
	atomic local_sound_state = sound_state;
	if (local_sound_state) 
	  call Sounder.start();
	else 
	  call Sounder.stop();
	atomic {
	  sound_state = SOUND_STATE_CHANGE;
	  atomic main_state = SOUND_DONE;
      }
    }
#endif
#endif
      return SUCCESS;
  } 
  
 
/****************************************************************************
 *  ADC data ready 
 *  Issue a command to sample the accelerometer's Y axis. 
 ****************************************************************************/
  async event result_t AccelX.dataReady(uint16_t data) {

      pack->xData.datap1.accelX = data;
       
      call AccelY.getData();   
      return SUCCESS;
  }

/****************************************************************************
 *  ADC data ready 
 *  Issue a command to sample the magnetometer's X axis. 
 *  (Magnetometer A pin) 
 ****************************************************************************/
  async event result_t AccelY.dataReady(uint16_t data) {

      pack->xData.datap1.accelY = data;
      call MagX.getData();
      return SUCCESS;
  }

 /**
  * ADC data ready 
  * Issue a command to sample the magnetometer's Y axis. 
  * (Magnetometer B pin)
  */
  async event result_t MagX.dataReady(uint16_t data){

      pack->xData.datap1.magX = data;
      call  MagY.getData(); //get data for MagnetometerB
      return SUCCESS;  
  }

 /**
  * ADC data ready 
  * Issue a task to send uart packet.
  */
  async event result_t MagY.dataReady(uint16_t data){
    bool local_sound_state;
    pack->xData.datap1.magY = data;

    if (!sending_packet)
      post send_msg();
       	atomic main_state = START;      
	
#if FEATURE_SOUNDER
    atomic local_sound_state = sound_state;
    if (local_sound_state) call Sounder.start();
    else call Sounder.stop();
    atomic {
      sound_state = SOUND_STATE_CHANGE;
      atomic main_state = SOUND_DONE;
    }
#endif
    return SUCCESS;  
  }


  
  
/****************************************************************************
 * if Uart msg xmitted,Xmit same msg over radio
 * if Radio msg xmitted, issue a new round measuring
 ****************************************************************************/
  event result_t Send.sendDone(TOS_MsgPtr msg, result_t success) {
      //atomic msg_uart = msg;
      atomic {
      	msg_uart = msg;
	sending_packet = FALSE;
      }
      if(IsUART){
	IsUART = FALSE;
	post send_msg();      
      }
      else{
    	IsUART = TRUE;
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

