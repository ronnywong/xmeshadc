/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: TOSBaseM.nc,v 1.3.4.2 2007/04/26 19:37:20 njain Exp $
 */

/*
 * Author:	Phil Buonadonna
 */

/* TOSBaseM
   - captures all the packets that it can hear and report it back to the UART
   - forward all incoming UART messages out to the radio
*/

/**
 * @author Phil Buonadonna
 */


module TOSBaseM {
  provides interface StdControl;
  uses {
    interface StdControl as UARTControl;
    interface BareSendMsg as UARTSend;
    interface ReceiveMsg as UARTReceive;
    interface TokenReceiveMsg as UARTTokenReceive;

    interface StdControl as RadioControl;
    interface BareSendMsg as RadioSend;
    interface ReceiveMsg as RadioReceive;

    interface Leds;
    async command result_t Setbaud(uint32_t baud_rate);

#ifdef FLS_DEBUG
    interface Timer;
#endif
  }
}
implementation
{
  enum {
    QUEUE_SIZE = 15
  };

  enum {
    TXFLAG_BUSY = 0x1,
    TXFLAG_TOKEN = 0x2
  };


  TOS_Msg gRxBufPool[QUEUE_SIZE];
  TOS_MsgPtr gRxBufPoolTbl[QUEUE_SIZE];
  uint8_t gRxHeadIndex,gRxTailIndex;

  TOS_Msg    gTxBuf;
  TOS_MsgPtr gpTxMsg;
  uint8_t    gTxPendingToken;
  uint8_t    gfTxFlags;
  uint32_t time;
#define FLS_FIX
#ifdef FLS_FIX
  uint8_t num_msgs_pending;
  uint8_t radio_rcvd_task_flags;
#define RRT_ACTIVE 1	/* Waiting Senddone */
#define RRT_POSTED 2	/* Posted not yet active */
#endif

  task void RadioRcvdTask() {
    TOS_MsgPtr pMsg;
    result_t   Result;
	uint32_t* t_val;
    dbg (DBG_USR1, "TOSBase forwarding Radio packet to UART\n");

#ifdef FLS_FIX
    atomic {
	radio_rcvd_task_flags &= ~RRT_POSTED;
    }
    TOSH_SET_YELLOW_LED_PIN();
    if (num_msgs_pending == 0)
	return;
#else
	if(gRxTailIndex == gRxHeadIndex) return;
#endif
    atomic {
      pMsg = gRxBufPoolTbl[gRxTailIndex];
    }
    Result = call UARTSend.send(pMsg);
    if (Result != SUCCESS) {
	//call Leds.yellowToggle();
    }
    else {
	atomic{
		gRxTailIndex++; gRxTailIndex %= QUEUE_SIZE;
#ifdef FLS_FIX
		radio_rcvd_task_flags |= RRT_ACTIVE; /* Turned off in sendDone */
#endif
	}
	TOSH_CLR_GREEN_LED_PIN();
    }
  }

  task void UARTRcvdTask() {
    result_t Result;

    dbg (DBG_USR1, "TOSBase forwarding UART packet to Radio\n");
    gpTxMsg->group = TOS_AM_GROUP;
    Result = call RadioSend.send(gpTxMsg);

    if (Result != SUCCESS) {
      atomic gfTxFlags = 0;
    }
    else {
      call Leds.redToggle();
    }
  }

  task void SendAckTask() {
     call UARTTokenReceive.ReflectToken(gTxPendingToken);
     //call Leds.yellowToggle();
     atomic {
       gpTxMsg->length = 0;
       gfTxFlags = 0;
     }
  }

  command result_t StdControl.init() {
    result_t ok1, ok2, ok3;
    uint8_t i;

   TOS_LOCAL_ADDRESS = 0xFF00;              //make sure it doesn't ack
    for (i = 0; i < QUEUE_SIZE; i++) {
      gRxBufPool[i].length = 0;
      gRxBufPoolTbl[i] = &gRxBufPool[i];
    }
    gRxHeadIndex = 0;
    gRxTailIndex = 0;

    gTxBuf.length = 0;
    gpTxMsg = &gTxBuf;
    gfTxFlags = 0;

    ok1 = call UARTControl.init();
    ok2 = call RadioControl.init();
    ok3 = call Leds.init();

#ifdef FLS_FIX
    num_msgs_pending = 0;
#endif
    dbg(DBG_BOOT, "TOSBase initialized\n");

    return rcombine3(ok1, ok2, ok3);
  }

  command result_t StdControl.start() {
    result_t ok1, ok2;

    ok1 = call UARTControl.start();
    ok2 = call RadioControl.start();
    call Setbaud((uint32_t)115200);    //set baud rate to 11520 for XSniffer
#ifdef FLS_DEBUG
    call Timer.start(TIMER_REPEAT,2000);
#endif

    return rcombine(ok1, ok2);
  }

  command result_t StdControl.stop() {
    result_t ok1, ok2;

    ok1 = call UARTControl.stop();
    ok2 = call RadioControl.stop();
#ifdef FLS_DEBUG
    call Timer.stop();
#endif

    return rcombine(ok1, ok2);
  }

#ifdef FLS_DEBUG
  event result_t Timer.fired () {
      TOSH_SET_RED_LED_PIN(); /* Want to see if Radio is active */
      TOSH_SET_YELLOW_LED_PIN();

      return SUCCESS;
  }
#endif
  event TOS_MsgPtr RadioReceive.receive(TOS_MsgPtr Msg) {
    TOS_MsgPtr pBuf;

    dbg(DBG_USR1, "TOSBase received radio packet.\n");

    if (Msg->crc)
    {

      /* Filter out messages by group id */
      //if (Msg->group != TOS_AM_GROUP)
        //return Msg;

      atomic {

#ifdef FLS_FIX
	  if (num_msgs_pending == QUEUE_SIZE) {
	      pBuf = NULL; /* No more room to put stuff in q. */
	  } else
#endif /* FLS_FIX */
	  {
	      //Msg->data[0] = Msg->strength;
	      //Msg->data[1] = Msg->strength >> 8;
	      pBuf = gRxBufPoolTbl[gRxHeadIndex];
#ifdef not_required
	      if (pBuf->length == 0)
#endif /* not_required */
	      { /* THIS CHECK is NOT REQURIED ** NARAYAN **/
		  gRxBufPoolTbl[gRxHeadIndex] = Msg;
		  gRxHeadIndex++; gRxHeadIndex %= QUEUE_SIZE;
#ifdef FLS_FIX
		  num_msgs_pending++;
#endif
	      }
#ifdef not_required
	      else
	      {
		  TOSH_CLR_YELLOW_LED_PIN();
		  pBuf = NULL;
	      }
#endif /* not_required */
	  }
#ifdef FLS_FIX
	  /*
	   * In case the send earlier had failed,
	   * we always post a new radiorcvd task(and always whenever there is
	   * one that is not active).
	   */
	  TOSH_CLR_YELLOW_LED_PIN();
	  if ((radio_rcvd_task_flags & (RRT_POSTED|RRT_ACTIVE)) == 0) {
	      radio_rcvd_task_flags |= RRT_POSTED;
	      post RadioRcvdTask();
	  }
#endif
	  if (pBuf) {
#ifndef FLS_FIX
		post RadioRcvdTask();
#endif
		TOSH_SET_RED_LED_PIN();
	  }
	  else {
	      TOSH_CLR_RED_LED_PIN();
	      pBuf = Msg;
	  }
      }
    }
    else {
      pBuf = Msg;
    }
    return pBuf;
  }

  event TOS_MsgPtr UARTReceive.receive(TOS_MsgPtr Msg) {
    TOS_MsgPtr  pBuf;

    dbg(DBG_USR1, "TOSBase received UART packet.\n");

    atomic {
      if (gfTxFlags & TXFLAG_BUSY) {
        pBuf = NULL;
      }
      else {
        pBuf = gpTxMsg;
        gfTxFlags |= (TXFLAG_BUSY);
        gpTxMsg = Msg;

      }
    }

    if (pBuf == NULL) {
      pBuf = Msg;
    }
    else {
      post UARTRcvdTask();
    }

    return pBuf;

  }

  event TOS_MsgPtr UARTTokenReceive.receive(TOS_MsgPtr Msg, uint8_t Token) {
    TOS_MsgPtr  pBuf;

    dbg(DBG_USR1, "TOSBase received UART token packet.\n");

    atomic {
      if (gfTxFlags & TXFLAG_BUSY) {
        pBuf = NULL;
      }
      else {
        pBuf = gpTxMsg;
        gfTxFlags |= (TXFLAG_BUSY | TXFLAG_TOKEN);
        gpTxMsg = Msg;
        gTxPendingToken = Token;
      }
    }

    if (pBuf == NULL) {
      pBuf = Msg;
    }
    else {

      post UARTRcvdTask();
    }

    return pBuf;
  }

  event result_t UARTSend.sendDone(TOS_MsgPtr Msg, result_t success) {

#ifdef FLS_FIX
      uint8_t do_post;

      atomic {
	  radio_rcvd_task_flags &= ~RRT_ACTIVE; /* The sendDone has been signalled */
	  if ((--num_msgs_pending != 0) && !(radio_rcvd_task_flags & RRT_POSTED)) {
	      radio_rcvd_task_flags |= RRT_POSTED;
	      do_post = 1;
	  } else
	      do_post = 0;
      }
      if (do_post)
	  post RadioRcvdTask ();
#else
	  post RadioRcvdTask();
#endif /* FLS_FIX */
    Msg->length = 0;
    TOSH_SET_GREEN_LED_PIN();

    return SUCCESS;
  }

  event result_t RadioSend.sendDone(TOS_MsgPtr Msg, result_t success) {


    if ((gfTxFlags & TXFLAG_TOKEN)) {
      if (success == SUCCESS) {

        post SendAckTask();
      }
    }
    else {
      atomic {
        gpTxMsg->length = 0;
        gfTxFlags = 0;
      }
    }
    return SUCCESS;
  }

}
