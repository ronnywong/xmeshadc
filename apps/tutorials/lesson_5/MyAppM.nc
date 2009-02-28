/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: MyAppM.nc,v 1.1.2.5 2007/04/26 20:02:29 njain Exp $
 */
 
#include "appFeatures.h"
includes MultiHop;
//includes sensorboard;

/**
 * This module shows how to use the Timer, LED, ADC and XMesh components.
 * Sensor messages are sent multi-hop over the RF radio
 **/
module MyAppM {
  provides {
    interface StdControl;
  }
  uses {
    interface Timer;
    interface Leds;
	interface StdControl as PhotoControl;
	interface ADC as Light;
	interface MhopSend as Send;
	interface Receive as ReceiveAck;
	interface RouteControl;
  }
}
implementation {
  bool sending_packet = FALSE;
  TOS_Msg msg_buffer;
  XDataMsg *pack;
  
  /**
   * Initialize the component.
   * 
   * @return Always returns <code>SUCCESS</code>
   **/
  command result_t StdControl.init() {
    uint16_t len;
    call Leds.init(); 
	call PhotoControl.init();

    // Initialize the message packet with default values
    atomic {
      pack = (XDataMsg*)call Send.getBuffer(&msg_buffer, &len);

      pack->board_id = SENSOR_BOARD_ID;
      pack->packet_id = 5;
	}
	
    return SUCCESS;
  }

  /**
   * Start things up.  This just sets the rate for the clock component.
   * 
   * @return Always returns <code>SUCCESS</code>
   **/
  command result_t StdControl.start() {
    // Start a repeating timer that fires every 1000ms (only if not base station)
	if (TOS_LOCAL_ADDRESS != BASE_STATION_ADDRESS)
      return call Timer.start(TIMER_REPEAT, 1000);
  }

  /**
   * Halt execution of the application.
   * This just disables the clock component.
   * 
   * @return Always returns <code>SUCCESS</code>
   **/
  command result_t StdControl.stop() {
    return call Timer.stop();
  }

  /**
   * Toggle the red LED in response to the <code>Timer.fired</code> event.  
   * Start the Light sensor control and sample the data
   *
   * @return Always returns <code>SUCCESS</code>
   **/
  event result_t Timer.fired()
  {
    call Leds.redToggle();
	call PhotoControl.start();
	call Light.getData();
	
    return SUCCESS;
  }
  
  /**
    * Stop the Light sensor control, build the message packet and send
	**/
  void task SendData()
  {
    call PhotoControl.stop();
	
    if (sending_packet) return;
    atomic sending_packet = TRUE;
    
	// send message to XMesh multi-hop networking layer
    pack->parent = call RouteControl.getParent();
    if (call Send.send(BASE_STATION_ADDRESS,MODE_UPSTREAM_ACK,&msg_buffer,sizeof(XDataMsg)) != SUCCESS) 
	  sending_packet = FALSE;
	
    return;
  }
  
 /**
   * Light ADC data ready 
   * Toggle yellow LED to signal Light sensor data sampled
   *
   * @return Always returns <code>SUCCESS</code>
   **/ 
  async event result_t Light.dataReady(uint16_t data) {
	atomic pack->light = data;
	atomic pack->vref = 417; // a dummy 3V reference voltage, 1252352/3000 = 417
    post SendData(); 
	
    return SUCCESS;
  }

 /**
   * Sensor data has been sucessfully sent through XMesh
   * Toggle green LED to signal message sent
   *
   * @return Always returns <code>SUCCESS</code>
   **/ 
  event result_t Send.sendDone(TOS_MsgPtr msg, result_t success) {
    call Leds.greenToggle();
    atomic sending_packet = FALSE;
	  
    return SUCCESS;
  }

 /**
   * Sensor data has been sucessfully sent through XMesh and
   * and acknowledgement has been sent back from the base station
   * Toggle yellow LED to signal ack message received
   *
   * @return Always returns <code>SUCCESS</code>
   **/ 
  event TOS_MsgPtr ReceiveAck.receive(TOS_MsgPtr pMsg, void* payload, uint16_t payloadLen) {
	call Leds.yellowToggle();
	
    return pMsg;
  }
}


