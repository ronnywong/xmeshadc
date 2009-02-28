/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: WDT.nc,v 1.1.4.1 2007/04/25 23:33:45 njain Exp $
 */


interface WDT {

  /**
   * Start the watchdog timer. 
   *  @param interval The timer interval in <b>binary milliseconds</b> (1/1024
   *  second). Note that the 
   *    timer cannot support an arbitrary range of intervals.
   *    (Unfortunately this interface does not specify the valid range
   *    of timer intervals, which are specific to a platform.)
   *  @return Returns SUCCESS if the timer could be started with the 
   *    given type and interval. Returns FAIL if the type is not
   *    one of TIMER_REPEAT or TIMER_ONE_SHOT, if the timer rate is
   *    too high, or if there are too many timers currently active.
   */

  command result_t start(int32_t interval);

  /** Reset the watchdog timer. */
  command void reset();
}

