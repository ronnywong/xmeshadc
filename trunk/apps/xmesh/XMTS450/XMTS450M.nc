/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: XMTS450M.nc,v 1.6.2.3 2007/04/26 20:22:34 njain Exp $
 */

/** 
 * XSensor multi-hop application for MTS450 sensorboard.
 *
 * @author Tang Junhua, Pi Peng
 */

/****************************************************************************
 *
 ***************************************************************************/
#include "appFeatures.h"

//includes XCommand;
includes sensorboard;

module XMTS450M {
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

//humidity and temp sensor interface
	interface SplitControl as ADCControl;
    interface ADC as Humidity;
    interface ADC as Temperature;
    interface ADCError as HumidityError;
    interface ADCError as TemperatureError;

	//eeprom interface
	interface StdControl as MTS450EEPROMControl;
	interface MTS450EEPROM;

	//7828 ADC interface for CTS sensor 
	interface StdControl as MTS450CTSControl;
	interface MTS450CTS;
	
	//voltage interface
	interface StdControl as BattControl;
	interface ADC as ADCBATT;
	
	//interface ADCControl;   
	interface Timer;
	interface Leds;
	
  command void health_packet(bool enable, uint16_t intv);
  command HealthMsg* HealthMsgGet();	

#if FEATURE_UART_SEND
	interface SendMsg as SendUART;
	command result_t PowerMgrEnable();
	command result_t PowerMgrDisable();
#endif
    }
}

implementation {
	enum { START,BATT,BUSY};
	

	#define MSG_LEN  29 
	TOS_Msg    msg_buf_radio;
	TOS_MsgPtr msg_radio;
	HealthMsg *h_msg;
	norace XDataMsg   readings;
	char main_state;
	bool sending_packet, sleeping;
	uint16_t temp1, temp2;
	
    
/***************************************************************************
 * Task to xmit radio message
 *
 *    msg_radio->addr = TOS_BCAST_ADDR;
 *    msg_radio->type = 0x31;
 *    msg_radio->length = MSG_LEN;
 *    msg_radio->group = TOS_AM_GROUP;
 ***************************************************************************/
    task void send_radio_msg() 
    {
	  uint8_t   i;
	  uint16_t  len;
	  XDataMsg *data;
	  
	  // Fill the given data buffer.	    
	  data = (XDataMsg*)call Send.getBuffer(msg_radio, &len);
	  for (i = 0; i <= sizeof(XDataMsg)-1; i++) 
	     ((uint8_t*)data)[i] = ((uint8_t*)&readings)[i];
	  data->board_id  = SENSOR_BOARD_ID;
	  data->packet_id = 1; 
	  data->parent = call RouteControl.getParent();
	  data->packet_id = data->packet_id | 0x80;
	  
	  
#if FEATURE_UART_SEND
	  if (TOS_LOCAL_ADDRESS != 0) 
	  {
	    call PowerMgrDisable();
	    TOSH_uwait(1000);
	    if (call SendUART.send(TOS_UART_ADDR, sizeof(XDataMsg),msg_radio) != SUCCESS) 
	    {
	 	   atomic sending_packet = FALSE;
		   call PowerMgrEnable();
	    }
	  } 
	  else 
#endif
	 {
	    // Send the RF packet!
	    if (call Send.send(BASE_STATION_ADDRESS,MODE_UPSTREAM,msg_radio, sizeof(XDataMsg)) != SUCCESS) 
	    {
	 	    atomic sending_packet = FALSE;
	    }
	 }
	 return;
   }




  task void Battstop()
  {
      call BattControl.stop();
  }

  task void Adcstart()
  {
      call ADCControl.start();
      TOSH_uwait(10);
      call Temperature.getData(); 
  }
  task void Adcstop()
  {
      call ADCControl.stop();
  }

  task void CTSstart()
  {
      uint16_t i;
      call MTS450CTSControl.start();
      for(i=0;i<100;i++)
      {
      TOSH_uwait(10000);
      }
      call MTS450CTS.getData();
  }

   
  static void initialize() 
  {
      atomic 
      {
#ifdef APP_RATE	  
		timer_rate = XSENSOR_SAMPLE_RATE;
#else		
#ifdef USE_LOW_POWER 	  
		timer_rate = XSENSOR_SAMPLE_RATE  + ((TOS_LOCAL_ADDRESS%255) << 7);
#else 
	  timer_rate = XSENSOR_SAMPLE_RATE + ((TOS_LOCAL_ADDRESS%255) << 2);
#endif
#endif
	    main_state=START;
	    sending_packet = FALSE;
	    sleeping=FALSE;
      }
  }
/****************************************************************************
 * Initialize the component. Initialize ADCControl, Leds
 *
 ****************************************************************************/
  command result_t StdControl.init() 
  {
	
	atomic msg_radio = &msg_buf_radio;         
    TOSH_MAKE_FLASH_OUT_OUTPUT();             //tx output
    TOSH_MAKE_FLASH_CLK_OUTPUT();             //usart clk
    call ADCControl.init();
    call MTS450EEPROMControl.init();
    call MTS450CTSControl.init();
    call BattControl.init();
    call Leds.init();
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
      call HumidityError.enable();
      call TemperatureError.enable();
      h_msg = call HealthMsgGet();
      h_msg->rsvd_app_type = SENSOR_BOARD_ID;
      call Timer.start(TIMER_REPEAT, timer_rate);//timer_rate);       
      call health_packet(TRUE,TOS_HEALTH_UPDATE);	  
      return SUCCESS;	
  }
 /***************************************************************************
 * Stop the component.
 *
 ***************************************************************************/
  command result_t StdControl.stop() {
      call ADCControl.stop();
      call MTS450EEPROMControl.stop();
      call MTS450CTSControl.stop();
      call BattControl.stop();
      return SUCCESS;
  }
  event result_t ADCControl.initDone() 
  {
    
	return SUCCESS;
  }
  event result_t ADCControl.stopDone() 
  {
    return SUCCESS;
  }
  event result_t ADCControl.startDone() {
    return SUCCESS;
  }


/****************************************************************************
 * Measure Temp, Light, Mic, toggle sounder  
 *
 ****************************************************************************/
  event result_t Timer.fired() 
  {
      char l_state;
      atomic l_state = main_state;
      call Leds.greenToggle();
      if (sending_packet) 
	         return SUCCESS;             //don't overrun buffers
      switch (l_state) 
      {
	  case START:
	      atomic main_state = BATT;
	      call BattControl.start();
	      TOSH_uwait(100);
	      call ADCBATT.getData();     //get sensor data;
	      break;
	  case BUSY:
	  	  break;
	  default:
	      break;
      }

      return SUCCESS;
  }
  
 /***************************************************************************
 * Battery Ref  or thermistor data ready 
 ***************************************************************************/
  async event result_t ADCBATT.dataReady(uint16_t data) {
  	if(main_state == BATT)
  	{
  		atomic main_state = BUSY;
      readings.vref = data;
      post Battstop();
      post Adcstart();
    }
      return SUCCESS;
  }
  event result_t TemperatureError.error(uint8_t token)
  {
    
    readings.temp=0;   
    call Humidity.getData(); 
    return SUCCESS;
  }

 async event result_t Temperature.dataReady(uint16_t data)
  { 
    readings.temp = data;    
    call Humidity.getData(); 
    return SUCCESS;
  } 
  
  event result_t HumidityError.error(uint8_t token)
  {
	//humidity invalid;
	readings.humid = 0; 
    call ADCControl.stop();
    call MTS450CTSControl.start();
    TOSH_uwait(1000);
    call MTS450CTS.getData();
    return SUCCESS;
  }
    
  async event result_t Humidity.dataReady(uint16_t data)
  {
    //humidity data
    
    readings.humid = data;
    post Adcstop();
    post CTSstart();
    return SUCCESS;
  }
  
  event result_t MTS450CTS.dataReady(char* data)  
  {
	call MTS450CTSControl.stop();
	call MTS450EEPROMControl.start();
	temp1=data[0];
	temp1=temp1&0x0f;
	temp1=temp1<<8;
	temp2=data[1];
	temp2=temp2&0xff;
	readings.gas = temp1|temp2;
	call MTS450EEPROM.readPacket(0,10,0x03);
    return SUCCESS;
  }
  
  event result_t MTS450EEPROM.readPacketDone(char length, char* data) 
  {
     //eeprom data
     int i;
     call MTS450EEPROMControl.stop();
     call StdControl.stop();
     if(length==10)
     {
	     for(i=0;i<5;i++)
	     {
		     temp1=data[2*i];
		     temp1=temp1<<8;
		     temp1=temp1&0xff00;
		     temp2=data[2*i+1];
		     temp2=temp2&0xff;
		     readings.cal[i] = temp1|temp2;		     
		 }
	 }
     else
     {
	     for(i=0;i<5;i++)
	     {
		     readings.cal[i] = 0;	
		 }
	 }
     
     atomic 
     {
	    if (!sending_packet) 
	    {
	      sending_packet = TRUE;
	      post send_radio_msg();
	    }
     }
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
		  sleeping = FALSE;
	      }
	      break;
	      
	  case XCOMMAND_RESET:
	      // Reset the mote now.
	      break;

	  case XCOMMAND_ACTUATE: 
	      {
//	         uint16_t state = opcode->param.actuate.state;
	         if (opcode->param.actuate.device != XCMD_DEVICE_SOUNDER) break;
	         //here turn on the sounder
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
      atomic msg_radio = msg;
      msg_radio->addr = TOS_BCAST_ADDR;      
      if (call Send.send(BASE_STATION_ADDRESS,MODE_UPSTREAM,msg_radio, sizeof(XDataMsg)) != SUCCESS) 
      {
	     atomic sending_packet = FALSE;
      }      
      if (TOS_LOCAL_ADDRESS != 0) // never turn on power mgr for base
	     call PowerMgrEnable();
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
      atomic 
      {
	    msg_radio = msg;
	    main_state = START;
	    sending_packet = FALSE;	  
      }      
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
   event result_t MTS450EEPROM.writePacketDone(bool result)
  {
	  //actually no read operation
	  return SUCCESS;	  
  }
  
    
}



