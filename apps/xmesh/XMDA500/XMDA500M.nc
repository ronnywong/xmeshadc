/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: XMDA500M.nc,v 1.4.4.4 2007/04/26 20:10:59 njain Exp $
 */

/** 
 * XSensor multi-hop application for MDA500 sensorboard.
 *
 *    -Measures mica2dot battery voltage using the on-board voltage reference. 
 *     As the battery voltage changes the Atmega ADC's full scale decreases. By
 *     measuring a known voltage reference the battery voltage can be computed.
 *
 *
 *    - Measure the mica2dot thermistor resistance.
 *      The thermistor and voltage reference share the same adc channel (ADC1).
 *      They have indiviual on/off controls:
 *      thermistor:  PW6 = lo => on; PW6 = hi => off
 *      voltage ref: PW7 = lo => on; PW7 = hi => off
 *      They cannot both be turned on together.
 *      Give ~msec of settling time after applying power before making a measurement.
 *
 *    -Tests the MDA500 general prototyping card (see Crossbow MTS Series User Manaul)
 *     Read and control all MDA500 signals:
 *     - reads ADC2,ADC3,...ADC7 inputs
 *     - toggles the following MDA500 I/O lines at a 1Hz rate:
 *       THERM_PWR (GPS_EN on mica2dot pcb), PWM1B,INT1,INT0,PW0,PW1
 *-----------------------------------------------------------------------------
 * Output results through mica2dot uart and radio. 
 * Use Console.exe program to view data from either port:
 *  uart: mount mica2dot on mib510 with or without MDA500
 *        connect serial cable to PC
 *        run xlisten.exe at 19200 baud
 *  radio: run mica2dot with or withouth MDA500, 
 *         run mica2 with TOSBASE
 *         run xlisten.exe at 56K baud
 *-----------------------------------------------------------------------------
 * Data packet structure  :
 *  msg->data[0] : sensor id, MDA500 = 0x1
 *  msg->data[1] : packet id
 *  msg->data[2] : node id
 *  msg->data[3] : reserved
 *  msg->data[4,5] : battery adc data
 *  msg->data[6,7] : thermistor adc data
 *  msg->data[8,9] : adc2 data
 *  msg->data[10,11] : adc3 data
 *  msg->data[12,13] : adc4 data
 *	msg->data[14,15] : adc5 data
 *	msg->data[16,17] : adc6 data
 *  msg->data[18,19] : adc7 data
 * 
 *------------------------------------------------------------------------------
 * Mica2Dot:
 * The thermistor and voltage reference share the same adc channel (ADC1).
 * They have indiviual on/off controls:
 *  thermistor:  PW6 = lo => on; PW6 = hi => off
 *  voltage ref: PW7 = lo => on; PW7 = hi => off
 *  They cannot both be turned on together.
 *  Give ~msec of settling time after applying power before making a measurement.
 *
 * @author Martin Turon, Alan Broad, Hu Siquan, Pi Peng
 */
 
 
#include "appFeatures.h"
includes XCommand;

module XMDA500M {
  provides {
    interface StdControl;
  }
  uses {
	interface Leds;
	interface MhopSend as Send;
	interface RouteControl;
	interface XCommand;
	interface XEEControl;
    interface Timer;

  //  interface Clock;
// Battery    
    interface ADC as ADCBATT;
    interface StdControl as BattControl;

//Temp
    interface ADC as ADCTEMP;
    
    interface ADC as ADC2;
    interface ADC as ADC3;
    interface ADC as ADC4;
    interface ADC as ADC5;
    interface ADC as ADC6;
    interface ADC as ADC7;
    

  	interface ADCControl;

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
  enum {STATE0 = 0, STATE1,STATE2};
  
  #define MSG_LEN  29 

   TOS_Msg msg_buf;
   TOS_MsgPtr msg_ptr;
   HealthMsg *h_msg;
   norace bool sending_packet,sensinginsession;
   norace bool bGetVoltRef;
   bool bIOon;
   bool bLedOn;
   bool bIsUart;
   uint8_t tempFlag;
   norace uint8_t state;
   norace XDataMsg pack;
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
   	 SET_INT0();
	 SET_INT1();
	 SET_PW0();
	 SET_PW1();
	 SET_PWM1B();
	 SET_GPS_ENA();
	 call BattControl.start();
  } 
  task void stop()
  {
       call StdControl.stop();
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
    atomic{
	bGetVoltRef = TRUE;
    //bIsUart=TRUE;
    sending_packet=FALSE;
    atomic{
    msg_ptr = &msg_buf;
    }
    state = STATE0;
    };
// set atmega pin directions for mda500	
    MAKE_THERM_OUTPUT();             //enable thermistor power pin as output
    MAKE_BAT_MONITOR_OUTPUT();       //enable voltage ref power pin as output
    MAKE_INT0_OUTPUT();
    MAKE_INT1_OUTPUT();
    MAKE_PWO_OUTPUT();
    MAKE_PW1_OUTPUT();
    MAKE_PWM1B_OUTPUT();
    MAKE_GPS_ENA_OUTPUT();
    call ADCControl.bindPort(TEMP_ADC_PORT, BATT_TEMP_PORT);
    call ADCControl.init();
    call Leds.init();
    call BattControl.init();
    atomic tempFlag=0;
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
    call health_packet(TRUE,TOS_HEALTH_UPDATE);
    call Timer.start(TIMER_REPEAT, timer_rate);
    return SUCCESS;	
  }
 /****************************************************************************
 * Stop the component.
 *
 ****************************************************************************/
  command result_t StdControl.stop() {
   call BattControl.stop();   
   CLEAR_THERM_POWER();                //turn on thermistor power
   CLR_INT0();
   CLR_INT1();
   CLR_PW0();
   CLR_PW1();
   CLR_PWM1B();
   CLR_GPS_ENA();
   return SUCCESS;    
  }
/****************************************************************************
 * Measure voltage ref  
 *
 ****************************************************************************/
event result_t Timer.fired() {
   uint8_t l_state;
  
   if(sending_packet)
        return SUCCESS;      
   bIsUart = TRUE;
   start();
   atomic l_state = state;
   if (!sensinginsession){
   CLEAR_THERM_POWER();              //turn off thermistor power
   SET_BAT_MONITOR();                //turn on voltage ref power
   atomic sensinginsession = TRUE;
   call ADCBATT.getData();
  }
   return SUCCESS;  
  }
/****************************************************************************
 * Battery Ref  or thermistor data ready 
 ****************************************************************************/
  async event result_t ADCBATT.dataReady(uint16_t data) {
  
  	if(sensinginsession)
  	{
      pack.xData.datap1.vref = data;
      CLEAR_BAT_MONITOR();              //turn off power to voltage ref     
      SET_THERM_POWER();                //turn on thermistor power
      TOSH_uwait(1000);
      atomic sensinginsession = FALSE;
      atomic tempFlag=1;
      call ADCTEMP.getData();           //get sensor data;*/
    }
      return SUCCESS;
  }

  async event result_t ADCTEMP.dataReady(uint16_t data) {
  	if(tempFlag==1)
  	{
  		atomic tempFlag=0;
      pack.xData.datap1.thermistor = data;
      CLEAR_THERM_POWER();                //turn on thermistor power
      call ADC2.getData();                    //get sensor data;
    }
}

 /****************************************************************************
 * ADC data ready 
 * Read and get next channel.
 ****************************************************************************/ 
  async event result_t ADC2.dataReady(uint16_t data) {
       pack.xData.datap1.adc2 = data;
	   call ADC3.getData();         //get sensor data;
       return SUCCESS;
   }
 /****************************************************************************
 * ADC data ready 
 * Read and get next channel.
 ****************************************************************************/ 
  async event result_t ADC3.dataReady(uint16_t data) {
       pack.xData.datap1.adc3 = data;
	   call ADC4.getData();         //get sensor data;
       return SUCCESS;
   }
 /****************************************************************************
 * ADC data ready 
 * Read and get next channel.
 ****************************************************************************/ 
  async event result_t ADC4.dataReady(uint16_t data) {
       pack.xData.datap1.adc4 = data;
	   call ADC5.getData();         //get sensor data;
       return SUCCESS;
   }
 /****************************************************************************
 * ADC data ready 
 * Read and get next channel.
 ****************************************************************************/ 
  async event result_t ADC5.dataReady(uint16_t data) {
       pack.xData.datap1.adc5 = data;
	   call ADC6.getData();         //get sensor data;
       return SUCCESS;
   }
 /****************************************************************************
 * ADC data ready 
 * Read and get next channel.
 ****************************************************************************/ 
  async event result_t ADC6.dataReady(uint16_t data) {
       pack.xData.datap1.adc6 = data;
	   call ADC7.getData();         //get sensor data;
       return SUCCESS;
   }
 /****************************************************************************
 * ADC data ready 
 * Read and get next channel.
 * Send data packet
 ****************************************************************************/ 
  async event result_t ADC7.dataReady(uint16_t data) {
       pack.xData.datap1.adc7 = data;
       post send_radio_msg();
       atomic state = STATE0;     
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

