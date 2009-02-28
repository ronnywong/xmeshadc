/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: XMDA100M.nc,v 1.4.4.2 2007/04/26 20:06:27 njain Exp $
 */

/** 
 * XSensor multi-hop application for MDA100 sensorboard.
 *
 * @author Pi Peng
 */



/******************************************************************************
 *
 *****************************************************************************/
#include "appFeatures.h"
includes XCommand;

includes sensorboard;

module XMDA100M {
  provides {
    interface StdControl;
  }
  uses {
  
	interface Leds;

	interface MhopSend as Send;
	interface RouteControl;
	interface XCommand;
	interface XEEControl;

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


#if FEATURE_UART_SEND
	interface SendMsg as SendUART;
	command result_t PowerMgrEnable();
	command result_t PowerMgrDisable();
#endif
        command void health_packet(bool enable, uint16_t intv);
        command HealthMsg* HealthMsgGet();
  }
}

implementation {
	
  enum { START, BUSY, BATT_DONE, TEMP_DONE, LIGHT_DONE};
  
  #define MSG_LEN  29 

   TOS_Msg msg_buf;
   TOS_MsgPtr msg_ptr;
   HealthMsg *h_msg;

   norace bool sending_packet,sensinginsession;

   norace uint8_t state;
   XDataMsg pack; 
    bool       sleeping;	       // application command state


  static void initialize() 
    {
      atomic 
      {
    	  sleeping = FALSE;
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
    	  sensinginsession=FALSE;
      }
    }

   static void start() 
    {
  	atomic state = START;
  	call BattControl.start(); 
  	call TempControl.start(); 
  	call PhotoControl.start(); 
    }
    task void stop()
    {
  	call StdControl.stop();
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
 * Task to xmit radio message
 *
 ****************************************************************************/
   task void send_radio_msg(){
    uint16_t  len;
	XDataMsg *data;
    uint8_t i;
    if(sending_packet) return; 
    call Leds.yellowOn();
    atomic sending_packet=TRUE;  

    data = (XDataMsg*)call Send.getBuffer(msg_ptr, &len);
	for (i=0; i<= sizeof(XDataMsg)-1; i++)
		((uint8_t*) data)[i] = ((uint8_t*)&pack)[i];
    data->xMeshHeader.board_id = SENSOR_BOARD_ID;
    data->xMeshHeader.packet_id = 1;     
    //data->xMeshHeader.node_id = TOS_LOCAL_ADDRESS;
    data->xMeshHeader.parent    = call RouteControl.getParent();
    data->xMeshHeader.packet_id = data->xMeshHeader.packet_id | 0x80;
    
    #if FEATURE_UART_SEND
    	if (TOS_LOCAL_ADDRESS != 0) {
    		call Leds.yellowOn();
    	    call PowerMgrDisable();
    	    TOSH_uwait(1000);
    	    if (call SendUART.send(TOS_UART_ADDR, sizeof(XDataMsg),msg_ptr) != SUCCESS) 
    	    {
        		atomic sending_packet = FALSE;
        		call Leds.greenToggle();
        		call PowerMgrEnable();
    	    }
    	} 
    	else 
    #endif
    	{
    	    // Send the RF packet!
            if (call Send.send(BASE_STATION_ADDRESS,MODE_UPSTREAM,msg_ptr, sizeof(XDataMsg)) != SUCCESS) {
        		atomic sending_packet = FALSE;
    		    call Leds.yellowOn();
        		call Leds.greenOff();
    	    }
    	}
    return;
  }

 /****************************************************************************
 * Initialize the component. Initialize ADCControl, Leds
 *
 ****************************************************************************/
  command result_t StdControl.init() {
  	
  	atomic {
    msg_ptr = &msg_buf;
    }
// usart1 is also connected to external serial flash
// set usart1 lines to correct state
    TOSH_MAKE_FLASH_OUT_OUTPUT();             //tx output
    TOSH_MAKE_FLASH_CLK_OUTPUT();             //usart clk
    sending_packet=FALSE;   
    
    call BattControl.init(); 
    call Leds.init();
    call TempControl.init();
    call PhotoControl.init();
    call ADCControl.bindPort(TOS_ADC2_PORT, TOSH_ACTUAL_ADC2_PORT);
    call ADCControl.bindPort(TOS_ADC3_PORT, TOSH_ACTUAL_ADC3_PORT);
    call ADCControl.bindPort(TOS_ADC4_PORT, TOSH_ACTUAL_ADC4_PORT);
    call ADCControl.bindPort(TOS_ADC5_PORT, TOSH_ACTUAL_ADC5_PORT);
    call ADCControl.bindPort(TOS_ADC6_PORT, TOSH_ACTUAL_ADC6_PORT);
    call ADCControl.init();
    initialize();
   	return SUCCESS;

  }
 /****************************************************************************
 * Start the component. Start the clock.
 *
 ****************************************************************************/
  command result_t StdControl.start(){
    call StdControl.stop();
    h_msg = call HealthMsgGet();
    h_msg->rsvd_app_type = SENSOR_BOARD_ID;
    call Timer.start(TIMER_REPEAT, timer_rate);
    call health_packet(TRUE,TOS_HEALTH_UPDATE);
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
	
    if ( !sending_packet) {
    	start();
    	if (!sensinginsession){
	      	call ADCBATT.getData();
        atomic sensinginsession = TRUE;
  }           //get sensor data;
    }
	  return SUCCESS;  
  }
  
/****************************************************************************
 * Battery Ref  or thermistor data ready 
 ****************************************************************************/
  async event result_t ADCBATT.dataReady(uint16_t data) {
  	  if (!sensinginsession) return FAIL;
  	  atomic sensinginsession = FALSE;
      atomic pack.xData.datap1.vref = data ;
      post battstop();
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
       atomic pack.xData.datap1.thermistor = data ;
       post tempstop();       
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
       atomic pack.xData.datap1.photo = data ; 
       post photostop();              
       call ADC2.getData();
       TOSH_uwait(100);         
       return SUCCESS;
  }
  

  async event result_t ADC2.dataReady(uint16_t data) {
       atomic pack.xData.datap1.adc2 = data ;
       call ADC3.getData();
       return SUCCESS;     
  }
  async event result_t ADC3.dataReady(uint16_t data) {
       atomic pack.xData.datap1.adc3 = data ;
       call ADC4.getData();
       return SUCCESS;        
  }
  async event result_t ADC4.dataReady(uint16_t data) {
       atomic pack.xData.datap1.adc4 = data ;
       call ADC5.getData();
       return SUCCESS;        
  }
  async event result_t ADC5.dataReady(uint16_t data) {
       atomic pack.xData.datap1.adc5 = data ;
       call ADC6.getData();
       return SUCCESS;        
  }
  async event result_t ADC6.dataReady(uint16_t data) {
       atomic state = START;   
       atomic pack.xData.datap1.adc6 = data ;
       post send_radio_msg();
       TOSH_uwait(100);  
       post stop();
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
      atomic msg_ptr = msg;
      msg_ptr->addr = TOS_BCAST_ADDR;
      
      if (call Send.send(BASE_STATION_ADDRESS,MODE_UPSTREAM,msg_ptr,sizeof(XDataMsg)) != SUCCESS) {
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
	  msg_ptr = msg;
	  sending_packet = FALSE;
      }
      call Leds.yellowOff();
      
#if FEATURE_UART_SEND
      if (TOS_LOCAL_ADDRESS != 0) // never turn on power mgr for base
	  call PowerMgrEnable();
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
	      call Leds.set(0);
	      call StdControl.stop();
              break;
	      
	  case XCOMMAND_WAKEUP:
	      // Wake up from sleep state.
	      if (sleeping) {
		  initialize();
		  call Timer.start(TIMER_REPEAT, timer_rate);
		  sleeping = FALSE;
	      }
	      break;
	      
	  case XCOMMAND_RESET:
	      // Reset the mote now.
	      break;

	  case XCOMMAND_ACTUATE: {
	      state = opcode->param.actuate.state;
	      if (opcode->param.actuate.device != XCMD_DEVICE_SOUNDER) 
                break;
	      }
	      break;	      

	  default:
	      break;
      }    
      
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

