/*
 * Copyright (c) 2002-2005 Intel Corporation
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: FramerAckM.nc,v 1.1.4.1 2007/04/27 06:00:19 njain Exp $
 */

/* FramerAckM
 *
 * This module provides a generic acknowledgement handler for framed
 * token packets from FramerM.
 */

/**
 * @author Phil Buonadonna
 */


includes AM;

module FramerAckM {

  provides {
    interface ReceiveMsg as ReceiveCombined;
  }

  uses {
    interface TokenReceiveMsg;
    interface ReceiveMsg;
  }

}

implementation {

  uint8_t gTokenBuf;

  task void SendAckTask() {
    
    call TokenReceiveMsg.ReflectToken(gTokenBuf);
  }

  event TOS_MsgPtr TokenReceiveMsg.receive(TOS_MsgPtr Msg, uint8_t token) {
    TOS_MsgPtr pBuf;
    
    gTokenBuf = token;
    
    post SendAckTask();
    
    pBuf = signal ReceiveCombined.receive(Msg);
    
    return pBuf;
  }
  
  event TOS_MsgPtr ReceiveMsg.receive(TOS_MsgPtr Msg) {
    TOS_MsgPtr pBuf;
    
    pBuf = signal ReceiveCombined.receive(Msg);
    
    return pBuf;

  }
  
}
