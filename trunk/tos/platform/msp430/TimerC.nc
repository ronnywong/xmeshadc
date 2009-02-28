/*
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: TimerC.nc,v 1.1.4.1 2007/04/26 22:14:43 njain Exp $
 */


// @author Cory Sharp <cssharp@eecs.berkeley.edu>

configuration TimerC
{
  provides interface StdControl;
  provides interface LocalTime;
  provides interface Timer[uint8_t timer];
  provides interface TimerMilli[uint8_t timer];
  provides interface TimerJiffy[uint8_t timer];
}
implementation
{
  components TimerM
	   , MSP430TimerC
	   ;

  StdControl = TimerM;
  LocalTime = TimerM;
  Timer = TimerM;
  TimerMilli = TimerM;
  TimerJiffy = TimerM;

  TimerM.AlarmTimer -> MSP430TimerC.TimerB;
  TimerM.AlarmControl -> MSP430TimerC.ControlB3;
  TimerM.AlarmCompare -> MSP430TimerC.CompareB3;
}

