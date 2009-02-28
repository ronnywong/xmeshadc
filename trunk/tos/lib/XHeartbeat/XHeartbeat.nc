/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: XHeartbeat.nc,v 1.2.4.2 2007/04/25 23:40:15 njain Exp $
 */

includes Messages;
configuration XHeartbeat{
	provides interface StdControl;
}
implementation {
  components Main,
             XHeartbeatM,
             LedsC,
             QueuedSend,
             TimerC;

	StdControl = XHeartbeatM.StdControl;

  Main.StdControl -> XHeartbeatM.StdControl;
  Main.StdControl -> TimerC;
  XHeartbeatM.Timer -> TimerC.Timer[unique("Timer")];
  XHeartbeatM.Leds   -> LedsC;
  XHeartbeatM.SendMsg -> QueuedSend.SendMsg[AM_HEARTBEAT];
}
