/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: XJPM.nc,v 1.2.4.1 2007/04/25 23:40:49 njain Exp $
 */


includes XJoin;
includes MultiHop;

module XJPM {
  provides {
    interface StdControl;
    interface XJoin;
  }
  uses {
    interface Timer;
    interface Leds;
    interface MhopSend as SendMesh;
    interface Receive as ReceiveMesh;
    interface SendMsg as SendLocal;
    interface ReceiveMsg as ReceiveLocal;
    interface Random as Random;
    interface StdControl as MeshStdControl;
    interface RouteControl as MeshRouteControl;

	interface HardwareId;
	interface StdControl as DS2401;

  }
}

implementation {


	/***********************************************************************
	* StdControl Interface
	***********************************************************************/

  command result_t StdControl.init() {
    return SUCCESS;
  }

  command result_t StdControl.start() {
	return SUCCESS;
  }

  command result_t StdControl.stop() {
    return SUCCESS;
  }

  /***********************************************************************
  * Timer Interface
  ***********************************************************************/
  event result_t Timer.fired() {
    return SUCCESS;
  }

   /***********************************************************************
   * Send Mesh Interface
   ***********************************************************************/

  event result_t SendMesh.sendDone(TOS_MsgPtr pMsg, result_t success) {
    return SUCCESS;
  }

  /***********************************************************************
  * Receive Mesh Interface
  ***********************************************************************/




  event TOS_MsgPtr ReceiveMesh.receive(TOS_MsgPtr msg, void* payload, uint16_t payloadLen){
    return msg;
  }


  /***********************************************************************
   * Send Local Interface
   ***********************************************************************/

  event result_t SendLocal.sendDone(TOS_MsgPtr pMsg, result_t success) {
    return SUCCESS;
  }

  /***********************************************************************
  * Receive Local Interface
  ***********************************************************************/

  event TOS_MsgPtr ReceiveLocal.receive(TOS_MsgPtr packet) {
   return packet;
  }

 event result_t HardwareId.readDone(uint8_t *id, result_t success){
    return SUCCESS;
 }

 default event void XJoin.joinDone(result_t success){
	//do nothing
  }
}

