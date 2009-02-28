/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: XMEP510M.nc,v 1.4.4.7 2007/04/26 20:12:57 njain Exp $
 */

/** 
 * XSensor multi-hop application for MEP510 sensorboard.
 *
 *    -Tests the MEP500 Mica2Dot Sensor Board
 *     Reads thermistor and humidity sensor  readings
 *     Sensirion SHT15 use ADC7, So DISABLE JTAG fuse before measuring
 *-----------------------------------------------------------------------------
 * The following changes were made to improve reliability under low battery voltages:
 *   - Reboot on errors when sampling
 *   - Enable the route update watchdog timer
 *   - Disable OTAPLITE component that writes/reads eeprom (OTAP cannot be used)
 *-----------------------------------------------------------------------------
 * Output results through mica2dot uart and radio. 
 * Use Xlisten.exe program to view data from either port:
 *  uart: mount mica2dot on mib510 with Mep500
 *        connect serial cable to PC
 *        run xlisten.exe at 19200 baud
 *  radio: run mica2dot with Mep500, 
 *         run mica2 with TOSBASE
 *         run xlisten.exe at 56K baud
 *-----------------------------------------------------------------------------
 * Data packet structure  :
 *  msg->data[0] : sensor id, MEP500 = 0x3
 *  msg->data[1] : packet id
 *  msg->data[2] : node id
 *  msg->data[3] : reserved
 *  msg->data[4,5] : thermistor adc data
 *  msg->data[6,7] : humidity adc data
 *
 *
 *
 * @author Martin Turon, PiPeng
 */


#include "appFeatures.h"
includes XCommand;

module XMEP510M {
  provides {
    interface StdControl;
  }
  uses {
	interface Leds;
	interface MhopSend as Send;
	interface RouteControl;
	interface XCommand;
	interface XEEControl;
//	interface XOTAPLoader;
	command void health_packet(bool enable, uint16_t intv);
	command HealthMsg* HealthMsgGet();

    interface Timer;

// Battery    
    interface ADC as ADCBATT;
    interface StdControl as BattControl;

//Temp
    interface ADC as ADCTEMP;
    interface ADCControl;

    interface SplitControl as HumControl;
	interface ADC as Humidity;
    interface ADC as Temperature;
    interface ADCError as HumidityError;
    interface ADCError as TemperatureError;


#if FEATURE_UART_SEND
	interface SendMsg as SendUART;
	command result_t PowerMgrEnable();
	command result_t PowerMgrDisable();
#endif
  }
}

implementation {

  enum { STATE_START, 
         STATE_VREF, 
	 STATE_THERMISTOR, 
	 STATE_HUMIDITY, 
	 STATE_TEMPERATURE };
	 

  #define MSG_LEN  29 

   TOS_Msg msg_buf;
   TOS_MsgPtr msg_ptr;
   XDataMsg *pack;
   HealthMsg *h_msg;

   bool sending_packet;
   bool bIsUart;
   norace bool sensinginsession;
   uint8_t tempFlag;
   uint8_t packetcnt;
   norace uint8_t state;
   bool       sleeping;	       // application command state
   uint16_t     seqno;


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
          seqno=0;
          packetcnt=0;
          sensinginsession=FALSE;
      }
    }
    
  static void start() 
  {
    call BattControl.start();
    call HumidityError.enable();
    call TemperatureError.enable();
    
  }
  
  task void HumStart()
  {
  	call HumControl.start();
  }
  task void HumStop()
  {
  	call HumControl.stop();
  }

/****************************************************************************
 * Task to reboot
 *
 ****************************************************************************/
   task void reboot(){
     wdt_enable(0);
     while (1) { 
       __asm__ __volatile__("nop" "\n\t" ::);
     }
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
    seqno ++;
    atomic sending_packet=TRUE;  

    data = (XDataMsg*)call Send.getBuffer(msg_ptr, &len);

	for (i=0; i<= sizeof(XDataMsg)-1; i++)
		((uint8_t*) data)[i] = ((uint8_t*)pack)[i];
    data->xMeshHeader.board_id = SENSOR_BOARD_ID;
    data->xMeshHeader.packet_id = 2;     
    //data->xMeshHeader.node_id = TOS_LOCAL_ADDRESS;
    data->xMeshHeader.parent    = call RouteControl.getParent();
    data->xMeshHeader.packet_id = data->xMeshHeader.packet_id | 0x80;
    data->xData.seq_no=seqno;
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
 * Initialize this and all low level components used in this application.
 * 
 * @return returns <code>SUCCESS</code> or <code>FAIL</code>
 ****************************************************************************/
  command result_t StdControl.init() {
    atomic{
        msg_ptr = &msg_buf;
    };
    
    atomic sending_packet = TRUE;

    call Leds.init();
    atomic sending_packet = FALSE;
    MAKE_THERM_OUTPUT();             //enable thermistor power pin as output
    MAKE_BAT_MONITOR_OUTPUT();       //enable voltage ref power pin as output
    
    call ADCControl.bindPort(TEMP_ADC_PORT, BATT_PORT);
    call ADCControl.init();
    call BattControl.init();
    call HumControl.init();
    atomic state = STATE_START;
    
    call Leds.greenOff(); 
    call Leds.yellowOff(); 
    call Leds.redOff(); 
    initialize();
   	return SUCCESS;

  }

/**
 * Start this component.
 * 
 * @return returns <code>SUCCESS</code>
 */
  command result_t StdControl.start(){
  //start sensor when timer fired, for low power.
    call StdControl.stop();
    call health_packet(TRUE, TOS_HEALTH_UPDATE);
    call Timer.start(TIMER_REPEAT, timer_rate);
    h_msg = call HealthMsgGet();
    h_msg->rsvd_app_type = SENSOR_BOARD_ID;
    return SUCCESS;	
  }
/**
 * Stop this component.
 * 
 * @return returns <code>SUCCESS</code>
 */
  command result_t StdControl.stop() {
    call BattControl.stop();
    CLEAR_BAT_MONITOR();              //turn off power to voltage ref
    CLEAR_THERM_POWER();              //turn off thermistor power
    
//    call HumControl.stop();
    return SUCCESS;    
  }

/*********************************************
event handlers
*********************************************/

/***********************************************/  
  event result_t HumControl.initDone() {
    return SUCCESS;
  }
  
  event result_t HumControl.stopDone() {
    return SUCCESS;
  }
  
  /*event result_t XOTAPLoader.boot_request(uint8_t imgId) {
    call XOTAPLoader.boot(imgId);
    return SUCCESS;
  }*/
  
/***********************************************/  
  event result_t Timer.fired() {
   // sample
      uint8_t l_state;
      atomic l_state = state;

//if timer fires 3 times and still trying to xmit old pkt, reboot
 	if ( sending_packet ){
        atomic{
            packetcnt++;
            if(packetcnt>= 3) 
              post reboot();      
        }
        return SUCCESS ;      //don't overrun buffers
    }
    switch(l_state) {
          case STATE_START:
            if (!sensinginsession){
	          start();
	          CLEAR_THERM_POWER();              //turn off thermistor power
	          SET_BAT_MONITOR();                //turn on voltage ref power
	          TOSH_uwait(255);
	          atomic sensinginsession = TRUE;
	          call ADCBATT.getData();           //get vref data;
	        }
	        break;
	      
	     default:
            packetcnt++;
            if(packetcnt>=3)
               post reboot();  
            state = STATE_START;   
            break;
	      
      }
      return SUCCESS;
  }

 /**********************************************
 * Battery Ref
 ***********************************************/

  async event result_t ADCBATT.dataReady(uint16_t data) {
  	if(sensinginsession)
  	{
      pack->xData.vref = data; //(data >> 1) & 0xff;
      CLEAR_BAT_MONITOR();              //turn off power to voltage ref     
      SET_THERM_POWER();                //turn on thermistor power
      atomic sensinginsession = FALSE;
      atomic tempFlag=1;
      TOSH_uwait(1000);
      call ADCTEMP.getData();           //get sensor data;*/
    }

      return SUCCESS;
  }

/*****************************************************************/

  async event result_t ADCTEMP.dataReady(uint16_t data) {
  	if(tempFlag==1)
  	{
  	  atomic tempFlag=0;
      pack->xData.thermistor = data;
      CLEAR_THERM_POWER();                //turn on thermistor power
      post HumStart();
    }
}

/**********************************************/  
  event result_t HumControl.startDone() {
  	atomic state = STATE_HUMIDITY;   
    call Humidity.getData();
    return SUCCESS;
  }


  event result_t HumidityError.error(uint8_t token)
  {
    post reboot();                //if problem, just reboot
    pack->xData.humidity = 0xffff;
	atomic state = STATE_TEMPERATURE;   
    call Temperature.getData();
    return SUCCESS;
  }
  
  async event result_t Humidity.dataReady(uint16_t data)
  {
	pack->xData.humidity = data;
    atomic state = STATE_TEMPERATURE;   
    call Temperature.getData();
    return SUCCESS;
  }

  event result_t TemperatureError.error(uint8_t token)
  {
    post reboot();                //if problem, just reboot
 	pack->xData.humtemp = 0xffff;
	post send_radio_msg();
	atomic state = STATE_START;  
    return SUCCESS;
  }

  async event result_t Temperature.dataReady(uint16_t data)
  {	
    pack->xData.humtemp = data;
    post HumStop();
    post send_radio_msg();
    atomic state = STATE_START;            
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
      
      if (call Send.send(BASE_STATION_ADDRESS,MODE_UPSTREAM,msg_ptr, sizeof(XDataMsg)) != SUCCESS) {
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
      packetcnt=0;
	  call StdControl.stop();
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

