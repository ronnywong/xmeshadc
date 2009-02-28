/*
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: TimerJiffy.nc,v 1.1.4.1 2007/04/26 22:14:53 njain Exp $
 */

// @author Cory Sharp <cssharp@eecs.berkeley.edu>

interface TimerJiffy
{
  command result_t setPeriodic( int32_t jiffy );
  command result_t setOneShot( int32_t jiffy );

  command result_t stop();

  command bool isSet();
  command bool isPeriodic();
  command bool isOneShot();
  command int32_t getPeriod();

  event result_t fired();
}

