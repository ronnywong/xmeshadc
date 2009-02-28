/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: HPLCC2420Capture.nc,v 1.1.4.1 2007/04/27 05:04:44 njain Exp $
 */

/*
 * Authors:		Joe Polastre
 */

/**
 * @author Joe Polastre
 */


interface HPLCC2420Capture {

  /** 
   * Enable an edge based timer capture
   *
   * @param low_to_high TRUE if the edge capture should occur on
   *        a low to high transition, FALSE for high to low.
   *
   * @return SUCCESS if the timer capture has been enabled
   */
  async command result_t enableCapture(bool low_to_high);

  /**
   * Fired when an edge interrupt occurs.
   *
   * @param val the raw value of the timer captured
   *
   * @return SUCCESS to keep the interrupt enabled, FAIL to disable
   *         the interrupt
   */
  async event result_t captured(uint16_t val);

  /**
   * Diables a capture interrupt
   * 
   * @return SUCCESS if the interrupt has been disabled
   */ 
  async command result_t disable();
}
