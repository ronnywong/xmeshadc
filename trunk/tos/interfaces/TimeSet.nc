/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: TimeSet.nc,v 1.1.4.1 2007/04/25 23:31:32 njain Exp $
 */

/*
 * Authors:		Su Ping  <sping@intel-research.net>
 *
 */

/**
 * The TimeSet interface. 
 * @author Su Ping <sping@intel-research.net>
 */

includes TosTime;
interface TimeSet {

  /**
   *  Set the 64 bits logical time to a specified value 
   *  @param t Time in the unit of binary milliseconds
   *           type is tos_time_t
   *  @return none
   */
  command void set(tos_time_t t);


  /**
   *  Adjust logical time by n  binary milliseconds.
   *
   *  @param us unsigned 16 bit interger 
   *            positive number advances the logical time 
   *            negtive argument regress the time 
   *            This operation will not take effect immidiately
   *            The adjustment is done duing next clock.fire event
   *            handling.
   *  @return none
   */
  command void adjust(int16_t n);

  /**
   *  Adjust logical time by x milliseconds.
   *
   *  @param x  32 bit interger
   *            positive number advances the logical time
   *            negtive argument regress the time
   *  @return none
   */
  command void adjustNow(int32_t x);
   
}











