/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: XMeshCountToLedsM.nc,v 1.3.2.1 2007/04/26 19:35:20 njain Exp $
 */

includes MultiHop;
module XMeshCountToLedsM {
 	provides{
		interface StdControl;
	}
	uses{
		interface Timer;
		interface Leds;
		interface MhopSend;
		command void health_packet(bool enable, uint16_t intv);
	}

}
implementation{



  typedef struct _countMsg{
	  uint16_t nodeId;
	  uint16_t nodeCount;
  } CountMsg_t;


  uint16_t g_count;
  TOS_Msg g_msg;


  void displayCount(uint16_t value){
    if (value & 1) call Leds.redOn();
    else call Leds.redOff();
    if (value & 2) call Leds.greenOn();
    else call Leds.greenOff();
    if (value & 4) call Leds.yellowOn();
    else call Leds.yellowOff();
  }


  task void sendMsg(){

	  uint16_t bufferLength = 0;
	  CountMsg_t* countMsg = (CountMsg_t* ) call MhopSend.getBuffer(&g_msg,&bufferLength);

	  countMsg->nodeId = TOS_LOCAL_ADDRESS;
	  countMsg->nodeCount = g_count;

	  if(call MhopSend.send(BASE_STATION_ADDRESS,MODE_UPSTREAM, &g_msg, sizeof(CountMsg_t))){
		  //how do you return error...we don't have leds!

	  }

  }

  command result_t StdControl.init(){
    call Leds.init();
    g_count = 0;
    memset(&g_msg, 0, sizeof(g_msg));
    return SUCCESS;
  }

  command result_t StdControl.start() {
    call Leds.redOn();
    call Leds.yellowOn();
    call Leds.greenOn();
    call health_packet(TRUE,30);

	call Timer.start(TIMER_REPEAT, 1000);
    return SUCCESS;
  }

  command result_t StdControl.stop() {
	call Timer.stop();
    return SUCCESS;
  }

  event result_t Timer.fired(){
	  g_count++;
	  displayCount(g_count);
	  post sendMsg();
	  return SUCCESS;
  }

  event result_t MhopSend.sendDone(TOS_MsgPtr m, result_t success){
	  if (success != SUCCESS){
		  //once again error but how do we display it...no leds!

	  }
	  return SUCCESS;
  }

}

