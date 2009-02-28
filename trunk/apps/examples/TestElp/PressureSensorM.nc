/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: PressureSensorM.nc,v 1.2.4.1 2007/04/26 19:34:13 njain Exp $
 */
 
/* 
 * Author: Xin Yang (xyang@xbow.com)
 * Date:   11/05/05
 */
 
/**
 * PressureSensorM.nc - Main module for pressure sensor app
 *
 * @author Xin Yang
 * @author Alan Broad
 * @date November 13 2005
 */
 
/*===Notice: ================================================================*/
/*
 * ELP Power Strategy: 
 * - On startup:
 *     - no data sent until mote has joined the mesh
 *     - if elp route_discover() returns false, not joined to mesh 
 *
 *  This application xmits at a high data rate. It's desired to send health
 *  packets at a rate << data rate.
 * -Set elp sleep duration for 
 *    ELP_SLEEP (sec) >> DEFAULT_CACHE_SAMPLES*DEFAULT_SAMPLE_INTERVAL_SEC  
 * -Set ELP_HINT  >> ELP_SLEEP(Force_sleep = FALSE). This sends health pkt
 *    as soon as ELP_SLEEP is called to form network.
 * -Run an application Timer for the ELP_SLEEP period. When this timer times out
 *  set boolean bXmitHealth = TRUE;
 * -When ready to send data force ELP to stop:
 *      call ElpI.wake()          
 * -After data sent restart elp with :
 *     Force_sleep = TRUE, if bXmitHealth == FALSE
 *                 = FALSE, if            == TRUE;
 */
  
/*===LED Debug ==============================================================*/
/*
 * LED Debug
 * - Red    - flashes on every sensor sample (~50 msec)
 * - Green  - flashes when data xmitted to base
 * - Yellow - 
 */
 
includes SensorMsgs;
 
module PressureSensorM {
	 
  provides interface StdControl;
	
  uses {
	
    //XMesh
    interface StdControl as XMeshControl;
    interface MhopSend as COMM;
    interface RouteControl;
    interface ElpI;
    interface ElpControlI;
			
     //Timer
    interface StdControl as TimerControl;
    interface Timer as UpdateTimer;
    interface Timer as WaitTimer;
    interface Timer as HealthTimer;
 		
    //Leds
    interface Leds;
		
    //Power Management
    command result_t Enable();
    command result_t Disable();
    interface PowerManagement;
  }
	 
}
 
 
implementation {
#include "PressureSensor.h"
	 
  /*===Local state and buffer =================================================*/

  TOS_Msg dataMsg;								//buffer for outgoing msg
  TOS_MsgPtr dataMsgPtr = &dataMsg;				//ptr to that buffer	
  //ptr to data structure of payload	
  pressureMsg * pressureDataPtr;
  uint8_t Len;
	
  uint8_t gSampleCount = 0;
  bool bSending = FALSE;			//true if message being sent
  bool bSendOK = FALSE;           //true if link lvl ack received on msg xmit
  bool bXmitHealth = FALSE;			//true if time to enable elp health pkt
  uint16_t g_parent = 0xFFFF;                //Xmesh parent
	
  //adjustable values
  uint16_t gSampleInterval = DEFAULT_SAMPLE_INTERVAL;		//sample period
  uint8_t  gMaxCachedSamples = DEFAULT_CACHE_SAMPLES;		//max samples cached
	
  /*===Tasks ==================================================================*/

  //TODO: Handle Drop packets

  /**
   * Task to send data upstream to base station with no ack
   *
   * @param void
   * @return void
   */
  task void SendSamples() {	
    if (!bSending) {
      pressureDataPtr->Board_id= BOARD_ID;
      pressureDataPtr->Pkt_id = PKT_ID;
      pressureDataPtr->Parent_id = g_parent;
      pressureDataPtr->Sample_period =  DEFAULT_SAMPLE_INTERVAL_SEC;
      pressureDataPtr->NmbSamples = gSampleCount;
      if (call COMM.send(BASE_STATION_ADDRESS, MODE_UPSTREAM, dataMsgPtr, 6+(gSampleCount<<1))==FAIL){
	      gSampleCount = 0;
	      //return;
      }
      bSending = TRUE;
    }
    //gSampleCount = 0;
  }

  /**
   * Task to wake network stack to transmit data.
   * First check if this mote has a parent. Wake only if parent exists.
   * Network stack must be awake before call to send.
   *
   * @param void
   * @return void
   */
  task void XmitData() {
    //parent = call RouteControl.getParent();
		
    //only xmit if there is a parent
    if (g_parent != TOS_BCAST_ADDR) {
      call ElpI.wake();                     //wake stack  
    } else{
      gSampleCount = 0;                     //reset cache counter
    }
  }
	
  /**
   * Network Layer just sent out a message.  Put Network layer back to sleep.
   *
   * @param void
   * @return void
   */
  task void DataSent() { 
    call Leds.greenOff();	
    bSending = FALSE;
    
    if (bSendOK) {
	    if (bXmitHealth) {
		  // tx health pkt
	      call Leds.yellowToggle();
	      call ElpI.sleep(ELP_SLEEP,ELP_HINT,ELP_RETRIES,HEALTH_XMIT); 
	      bXmitHealth = FALSE;
	    } else {
		  // just sleep
	      call ElpI.sleep(ELP_SLEEP,ELP_HINT,ELP_RETRIES,NO_HEALTH_XMIT);
      	}
	} else {
		// no parents, rediscover parents
		call ElpI.route_discover(NUM_ROUTE_DISCOVER_INTS);
	}
      
    call PowerManagement.adjustPower();

  }

  /**
   * Leave Comments
   *
   * @param void
   * @return void
   */
  task void ElpSleepAgain(){
    if (bXmitHealth){
      call ElpI.sleep(ELP_SLEEP,ELP_HINT,ELP_RETRIES,HEALTH_XMIT); 
      bXmitHealth = FALSE;
    }
    else
      call ElpI.sleep(ELP_SLEEP,ELP_HINT,ELP_RETRIES,NO_HEALTH_XMIT);
  }
	
  task void route_discover_again(){
     call ElpI.route_discover(NUM_ROUTE_DISCOVER_INTS);    //try to join mesh for n ROUTE_UPDATE INTERVALS  	
  }
  
  /*===StdControl =============================================================*/

  command result_t StdControl.init() {
		
    //init peripherals
	call XMeshControl.init();
	call TimerControl.init();
	call Leds.init();
	call Enable();					//explicitly enable sleep
		
    return SUCCESS;
  }
	
  /**
   * Start the sensor module
   * UpdateTimer - acquires data
   * HealthTimer - sends health packets
   * 
   * 
   * @param void
   * @return SUCCESS
   */
  command result_t StdControl.start() {

    //start the timers
    call UpdateTimer.start(TIMER_REPEAT, gSampleInterval);
    call HealthTimer.start(TIMER_REPEAT, ELP_SLEEP_MS);
    
    //start xmesh & elp
	call XMeshControl.start();
	call ElpControlI.enable();
	call ElpI.route_discover(NUM_ROUTE_DISCOVER_INTS);    //try to join mesh for n ROUTE_UPDATE INTERVALS		
	//get correct offset in msg buffer
	pressureDataPtr = (pressureMsg * ) call COMM.getBuffer(dataMsgPtr, &Len);
    return SUCCESS;
  }
	
  command result_t StdControl.stop() {
    //stop the update timer
    call UpdateTimer.stop();
    call XMeshControl.stop();
	
    return SUCCESS;		
  }
	
  /*===XMesh Timers ===========================================================*/
	
  /**
   * Health Packets are sent only when this timer is fired.  When this fires,
   * the next data packet out would also have a Heath Packet sent with it.
   *
   * @param void
   * @return SUCCESS
   */
  event result_t HealthTimer.fired() {
	  bXmitHealth = TRUE;  //enable health packets
	  return SUCCESS;
  }  

  /*===Sensor Timers ==========================================================*/
  
  /**
   * This timer fires at the sampling rate.  Will power on the sensor and start
   * counting.  Also will start a second timer to collect the count.  Timer will
   * handle powerManagement duties.
   *
   * @param void
   * @return SUCCESS
   */
  event result_t UpdateTimer.fired() {
	if (gSampleCount == gMaxCachedSamples) return SUCCESS;	
	call Leds.redOn();		
//  turn on sensor power here
    call WaitTimer.start(TIMER_ONE_SHOT, WAIT_INTERVAL);

    return SUCCESS;
  }
	
  /**
   * Sensor data has been acquired.
   *
   * @param void
   * @return SUCCESS
   */
  event result_t WaitTimer.fired() {
    uint16_t sensorData;
		
    //get sensor data here
    
    sensorData = 0xAA;                //dummy data
    pressureDataPtr->SensorCount[gSampleCount] = sensorData;		
    //turn off sensor power here
	call Leds.redOff();
	gSampleCount++;
	if (gSampleCount == gMaxCachedSamples) post XmitData();
    return SUCCESS;
  }

  /*===XMesh events ===========================================================*/	

	/**
	 * Message was sent
	 *
	 * @param msg		pointer to the msg just sent
	 * @param success	was the send succesful
	 *
	 * @return SUCCESS
	 */
	event result_t COMM.sendDone(TOS_MsgPtr msg, result_t success) {
		if (success == SUCCESS){
			bSendOK = TRUE;
	        g_parent = call RouteControl.getParent();
		}
		else{
            g_parent = TOS_BCAST_ADDR;
		    bSendOK = FALSE;	
		    call Leds.yellowOn();
		}
		gSampleCount = 0;
        post DataSent();
		return SUCCESS;
	}
	
	/**
	 * Network stack powered up
	 *
	 * @param success	wake procedure status
	 *
	 * @return SUCCESS
	 */

   event result_t ElpI.wake_done(result_t success){
       call Leds.greenOn();	
       post SendSamples();
   }
   
  /**
   * Elp sleep cycle is over.  If FAIL, the mote might not be part of mesh.
   * If mote is part of mesh, this event should not fire unless e2e ack was 
   * dropped.
   *
   * @param success		Was the health packet sent.
   *
   * @return SUCCESS
   */
   event result_t ElpI.sleep_done(result_t success) {
	   if(success == FAIL) {
		   //try to rejoin network
		   call ElpI.route_discover(NUM_ROUTE_DISCOVER_INTS);
	   } else {
		   post ElpSleepAgain();
	   }
   }
   
  /**
   * XMesh finished trying to rejoin the network.
   *
   * @param success		Was the rejoin successful
   * @param parent		If successful what is the new parent
   *
   * @return SUCCESS
   */
   event result_t ElpI.route_discover_done(uint8_t success,uint16_t parent){
     g_parent = parent;
	 if (success == FAIL) {
	    g_parent = TOS_BCAST_ADDR; 
	    post route_discover_again();
     }
	 else post ElpSleepAgain();
   }
	  
  
}
