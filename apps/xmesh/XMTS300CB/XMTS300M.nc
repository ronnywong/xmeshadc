/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: XMTS300M.nc,v 1.1.2.4 2007/04/26 20:16:23 njain Exp $
 */

/** 
 * XSensor multi-hop application for MTS310 sensorboard.
 *
 * @author Martin Turon, Alan Broad, Hu Siquan, Pi Peng
 */

/****************************************************************************
 *
 ***************************************************************************/
#include "appFeatures.h"
//includes XCommand;
includes sensorboard;

module XMTS300M {
    provides {
	interface StdControl;
    }
    uses {
// RF Mesh Networking
	interface MhopSend as Send;
	interface RouteControl;

	interface XCommand;
	interface XEEControl;
	
//	interface ReceiveMsg as Bcast;

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
	
	//interface ADCControl;   
	interface Timer;
	interface Leds;

#if FEATURE_UART_SEND
	interface SendMsg as SendUART;
#endif
	command result_t PowerMgrEnable();
	command result_t PowerMgrDisable();
  command void health_packet(bool enable, uint16_t intv);
  command HealthMsg* HealthMsgGet();
    }
}

implementation {
    
    enum { START, BUSY, SOUND_DONE};

    
#define MSG_LEN  29 
    
    TOS_Msg    gMsgBuffer;
    TOS_Msg    msg_buf_radio;
    TOS_MsgPtr msg_radio;
    HealthMsg *h_msg;

    bool       sleeping;	       // application command state

    norace XDataMsg   readings;
    
    char main_state;
    norace bool sound_state, sending_packet,sensinginsession;
    norace uint8_t	miccnt;
    norace uint32_t  val;
    
/***************************************************************************
 * Task to xmit radio message
 *
 *    msg_radio->addr = TOS_BCAST_ADDR;
 *    msg_radio->type = 0x31;
 *    msg_radio->length = MSG_LEN;
 *    msg_radio->group = TOS_AM_GROUP;
 ***************************************************************************/
    task void send_radio_msg() {
	uint8_t   i;
	uint16_t  len;
	XDataMsg *data;
	
	call Leds.yellowOn();
	// Fill the given data buffer.	    
	data = (XDataMsg*)call Send.getBuffer(msg_radio, &len);
	
	for (i = 0; i <= sizeof(XDataMsg)-1; i++) 
	    ((uint8_t*)data)[i] = ((uint8_t*)&readings)[i];
	
	data->board_id  = SENSOR_BOARD_ID;
	data->packet_id = 1;    
	//data->node_id   = TOS_LOCAL_ADDRESS;
	data->parent    = call RouteControl.getParent();
	data->packet_id = data->packet_id | 0x80;
#if FEATURE_UART_SEND
	if (TOS_LOCAL_ADDRESS != 0) {
	    call PowerMgrDisable();
	    TOSH_uwait(1000);
	    if (call SendUART.send(TOS_UART_ADDR, sizeof(XDataMsg), 
				   msg_radio) != SUCCESS) 
	    {
		atomic sending_packet = FALSE;
		call Leds.yellowOff();
		call PowerMgrEnable();
	    }
	} 
	else 
#endif
	{
	    // Send the RF packet!
	    if (call Send.send(BASE_STATION_ADDRESS,MODE_UPSTREAM,msg_radio, sizeof(XDataMsg)) != SUCCESS) {
		atomic sending_packet = FALSE;
		call Leds.yellowOff();
	    }
	}

	return;
}
    
  static void initialize() {
      atomic {
	  sleeping = FALSE;
	  main_state = START;
  	  sound_state = TRUE;
	  sending_packet = FALSE;
#ifdef APP_RATE	  
		timer_rate = XSENSOR_SAMPLE_RATE;
#else		
#ifdef USE_LOW_POWER 	  
		timer_rate = XSENSOR_SAMPLE_RATE  + ((TOS_LOCAL_ADDRESS%255) << 7);
#else 
	  timer_rate = XSENSOR_SAMPLE_RATE + ((TOS_LOCAL_ADDRESS%255) << 2);
#endif
#endif
	  miccnt=0;
	  val=0;
	  sensinginsession=FALSE;
      }
  }

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
    task void Micstop()
    {
  	call MicControl.stop();
    }
    

    task void Accelstop()
    {
  	call AccelControl.stop();
    }

      
/****************************************************************************
 * Initialize the component. Initialize ADCControl, Leds
 *
 ****************************************************************************/
    command result_t StdControl.init() {
	
	atomic msg_radio = &msg_buf_radio;
	
    //  MAKE_BAT_MONITOR_OUTPUT();  // enable voltage ref power pin as output
    //  MAKE_ADC_INPUT();           // enable ADC7 as input
    call BattControl.init();          
// usart1 is also connected to external serial flash
// set usart1 lines to correct state
//  TOSH_MAKE_FLASH_SELECT_OUTPUT();
      TOSH_MAKE_FLASH_OUT_OUTPUT();             //tx output
      TOSH_MAKE_FLASH_CLK_OUTPUT();             //usart clk
//  TOSH_SET_FLASH_SELECT_PIN();

      call Leds.init();
      call TempControl.init();
      call PhotoControl.init();
      call MicControl.init();
      call Mic.muxSel(1);  // Set the mux so that raw microhpone output is selected
      call Mic.gainAdjust(64);  // Set the gain of the microphone. (refer to Mic) 
#if FEATURE_SOUNDER
      call Sounder.init();
#endif      

#ifdef MTS310
      call AccelControl.init();
      call MagControl.init();
#endif

if (TOS_LOCAL_ADDRESS==0)
      call PowerMgrDisable();
      
      initialize();
      return SUCCESS;
      
  }
 /***************************************************************************
 * Start the component. Start the clock.
 *
 ***************************************************************************/
  command result_t StdControl.start()
  {
      call StdControl.stop();
      h_msg = call HealthMsgGet();
      h_msg->rsvd_app_type = SENSOR_BOARD_ID;
      call health_packet(TRUE,TOS_HEALTH_UPDATE);
      call Timer.start(TIMER_REPEAT, timer_rate);       
      return SUCCESS;	
  }

/***************************************************************************
 * Stop the component.
 *
 ***************************************************************************/
  command result_t StdControl.stop() {
      call BattControl.stop(); 
      call TempControl.stop();  
      call PhotoControl.stop();
      call MicControl.stop();

#ifdef MTS310
      call AccelControl.stop();
      call MagControl.stop();
#endif 

      return SUCCESS;
  }
/****************************************************************************
 * Measure Temp, Light, Mic, toggle sounder  
 *
 ****************************************************************************/
  event result_t Timer.fired() {

      if (sending_packet) 
	  return SUCCESS;             //don't overrun buffers
      if(main_state==BUSY)
          return SUCCESS;
      start();
      atomic main_state = BUSY;
      if (!sensinginsession){
      	call ADCBATT.getData();
        atomic sensinginsession = TRUE;
        }
      return SUCCESS;
  }
  
 /***************************************************************************
 * Battery Ref  or thermistor data ready 
 ***************************************************************************/
  async event result_t ADCBATT.dataReady(uint16_t data) {
      if (!sensinginsession) return FAIL;
      readings.vref = data;
      atomic sensinginsession = FALSE;
      post battstop(); 
      //call TempControl.start();  
      call Temperature.getData(); 
      return SUCCESS;
  }


    
/***************************************************************************
 * Temperature ADC data ready 
 * Read and get next channel.
 **************************************************************************/ 
  async event result_t Temperature.dataReady(uint16_t data) {
      readings.thermistor = data;
      //call PhotoControl.start();  
      call Light.getData(); 
      return SUCCESS;
  }

/***************************************************************************
 * Photocell ADC data ready 
 * Read and get next channel.
 **************************************************************************/ 
  async event result_t Light.dataReady(uint16_t data) {
      readings.light = data;
      post photostop();
      post tempstop();
      call MicADC.getData();   
      return SUCCESS;
  }

/***************************************************************************
 * MicroPhone ADC data ready 
 * Read and toggle sounder.
 * send uart packet
 **************************************************************************/
  async event result_t MicADC.dataReady(uint16_t data) {
     if(miccnt<50)
     {
	     atomic miccnt=miccnt+1;
	     TOSH_uwait(1000);
	     if(val<data)
	     {
	     	atomic val=data;
	     }
	     call MicADC.getData();
	     return SUCCESS;
     }
     else
     {
	     atomic miccnt=0;
     }
     readings.mic = val;//data;
     post Micstop();
     val=0;

#ifdef MTS310
     call AccelX.getData();
#else      
     // This is the final sensor reading for the MTS300...
     atomic {
	 if (!sending_packet) {
	     sending_packet = TRUE;
	     post send_radio_msg();
	 }
     }
     
#if FEATURE_SOUNDER
     if (sound_state) call Sounder.start();
     else call Sounder.stop();
     atomic {
	 sound_state = SOUND_STATE_CHANGE;
     }
#endif
#endif
     return SUCCESS;
 } 
  
 
/***************************************************************************
 *  ADC data ready 
 * Read and toggle sounder.
 * send uart packet
 ***************************************************************************/
  async event result_t AccelX.dataReady(uint16_t data) {
      readings.accelX = data;

      call AccelY.getData();   
      return SUCCESS;
  }

/***************************************************************************
 *  ADC data ready 
 * Read and toggle sounder.
 * send uart packet
 ***************************************************************************/
  async event result_t AccelY.dataReady(uint16_t data) {
      readings.accelY = data;

      post Accelstop();
      call MagX.getData();
      return SUCCESS;
  }

 /**
  * In response to the <code>MagX.dataReady</code> event, it stores the 
  * sample and issues command to sample the magnetometer's Y axis. 
  * (Magnetometer B pin)
  *  
  * @return returns <code>SUCCESS</code>
  */
  async event result_t MagX.dataReady(uint16_t data){
      readings.magX = data;

      call  MagY.getData(); //get data for MagnetometerB
      return SUCCESS;  
  }

 /**
  * In response to the <code>MagY.dataReady</code> event, it stores the 
  * sample and issues a task to filter and process the stored magnetometer 
  * data.
  *
  * It also has a schedule which starts sampling the Temperture and 
  * Accelormeter depending on the stepdown counter.
  * 
  * @return returns <code>SUCCESS</code>
  */
  async event result_t MagY.dataReady(uint16_t data){
      readings.magY = data;	  
      atomic {
	  if (!sending_packet) {
	      sending_packet = TRUE;
	      post send_radio_msg();
	  }
      }
      
#if FEATURE_SOUNDER
      if (sound_state) call Sounder.start();
      else call Sounder.stop();
      atomic {
	  sound_state = SOUND_STATE_CHANGE;
      }
#endif
      return SUCCESS;  
  }

 /** 
  * Handles all broadcast command messages sent over network. 
  *
  * NOTE: Bcast messages will not be received if seq_no is not properly
  *       set in first two bytes of data payload.  Also, payload is 
  *       the remaining data after the required seq_no.
  *
  * @version   2004/10/5   mturon     Initial version
  */
  event result_t XCommand.received(XCommandOp *opcode) {

      switch (opcode->cmd) {
	  case XCOMMAND_SET_RATE:
	      // Change the data collection rate.
	      timer_rate = opcode->param.newrate;
	      call Timer.stop();
	      call Timer.start(TIMER_REPEAT, timer_rate);
	      break;
      
	  case XCOMMAND_SLEEP:
	      // Stop collecting data, and go to sleep.
	      sleeping = TRUE;
	      call Timer.stop();
	      call StdControl.stop();
	      call Leds.set(0);
              break;
	      
	  case XCOMMAND_WAKEUP:
	      // Wake up from sleep state.
	      if (sleeping) {
		  initialize();
		  call Timer.start(TIMER_REPEAT, timer_rate);
		  call StdControl.start();
		  sleeping = FALSE;
	      }
	      break;
	      
	  case XCOMMAND_RESET:
	      // Reset the mote now.
	      break;

	  case XCOMMAND_ACTUATE: {
	      uint16_t state = opcode->param.actuate.state;
	      if (opcode->param.actuate.device != XCMD_DEVICE_SOUNDER) break;
	      
	      // Play the sounder for one period.
	      sound_state = state;
	      if (sound_state) call Sounder.start();
	      else call Sounder.stop();
	      atomic {
		  sound_state = SOUND_STATE_CHANGE;
	      }
	      break;
	  }
	      

	  default:
	      break;
      }    
      
      return SUCCESS;
  }
  
#if FEATURE_UART_SEND
 /**
  * Handle completion of sent UART packet.
  *
  * @author    Martin Turon
  * @version   2004/7/21      mturon       Initial revision
  */
  event result_t SendUART.sendDone(TOS_MsgPtr msg, result_t success) 
  {
      //      if (msg->addr == TOS_UART_ADDR) {
      atomic msg_radio = msg;
      msg_radio->addr = TOS_BCAST_ADDR;
      
      if (call Send.send(BASE_STATION_ADDRESS,MODE_UPSTREAM,msg_radio, sizeof(XDataMsg)) != SUCCESS) {
	  atomic sending_packet = FALSE;
	  call Leds.yellowOff();
      }
      
      if (TOS_LOCAL_ADDRESS != 0) // never turn on power mgr for base
	  call PowerMgrEnable();
      

      //}
      return SUCCESS;
  }
#endif

 /**
  * Handle completion of sent RF packet.
  *
  * @author    Martin Turon
  * @version   2004/5/27      mturon       Initial revision
  */
  event result_t Send.sendDone(TOS_MsgPtr msg, result_t success) 
  {
      atomic {
	  msg_radio = msg;
	  main_state = START;
	  sending_packet = FALSE;
	  call StdControl.stop();
	  
      }
      call Leds.yellowOff();
      
#if FEATURE_UART_SEND
      if (TOS_LOCAL_ADDRESS != 0) // never turn on power mgr for base
	  call PowerMgrEnable();
#endif
      
      return SUCCESS;
  }
  
  
   event result_t XEEControl.restoreDone(result_t result)
   {
   		if(result) {
   				call Timer.stop();
	      		call Timer.start(TIMER_REPEAT, timer_rate);
   		}
 	 return SUCCESS;
   }  
    
}



