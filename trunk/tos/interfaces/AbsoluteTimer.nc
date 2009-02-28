/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: AbsoluteTimer.nc,v 1.1.4.1 2007/04/25 23:17:55 njain Exp $
 */

/*
 * Authors:		Su Ping  <sping@intel-research.net>
 *
 */



/**
 * The AbsoluteTimer interface. 
 * @author Su Ping <sping@intel-research.net>
 **/
includes TosTime;
interface AbsoluteTimer {
  /**
   *  start a AbsoluteTimer and set its expire time to t 
   *  If the AbsoluteTimer is started of, return SUCCESS
   *  Else, return FAIL
   **/
  command result_t set(tos_time_t t );

  /**
   *  start a AbsoluteTimer that fires when (time) - <phase> 
   *  is a multiple of <period>
   *  If the AbsoluteTimer is started of, return SUCCESS
   *  Else, return FAIL
   **/
  command result_t setRepeat(uint32_t period, uint16_t phase);

  /**
   *  Cancel an absolute timer. 
   *  If the timer does not exist, 
   *  return FALSE.
   **/
  command result_t cancel();

  /**
   *  The AbsoluteTimer exipired event that a timer user needs to handle 
   **/
  event   result_t fired();

  /**
   *  This is fired by Repeat Timers, and gives the user the exact time
   *  at which the timer was fired.
   **/
  event   result_t firedRepeat(tos_time_t t);
}

