/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: Time.nc,v 1.1.4.1 2007/04/25 23:31:23 njain Exp $
 */

/*
 * Authors:		Su Ping  <sping@intel-research.net>
 *
 */

/**
 * The Time interface. 
 * @author Su Ping <sping@intel-research.net>
 **/
includes TosTime;
interface Time {
  /**
   * get current time. Return it in tos_time_t structure 
   **/
  async command tos_time_t get();

  /** get the high 32 bits of current time */
  async command uint32_t getHigh32();

  /** get the lower 32 bits of current time */
  async command uint32_t getLow32();

  /** get clock phase offset since last clock tick
    * in unit of micro-seconds.  
   **/
  async command uint16_t getUs();

}










