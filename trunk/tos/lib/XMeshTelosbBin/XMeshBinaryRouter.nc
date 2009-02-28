/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: XMeshBinaryRouter.nc,v 1.1.4.1 2007/04/25 23:44:56 njain Exp $
 */

#include "AM.h"
#include "MultiHop.h"
#include "Messages.h"
configuration XMeshBinaryRouter {
  provides 
  {
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
  uses 
  {
    interface ReceiveMsg[uint8_t id];
    interface ReceiveMsg as ReceiveDownstreamMsg[uint8_t id];
    interface ReceiveMsg as ReceiveMsgWithAck[uint8_t id];
    interface ReceiveMsg as ReceiveDownstreamMsgWithAck[uint8_t id];
  }
}

implementation 
{
  components XMeshC, 
             ShimLayerM,
             BoundaryM,
	     GenericCommPromiscuous as Comm, 
             QueuedSend, 
	     RandomLFSR,
             RadioCRCPacket,
             Voltage,
#if defined(PLATFORM_MICA2) || defined(PLATFORM_MICA2DOT)
             CC1000RadioC,
#elif defined(PLATFORM_MICAZ)
             CC2420RadioC,
#elif defined(PLATFORM_TELOSB)
             CC2420RadioC,
#endif
	     TimerC;

  StdControl = BoundaryM;
  StdControl = XMeshC;
  MhopSend = ShimLayerM;
  Send = ShimLayerM;
  Receive = ShimLayerM.Receive;
  ReceiveAck = ShimLayerM.ReceiveAck;
  Intercept = ShimLayerM.Intercept;
  Snoop = ShimLayerM.Snoop;
  ElpI = ShimLayerM;

  ElpControlI = XMeshC;
  RouteControl = XMeshC;
  health_packet = XMeshC;
  ReceiveMsg = XMeshC.ReceiveMsg;
  ReceiveMsgWithAck = XMeshC.ReceiveMsgWithAck;
  ReceiveDownstreamMsg = XMeshC.ReceiveDownstreamMsg;
  ReceiveDownstreamMsgWithAck = XMeshC.ReceiveDownstreamMsgWithAck;

  ShimLayerM.ReceiveActual->XMeshC.Receive;
  ShimLayerM.ReceiveAckActual->XMeshC.ReceiveAck;
  ShimLayerM.InterceptActual->XMeshC.Intercept;
  ShimLayerM.SnoopActual->XMeshC.Snoop;

  ShimLayerM.SendActual->XMeshC.Send;
  ShimLayerM.MhopSendActual->XMeshC.MhopSend;
  ShimLayerM.ElpIActual->XMeshC.ElpI;

  XMeshC.QueueStdControl -> QueuedSend.StdControl;
  XMeshC.GCStdControl -> Comm.Control;
  XMeshC.GCCommControl -> Comm.CommControl;
  XMeshC.SendMsg -> QueuedSend.SendMsg;

  XMeshC.Random -> RandomLFSR;

  XMeshC.BattControl -> Voltage;
  XMeshC.Batt -> Voltage;

  XMeshC.EngineTimer -> TimerC.Timer[unique("Timer")];
  XMeshC.EwmaTimer -> TimerC.Timer[unique("Timer")];  
  XMeshC.ElpTimer -> TimerC.Timer[unique("Timer")];  
  XMeshC.ElpTimeOut -> TimerC.Timer[unique("Timer")];  
  XMeshC.Window -> TimerC.Timer[unique("Timer")];  
  XMeshC.HealthTimer -> TimerC.Timer[unique("Timer")];  

  XMeshC.ReceiveMsg[AM_MULTIHOPMSG] -> Comm.ReceiveMsg[AM_MULTIHOPMSG];
  XMeshC.ReceiveMsg[AM_ONE_HOP] -> Comm.ReceiveMsg[AM_ONE_HOP];
  XMeshC.ReceiveMsgWithAck[AM_HEALTH] -> Comm.ReceiveMsg[AM_HEALTH];
  XMeshC.ReceiveDownstreamMsg[AM_DOWNSTREAM_ACK] -> Comm.ReceiveMsg[AM_DOWNSTREAM_ACK];
  XMeshC.ReceiveDownstreamMsg[AM_PATH_LIGHT_DOWN] -> Comm.ReceiveMsg[AM_PATH_LIGHT_DOWN];
  XMeshC.ReceiveMsg[AM_UPSTREAM_ACK] -> Comm.ReceiveMsg[AM_UPSTREAM_ACK];
  XMeshC.ReceiveMsg[AM_PATH_LIGHT_UP] -> Comm.ReceiveMsg[AM_PATH_LIGHT_UP];
  XMeshC.ReceiveMsgWithAck[AM_DATAACK2BASE] -> Comm.ReceiveMsg[AM_DATAACK2BASE];
  XMeshC.ReceiveMsg[AM_DATA2BASE] -> Comm.ReceiveMsg[AM_DATA2BASE];
  XMeshC.ReceiveDownstreamMsgWithAck[AM_DATAACK2NODE] -> Comm.ReceiveMsg[AM_DATAACK2NODE];
  XMeshC.ReceiveDownstreamMsg[AM_DATA2NODE] -> Comm.ReceiveMsg[AM_DATA2NODE];
// wiring for XOtap message
  XMeshC.ReceiveDownstreamMsg[AM_MGMT] -> Comm.ReceiveMsg[AM_MGMT];
  XMeshC.ReceiveDownstreamMsg[AM_BULKXFER] -> Comm.ReceiveMsg[AM_BULKXFER];
  XMeshC.ReceiveMsg[AM_MGMTRESP] -> Comm.ReceiveMsg[AM_MGMTRESP];

  XMeshC.RadioPower -> RadioCRCPacket;

  XMeshC.BoundaryI -> BoundaryM;

#if defined(PLATFORM_MICA2) || defined(PLATFORM_MICA2DOT)
  BoundaryM.CC1000Control ->CC1000RadioC;
#elif defined(PLATFORM_MICAZ)
  BoundaryM.CC2420Control ->CC2420RadioC;
#elif defined(PLATFORM_TELOSB)
  BoundaryM.CC2420Control ->CC2420RadioC;
#endif
}
