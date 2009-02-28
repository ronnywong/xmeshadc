/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: Snooze.nc,v 1.1.4.1 2007/04/26 00:27:54 njain Exp $
 */
 
/*
 *
 * Authors:		Joe Polastre
 *
 * IMPORTANT!!!!!!!!!!!!
 * NOTE: The Snooze component will ONLY work on the Mica platform with
 * nodes that have the diode bypass to the battery.  If you do not know what
 * this is, check http://webs.cs.berkeley.edu/tos/hardware/diode_html.html
 * That page also has information for how to install the diode.
 *
 * $Id: Snooze.nc,v 1.1.4.1 2007/04/26 00:27:54 njain Exp $
 */

/**
 * Snooze interface for putting a mote to sleep for a given period of time.
 * @author Joe Polastre
 **/
interface Snooze
{
  /**
   * Triggers the mote to put itself in a low power sleep state for
   * a specified amount of time.
   * 
   * @param length Length of the low power sleep in units of 1/32 of a second.
   *
   * @return SUCCESS if the mote is about to enter the sleep state
   **/
  async command result_t snooze(uint16_t length);

  /**
   * Event fired when a mote wakes up out of the low power sleep state.
   *
   * @return Always return <code>SUCCESS</code>.
   **/
  async event result_t wakeup();
}
