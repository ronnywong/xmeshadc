/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: DefaultEventM.nc,v 1.1.4.1 2007/04/27 04:55:18 njain Exp $
 */

/* Author: Ning Xu (nxu@xbow.com)
 * Date: 02/07/06
 */
module DefaultEventM {
   provides {
    interface BareSendMsg as Send;
    interface ReceiveMsg as Receive;
    interface RadioCoordinator as RadioReceiveCoordinator;
    interface RadioCoordinator as RadioSendCoordinator;
   }
   uses {
    interface BareSendMsg as SendActual;
    interface ReceiveMsg as ReceiveActual;
    interface RadioCoordinator as RadioReceiveCoordinatorActual;
    interface RadioCoordinator as RadioSendCoordinatorActual;
   }
}
implementation {

  event TOS_MsgPtr ReceiveActual.receive(TOS_MsgPtr pMsg) {
        pMsg = signal Receive.receive(pMsg);
        return pMsg;
  }
  default event TOS_MsgPtr Receive.receive(TOS_MsgPtr pMsg) {
      return pMsg;
  }

  command result_t Send.send(TOS_MsgPtr pMsg) {
     return call SendActual.send(pMsg);
  }
  event result_t SendActual.sendDone(TOS_MsgPtr pMsg, result_t success) {
  	signal Send.sendDone(pMsg,success);
    return SUCCESS;
  }
  default event result_t Send.sendDone(TOS_MsgPtr pMsg, result_t success) {
    return SUCCESS;
  }

  async event void RadioReceiveCoordinatorActual.startSymbol(uint8_t bitsPerBlock, uint8_t offset, TOS_MsgPtr msgBuff){
      signal RadioReceiveCoordinator.startSymbol(bitsPerBlock, offset, msgBuff);
  }
  default async event void RadioReceiveCoordinator.startSymbol(uint8_t bitsPerBlock, uint8_t offset, TOS_MsgPtr msgBuff){ };

  async event void RadioReceiveCoordinatorActual.byte(TOS_MsgPtr msg, uint8_t byteCount){
       signal RadioReceiveCoordinator.byte(msg, byteCount);
  }
  default async event void RadioReceiveCoordinator.byte(TOS_MsgPtr msg, uint8_t byteCount){
  }
  async event void RadioReceiveCoordinatorActual.blockTimer(){
       signal RadioReceiveCoordinator.blockTimer();
  }
  default async event void RadioReceiveCoordinator.blockTimer(){
  }
//RadioSendCoordinator
  async event void RadioSendCoordinatorActual.startSymbol(uint8_t bitsPerBlock, uint8_t offset, TOS_MsgPtr msgBuff){
      signal RadioSendCoordinator.startSymbol(bitsPerBlock, offset, msgBuff);
  }
  default async event void RadioSendCoordinator.startSymbol(uint8_t bitsPerBlock, uint8_t offset, TOS_MsgPtr msgBuff){ };

  async event void RadioSendCoordinatorActual.byte(TOS_MsgPtr msg, uint8_t byteCount){
       signal RadioSendCoordinator.byte(msg, byteCount);
  }
  default async event void RadioSendCoordinator.byte(TOS_MsgPtr msg, uint8_t byteCount){
  }
  async event void RadioSendCoordinatorActual.blockTimer(){
       signal RadioReceiveCoordinator.blockTimer();
  }
  default async event void RadioSendCoordinator.blockTimer(){
  }
}
