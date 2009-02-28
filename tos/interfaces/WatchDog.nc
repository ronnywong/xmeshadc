/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: WatchDog.nc,v 1.1.4.1 2007/04/25 23:33:53 njain Exp $
 */

/*
 * Authors:		Su Ping  <sping@intel-research.net>
 *
 */



/**
 * The Watch dog interface. 
 * When enabled, the watch dog will reset a mote at a specified time
 * @author Su Ping <sping@intel-research.net>
 **/
includes TosTime;

interface WatchDog {

  /** enable watch dog timer and set it to reset mote after t micro seconds */
  command result_t set(tos_time_t t );

  /** disable watch dog timer and cancel the reset */
  command result_t cancel();
}

