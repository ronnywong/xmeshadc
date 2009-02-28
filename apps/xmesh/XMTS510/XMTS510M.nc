/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: XMTS510M.nc,v 1.5.2.7 2007/04/26 20:23:28 njain Exp $
 */

/** 
 * XSensor multi-hop application for MTS510 sensorboard.
 *
 *
 *    -Tests the MTS510 Mica2Dot Sensor Board
 *     Reads the light and accelerometer sensor readings
 *     Reads a sound sample
 *--------------------------------------------------------
 * Output results through mica2dot uart and radio. 
 * Use Xlisten.exe program to view data from either port:
 *  uart: mount mica2dot on mib510 with MTS510
 *        connect serial cable to PC
 *        run xlisten.exe at 19200 baud
 *  radio: run mica2dot with or without MTS510, 
 *         run mica2 with TOSBASE
 *         run xlisten.exe at 57600 baud
 *--------------------------------------------------------
 * Data packet structure  :
 *  msg->data[0] : sensor id, MTS510 = 0x02
 *  msg->data[1] : packet id
 *  msg->data[2] : node id
 *  msg->data[3] : reserved
 *  msg->data[4,5] : Light ADC data
 *  msg->data[6,7] : ACCEL - X-axis data
 *  msg->data[8,9] : ACCEL - Y-axis data
 *  msg->data[10,11] : Sound sample 0
 *  msg->data[12,13] : Sound sample 1
 *  msg->data[14,15] : Sound sample 2
 *  msg->data[16,17] : Sound sample 3
 *  msg->data[18,19] : Sound sample 4
 * 
 *--------------------------------------------------------
 *
 * @author Martin Turon, Alan Broad, Hu Siquan, Pi Peng
 */


#define STATE_WAITING 0
#define STATE_LIGHT   1
#define STATE_ACCEL   2
#define STATE_SOUND   3

#define SOUNDSAMPLES  5

#include "appFeatures.h"
includes XCommand;
includes sensorboard;

module XMTS510M 
{
  provides interface StdControl;
  uses 
  {
	interface Leds;

	interface MhopSend as Send;
	interface RouteControl;
	interface XCommand;
	interface XEEControl;

    interface Timer;
    interface Timer as MicTimer;
    
// Battery    
    interface ADC as ADCBATT;
    interface StdControl as BattControl;

//Temp
    interface ADC as ADCTEMP;
    
    interface StdControl as AccelControl;
    interface ADC as AccelX;
    interface ADC as AccelY;
    interface StdControl as MicControl;
    interface ADC as MicADC;
    interface Mic;
    interface ADC as PhotoADC;
    interface StdControl as PhotoControl;
    
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

implementation
{

#define MSG_LEN  36

  TOS_Msg msg_buf;
  TOS_MsgPtr msg_ptr;

  bool sending_packet;
  bool  bIsUart;
  uint8_t tempFlag;
  uint8_t state;
  norace uint8_t samplecount;
  norace XDataMsg pack;
  HealthMsg *h_msg;
  norace bool	bGetVoltRef,sensinginsession;


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
    	  bGetVoltRef=TRUE;
    	  sensinginsession=FALSE;
      }
    }
    
  static void start() 
    {
    call MicControl.start();
    call PhotoControl.start();
    TOSH_uwait(3000);
    state = STATE_LIGHT;

    }
    
    task void stop()
    {
    	call StdControl.stop();
    }

task void send_radio_msg() {

    uint16_t  len;
	XDataMsg *data;
    uint8_t i;
    if(sending_packet) return; 
    atomic sending_packet=TRUE;  

    data = (XDataMsg*)call Send.getBuffer(msg_ptr, &len);
	for (i=0; i<= sizeof(XDataMsg)-1; i++)
		((uint8_t*) data)[i] = ((uint8_t*)&pack)[i];
    data->xMeshHeader.board_id = SENSOR_BOARD_ID;
    data->xMeshHeader.packet_id = 3;     
    //data->xMeshHeader.node_id = TOS_LOCAL_ADDRESS;
    data->xMeshHeader.parent    = call RouteControl.getParent();
    data->xMeshHeader.packet_id=data->xMeshHeader.packet_id | 0x80;

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



  /*************************************** 
     initialize lower components.
  ***************************************/
  command result_t StdControl.init() 
  {

    sending_packet = TRUE;
    atomic{
    msg_ptr = &msg_buf;
    }

    call Leds.init();
    sending_packet = FALSE;
    
    MAKE_THERM_OUTPUT();             //enable thermistor power pin as output
    MAKE_BAT_MONITOR_OUTPUT();       //enable voltage ref power pin as output
    
    call MicControl.init();
    call Mic.muxSel(1);  // Set the mux so that raw microhpone output is selected
    call Mic.gainAdjust(64);  // Set the gain of the microphone. (refer to Mic) 
    call PhotoControl.init();
    call AccelControl.init();
    call ADCControl.bindPort(TEMP_ADC_PORT, BATT_TEMP_PORT);
    call ADCControl.init();
    call BattControl.init();
    state = STATE_WAITING;
    samplecount = 0;
    tempFlag=0;
    initialize();
    return SUCCESS;
  }

  command result_t StdControl.start() 
  {
    call StdControl.stop();
    h_msg = call HealthMsgGet();
    h_msg->rsvd_app_type = SENSOR_BOARD_ID;
    call health_packet(TRUE,TOS_HEALTH_UPDATE);
    call Timer.start(TIMER_REPEAT, timer_rate);
    return SUCCESS;
  }

  command result_t StdControl.stop() 
  {
    CLEAR_BAT_MONITOR();              //turn off power to voltage ref     
    CLEAR_THERM_POWER();                //turn on thermistor power
    call PhotoControl.stop();
    call MicControl.stop();
    return SUCCESS;
  }

/*********************************************
event handlers
*********************************************/

/***********************************************/  
  event result_t Timer.fired() 
  {
    if(sending_packet) return SUCCESS;
    bIsUart=TRUE;
    start();
   CLEAR_THERM_POWER();              //turn off thermistor power
   SET_BAT_MONITOR();                //turn on voltage ref power
   atomic bGetVoltRef = TRUE;
   if (!sensinginsession){
	      	call ADCBATT.getData();
        atomic sensinginsession = TRUE;
  }           //get sensor data;
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
      call PhotoADC.getData();                    //get sensor data;
    }
      return SUCCESS;
}

/*******************************************/
  async event result_t PhotoADC.dataReady(uint16_t data)
  {
	pack.xData.datap1.light = data;
	TOSH_uwait(200);
	call AccelX.getData();
	return SUCCESS;
  }  

/**********************************************/
  async event result_t AccelX.dataReady(uint16_t  data)
  {
	pack.xData.datap1.accelX   = data ;
	call AccelY.getData();

    return SUCCESS;
  }

/**************************************************/
  async event result_t AccelY.dataReady(uint16_t  data)
  {
	pack.xData.datap1.accelY = data ;
	call MicControl.start();
	call MicTimer.start(TIMER_ONE_SHOT, 200);

    return SUCCESS;
  }

event result_t MicTimer.fired() 
{
	call MicADC.getData();
	return SUCCESS;
}

/***************************************************/    
async event result_t MicADC.dataReady(uint16_t data)
{

    atomic {
       pack.xData.datap1.sound[samplecount] = data ;
    }
       post send_radio_msg();

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
