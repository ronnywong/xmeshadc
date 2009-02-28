/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: XMeshCountToLeds.nc,v 1.3.2.1 2007/04/26 19:35:11 njain Exp $
 */
 
configuration XMeshCountToLeds{
  provides interface StdControl;
}
implementation{
  components
  Main,
  XMeshCountToLedsM,
  LedsC,
  TimerC,
  MULTIHOPROUTER;

  StdControl = XMeshCountToLedsM.StdControl;

  Main.StdControl -> TimerC.StdControl;
  Main.StdControl -> MULTIHOPROUTER.StdControl;
  Main.StdControl -> XMeshCountToLedsM.StdControl;


  XMeshCountToLedsM.Leds -> LedsC.Leds;
  XMeshCountToLedsM.Timer -> TimerC.Timer[unique("Timer")];
  XMeshCountToLedsM.MhopSend -> MULTIHOPROUTER.MhopSend[10];
  XMeshCountToLedsM.health_packet -> MULTIHOPROUTER; 

}
