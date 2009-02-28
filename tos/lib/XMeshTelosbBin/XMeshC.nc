/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: XMeshC.nc,v 1.1.4.1 2007/04/25 23:45:05 njain Exp $
 */

component XMeshC {
  provides {
    interface StdControl;
    interface MhopSend[uint8_t id];
    interface Send[uint8_t id];
    interface Receive[uint8_t id];
    interface Receive as ReceiveAck[uint8_t id];
    interface Intercept[uint8_t id];
    interface Intercept as Snoop[uint8_t id];
    interface ElpI;
    interface ElpControlI;
    interface RouteControl;
    command void health_packet(bool enable, uint16_t interval);
  }

  uses {
    interface StdControl as QueueStdControl;
    interface StdControl as GCStdControl;
    interface CommControl as GCCommControl;
    interface StdControl as BattControl;
    interface SendMsg as SendMsg[uint8_t id];
    interface ReceiveMsg[uint8_t id];
    interface ReceiveMsg as ReceiveDownstreamMsg[uint8_t id];
    interface ReceiveMsg as ReceiveMsgWithAck[uint8_t id];
    interface ReceiveMsg as ReceiveDownstreamMsgWithAck[uint8_t id];
    interface Timer as EngineTimer;
    interface Timer as EwmaTimer;
    interface Timer as ElpTimer;
    interface Timer as ElpTimeOut;
    interface Timer as HealthTimer;
    interface Timer as Window;
    interface Random;
    interface RadioPower;
    interface ADC as Batt;
    interface BoundaryI;
  }
}
