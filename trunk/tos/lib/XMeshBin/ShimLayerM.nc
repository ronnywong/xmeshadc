/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: ShimLayerM.nc,v 1.5.2.1 2007/04/25 23:44:03 njain Exp $
 */
 
module ShimLayerM {
  provides {
      interface Receive[uint8_t id];
      interface Receive as ReceiveAck[uint8_t id];
      interface Intercept[uint8_t socket];
      interface Intercept as Snoop[uint8_t socket];
      interface MhopSend[uint8_t id];
      interface Send[uint8_t id];
      interface ElpI;
      interface XOtapLoader; 
  }
  uses {
      interface Receive as ReceiveActual[uint8_t id];
      interface Receive as ReceiveAckActual[uint8_t id];
      interface Intercept as InterceptActual[uint8_t socket];
      interface Intercept as SnoopActual[uint8_t socket];
      interface MhopSend as MhopSendActual[uint8_t id];
      interface Send as SendActual[uint8_t id];
      interface ElpI as ElpIActual;
      interface XOtapLoader as XOtapLoaderActual;
  }
}

implementation {
  event TOS_MsgPtr ReceiveActual.receive[uint8_t socket](TOS_MsgPtr pMsg, void* payload, uint16_t payloadLen) {
        pMsg = signal Receive.receive[socket](pMsg,payload,payloadLen);
        return pMsg;
  }
  default event TOS_MsgPtr Receive.receive[uint8_t socket](TOS_MsgPtr pMsg, void* payload, uint16_t payloadLen) {
      return pMsg;
  }
  event TOS_MsgPtr ReceiveAckActual.receive[uint8_t socket](TOS_MsgPtr pMsg, void* payload, uint16_t payloadLen) {
        pMsg = signal ReceiveAck.receive[socket](pMsg,payload,payloadLen);
        return pMsg;
  }
  default event TOS_MsgPtr ReceiveAck.receive[uint8_t socket](TOS_MsgPtr pMsg, void* payload, uint16_t payloadLen) {
      return pMsg;
  }
  event result_t InterceptActual.intercept[uint8_t socket](TOS_MsgPtr pMsg, void* payload, uint16_t payloadLen) {
      signal  Intercept.intercept[socket](pMsg, payload, payloadLen); 
      return SUCCESS;
  }
  default event result_t Intercept.intercept[uint8_t socket](TOS_MsgPtr pMsg, void* payload, uint16_t payloadLen) {
      return SUCCESS;
  }
  event result_t SnoopActual.intercept[uint8_t socket](TOS_MsgPtr pMsg, void* payload, uint16_t payloadLen) {
      signal  Snoop.intercept[socket](pMsg, payload, payloadLen); 
      return SUCCESS;
  }
  default event result_t Snoop.intercept[uint8_t socket](TOS_MsgPtr pMsg, void* payload, uint16_t payloadLen) {
      return SUCCESS;
  }

  command result_t Send.send[uint8_t am_type](TOS_MsgPtr pMsg, uint16_t PayloadLen) {
     return call SendActual.send[am_type](pMsg,PayloadLen);
  }
  command void *Send.getBuffer[uint8_t id](TOS_MsgPtr pMsg, uint16_t* length) 
  {
     return call SendActual.getBuffer[id](pMsg, length);
  }
  event result_t SendActual.sendDone[uint8_t socket](TOS_MsgPtr pMsg, result_t success) {
  	signal Send.sendDone[socket](pMsg,success);
    return SUCCESS;
  }
  default event result_t Send.sendDone[uint8_t socket](TOS_MsgPtr pMsg, result_t success) {
    return SUCCESS;
  }

  command result_t MhopSend.send[uint8_t socket](uint16_t dest, uint8_t mode, TOS_MsgPtr pMsg, uint16_t PayloadLen) {
     return call MhopSendActual.send[socket](dest,mode,pMsg,PayloadLen);
  }

  command void *MhopSend.getBuffer[uint8_t id](TOS_MsgPtr pMsg, uint16_t* length) 
  {
     return call MhopSendActual.getBuffer[id](pMsg, length);
  }

  event result_t MhopSendActual.sendDone[uint8_t socket](TOS_MsgPtr pMsg, result_t success) {
  	signal MhopSend.sendDone[socket](pMsg,success);
    return SUCCESS;
  }

  default event result_t MhopSend.sendDone[uint8_t socket](TOS_MsgPtr pMsg, result_t success) {
    return SUCCESS;
  }

 command result_t ElpI.route_discover(uint8_t rui)
 {
     return call ElpIActual.route_discover(rui);
 }
 command result_t ElpI.sleep(uint16_t duration, uint16_t interval, uint8_t retries, uint8_t force_sleep)
 {
     return call ElpIActual.sleep(duration, interval,retries,force_sleep);
 }

  command result_t ElpI.wake()
 {
   return call ElpIActual.wake();
 }

  event result_t ElpIActual.sleep_done(result_t status)
  {
        signal ElpI.sleep_done(status);
	return status;
  }
  default event result_t ElpI.sleep_done(result_t status)
   {
	return status;
   }

  event result_t ElpIActual.route_discover_done(result_t success, uint16_t pID)
  {
        signal ElpI.route_discover_done(success,pID);
	return SUCCESS;
  }

  default event result_t ElpI.route_discover_done(result_t success, uint16_t pID)
   {
	return SUCCESS;
   }
  event result_t ElpIActual.wake_done(result_t status)
  {
    signal ElpI.wake_done(status);
    return status;
  }

  default event result_t ElpI.wake_done(result_t status)
   {
	return status;
   }

  command result_t XOtapLoader.boot(uint8_t id) {
     return call XOtapLoaderActual.boot(id);
  }

  event result_t XOtapLoaderActual.boot_request(uint8_t imgID) {
     return  signal XOtapLoader.boot_request(imgID);
  }

  default event result_t XOtapLoader.boot_request(uint8_t imgID) {
     call XOtapLoader.boot(imgID);
     return SUCCESS;
  }

}
