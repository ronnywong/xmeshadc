/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: MyAppM.nc,v 1.1.2.4 2007/04/26 19:59:38 njain Exp $
 */

includes sensorboardApp;

/**
 * This module shows how to use the Timer, LED, ADC and Messaging components
 * Sensor messages are sent to the serial port
 *
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
	interface SendMsg;
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
    call Leds.init(); 
	call PhotoControl.init();

    // Initialize the message packet with default values
    atomic {
      pack = (XDataMsg *)&(msg_buffer.data);
      pack->xSensorHeader.board_id = SENSOR_BOARD_ID;
      pack->xSensorHeader.packet_id = 2;
      pack->xSensorHeader.node_id = TOS_LOCAL_ADDRESS;
      pack->xSensorHeader.rsvd = 0;
	}
	
    return SUCCESS;
  }

  /**
   * Start things up.  This just sets the rate for the clock component.
   * 
   * @return Always returns <code>SUCCESS</code>
   **/
  command result_t StdControl.start() {
    // Start a repeating timer that fires every 1000ms
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
    
	// send message to UART (serial) port
	if (call SendMsg.send(TOS_UART_ADDR,sizeof(XDataMsg),&msg_buffer) != SUCCESS)
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
	atomic pack->xData.datap1.light = data;
	atomic pack->xData.datap1.vref = 417; // a dummy 3V reference voltage, 1252352/3000 = 417
    post SendData(); 
	call Leds.yellowToggle();
	
    return SUCCESS;
  }

 /**
   * Sensor data has been sucessfully sent over the UART (serial port)
   * Toggle green LED to signal message sent
   *
   * @return Always returns <code>SUCCESS</code>
   **/ 
  event result_t SendMsg.sendDone(TOS_MsgPtr msg, result_t success) {
	call Leds.greenToggle();
	atomic sending_packet = FALSE;

    return SUCCESS;
  }
}


