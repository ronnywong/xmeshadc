/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: AMStandard.nc,v 1.2.2.1 2007/04/27 05:59:20 njain Exp $
 */
 
/*
 *
 * Authors:		Jason Hill, David Gay, Philip Levis
 * Date last modified:  6/25/02
 *
 */

//This is an AM messaging layer implementation that understands multiple
// output devices.  All packets addressed to TOS_UART_ADDR are sent to the UART
// instead of the radio.


/**
 * @author Jason Hill
 * @author David Gay
 * @author Philip Levis
 */

module AMStandard
{
  provides {
    interface StdControl as Control;
    
    // The interface are as parameterised by the active message id
    interface SendMsg[uint8_t id];
    interface ReceiveMsg[uint8_t id];

    // How many packets were received in the past second
    command uint16_t activity();
  }

  uses {
    // signaled after every send completion for components which wish to
    // retry failed sends
    event result_t sendDone();

    interface StdControl as UARTControl;
    interface BareSendMsg as UARTSend;
    interface ReceiveMsg as UARTReceive;

    interface StdControl as RadioControl;
    interface BareSendMsg as RadioSend;
    interface ReceiveMsg as RadioReceive;
    interface StdControl as TimerControl;
    interface Timer as ActivityTimer;
    interface PowerManagement;
  }
}
implementation
{
  bool state;
  TOS_MsgPtr buffer;
  uint16_t lastCount;
  uint16_t counter;
  
  // Initialization of this component
  command result_t Control.init() {
    result_t ok1, ok2;

    call TimerControl.init();
    ok1 = call UARTControl.init();
    ok2 = call RadioControl.init();

    state = FALSE;
    lastCount = 0;
    counter = 0;
    dbg(DBG_BOOT, "AM Module initialized\n");

    return rcombine(ok1, ok2);
  }

  // Command to be used for power managment
  command result_t Control.start() {
    result_t ok0 = call TimerControl.start();
    result_t ok1 = call UARTControl.start();
    result_t ok2 = call RadioControl.start();
    result_t ok3 = call ActivityTimer.start(TIMER_REPEAT, 1000);

    //HACK -- unset start here to work around possible lost calls to 
    // sendDone which seem to occur when using power management.  SRM 4.4.03
    state = FALSE;

    call PowerManagement.adjustPower();

    return rcombine4(ok0, ok1, ok2, ok3);
  }

  
  command result_t Control.stop() {
    result_t ok1 = call UARTControl.stop();
    result_t ok2 = call RadioControl.stop();
    result_t ok3 = call ActivityTimer.stop();
    // call TimerControl.stop();
    call PowerManagement.adjustPower();
    return rcombine3(ok1, ok2, ok3);
  }

  command uint16_t activity() {
    return lastCount;
  }
  
  void dbgPacket(TOS_MsgPtr data) {
    uint8_t i;

    for(i = 0; i < sizeof(TOS_Msg); i++)
      {
	dbg_clear(DBG_AM, "%02hhx ", ((uint8_t *)data)[i]);
      }
    dbg_clear(DBG_AM, "\n");
  }

  // Handle the event of the completion of a message transmission
  result_t reportSendDone(TOS_MsgPtr msg, result_t success) {
    state = FALSE;
    signal SendMsg.sendDone[msg->type](msg, success);
    signal sendDone();

    return SUCCESS;
  }

  event result_t ActivityTimer.fired() {
    lastCount = counter;
    counter = 0;
    return SUCCESS;
  }
  
  default event result_t SendMsg.sendDone[uint8_t id](TOS_MsgPtr msg, result_t success) {
    return SUCCESS;
  }
  default event result_t sendDone() {
    return SUCCESS;
  }

  // This task schedules the transmission of the Active Message
  task void sendTask() {
    result_t ok;
    TOS_MsgPtr buf;
    buf = buffer;
    if (buf->addr == TOS_UART_ADDR)
      ok = call UARTSend.send(buf);
    else
      ok = call RadioSend.send(buf);

    if (ok == FAIL) // failed, signal completion immediately
      reportSendDone(buffer, FAIL);
  }

  // Command to accept transmission of an Active Message
  command result_t SendMsg.send[uint8_t id](uint16_t addr, uint8_t length, TOS_MsgPtr data) {
    if (!state) {
      state = TRUE;
      if (length > DATA_LENGTH) {
	dbg(DBG_AM, "AM: Send length too long: %i. Fail.\n", (int)length);
	state = FALSE;
	return FAIL;
      }
      if (!(post sendTask())) {
	dbg(DBG_AM, "AM: post sendTask failed.\n");
	state = FALSE;
	return FAIL;
      }
      else {
	buffer = data;
	data->length = length;
	data->addr = addr;
	data->type = id;
	buffer->group = TOS_AM_GROUP;
	dbg(DBG_AM, "Sending message: %hx, %hhx\n\t", addr, id);
	dbgPacket(data);
      }
      return SUCCESS;
    }
    
    return FAIL;
  }

  event result_t UARTSend.sendDone(TOS_MsgPtr msg, result_t success) {
    return reportSendDone(msg, success);
  }
  event result_t RadioSend.sendDone(TOS_MsgPtr msg, result_t success) {
    return reportSendDone(msg, success);
  }

  // Handle the event of the reception of an incoming message
  TOS_MsgPtr received(TOS_MsgPtr packet)  __attribute__ ((C, spontaneous)) {
    uint16_t addr = TOS_LOCAL_ADDRESS;
    counter++;
    dbg(DBG_AM, "AM_address = %hx, %hhx; counter:%i\n", packet->addr, packet->type, (int)counter);

    if (packet->crc == 1 && // Uncomment this line to check crcs
	packet->group == TOS_AM_GROUP &&
	(packet->addr == TOS_BCAST_ADDR ||
	 packet->addr == addr))
      {

	uint8_t type = packet->type;
	TOS_MsgPtr tmp;
	// Debugging output
	dbg(DBG_AM, "Received message:\n\t");
	dbgPacket(packet);
	dbg(DBG_AM, "AM_type = %d\n", type);

	// dispatch message
	tmp = signal ReceiveMsg.receive[type](packet);
	if (tmp) 
	  packet = tmp;
      }
    return packet;
  }

  // default do-nothing message receive handler
  default event TOS_MsgPtr ReceiveMsg.receive[uint8_t id](TOS_MsgPtr msg) {
    return msg;
  }

  event TOS_MsgPtr UARTReceive.receive(TOS_MsgPtr packet) {
    // A serial cable is not a shared medium and does not need group-id
    // filtering
    packet->group = TOS_AM_GROUP;
    return received(packet);
  }
  event TOS_MsgPtr RadioReceive.receive(TOS_MsgPtr packet) {
    return received(packet);
  }
}

