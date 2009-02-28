/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: TimerJiffyAsyncC.nc,v 1.1.4.1 2007/04/26 22:22:38 njain Exp $
 */
 
// @author Cory Sharp <cssharp@eecs.berkeley.edu>

configuration TimerJiffyAsyncC
{
  provides interface StdControl;
  provides interface TimerJiffyAsync;
}
implementation
{
  components TimerJiffyAsyncM
	   , MSP430TimerC
	   ;

  StdControl = TimerJiffyAsyncM;
  TimerJiffyAsync = TimerJiffyAsyncM;

  TimerJiffyAsyncM.AlarmControl -> MSP430TimerC.ControlB4;
  TimerJiffyAsyncM.AlarmCompare -> MSP430TimerC.CompareB4;
}

