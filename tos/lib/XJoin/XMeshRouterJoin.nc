/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: XMeshRouterJoin.nc,v 1.1.4.1 2007/04/27 04:53:13 njain Exp $
 */
 
includes XJoin;
includes Messages;
includes MultiHop;

configuration XMeshRouterJoin {
  provides {
    interface StdControl;
  	interface XJoin;
  }
}
implementation {
  components
    TimerC,
    XJPM,
    GenericCommPromiscuous as Comm,
    XMeshRouter,
    LedsC,
    SerialId,
    RandomLFSR;

  XJoin = XJPM.XJoin;

  StdControl = XJPM.StdControl;
  StdControl = TimerC;
  StdControl = Comm;
  StdControl = XJPM;

  XJPM.Leds -> LedsC;

  //this is xmesh routing wiring
  XJPM.SendMesh -> XMeshRouter.MhopSend[AM_XJP_MESH];
  XJPM.ReceiveMesh -> XMeshRouter.Receive[AM_XJP_MESH];

  //this xjp wiring to the lowest level radio packet
  //so we can control group id etc.
  XJPM.SendLocal -> Comm.SendMsg[AM_XJP_LOCAL];
  XJPM.ReceiveLocal -> Comm.ReceiveMsg[AM_XJP_LOCAL];

  XJPM.Random -> RandomLFSR;

  XJPM.Timer -> TimerC.Timer[unique("Timer")];

  //Join should control when the mesh starts
  XJPM.MeshStdControl -> XMeshRouter.StdControl;
  XJPM.MeshRouteControl -> XMeshRouter.RouteControl;

  //get the unique Serial Id
  //problem right now is that XCommand is also
  //attached to this so our read will trigger
  //Recover params and their call will trigger ours
  //but in both cases we just update a variable to be
  //the uniqueid so we should both be alright since it never changes
  XJPM.DS2401 -> SerialId;
  XJPM.HardwareId -> SerialId;

}




