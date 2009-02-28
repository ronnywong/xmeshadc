/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: XHeartbeatM.nc,v 1.1.4.2 2007/04/25 23:40:24 njain Exp $
 */

module XHeartbeatM {
  provides {
    interface StdControl;
  }
  uses {
    interface Timer;
    interface Leds;
    interface SendMsg;
  }
}implementation {

#ifdef USE_LOW_POWER
#define HEART_BEAT_INTERVAL 60000
#else
#define HEART_BEAT_INTERVAL 5000
#endif

typedef   struct   _heartbeat {
    uint16_t round;
} __attribute__((packed))  XHeartBeat_t;

  TOS_Msg gMsgBuffer;
  XHeartBeat_t *pData;
  uint16_t round;

  command result_t StdControl.init( ) {
    round = 0;
    pData = (XHeartBeat_t *)gMsgBuffer.data;
    call Leds.init();
    return SUCCESS;
  }

  command result_t StdControl.start() {
	  	//call Leds.yellowOn();
        call Timer.start(TIMER_REPEAT, HEART_BEAT_INTERVAL);
        return SUCCESS;
  }

  command result_t StdControl.stop() {
	  	call Timer.stop();
        return SUCCESS;
  }

  task void sendBeat() {
        pData->round = round++;
        if (SUCCESS==call SendMsg.send(TOS_UART_ADDR, sizeof(XHeartBeat_t), &gMsgBuffer)){
            call Leds.greenToggle();
		}
  }

  event result_t Timer.fired() {
        call Leds.yellowOff();
        post sendBeat();
        return SUCCESS;
  }

  event result_t SendMsg.sendDone(TOS_MsgPtr pMsg, result_t success) {
        return SUCCESS;
  }

}
