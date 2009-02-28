/*
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: TimerMilli.nc,v 1.1.4.1 2007/04/26 22:15:20 njain Exp $
 */

// @author Cory Sharp <cssharp@eecs.berkeley.edu>

interface TimerMilli
{
  command result_t setPeriodic( int32_t millis );
  command result_t setOneShot( int32_t millis );

  command result_t stop();

  command bool isSet();
  command bool isPeriodic();
  command bool isOneShot();
  command int32_t getPeriod();

  event result_t fired();
}

