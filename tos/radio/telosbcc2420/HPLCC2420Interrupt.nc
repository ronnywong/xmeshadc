/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: HPLCC2420Interrupt.nc,v 1.1.4.1 2007/04/27 05:05:01 njain Exp $
 */

/*
 * Authors:		Joe Polastre
 */

/**
 * @author Joe Polastre
 */


interface HPLCC2420Interrupt {

  /** 
   * Enable an edge based interrupt
   *
   * @param low_to_high TRUE if the edge interrupt should occur on
   *        a low to high transition, FALSE for high to low.
   *
   * @return SUCCESS if the interrupt has been enabled
   */
  async command result_t startWait(bool low_to_high);

  /**
   * Fired when an edge interrupt occurs.
   *
   * @return SUCCESS to keep the interrupt enabled (equivalent to
   *         calling startWait again), FAIL to disable the interrupt
   */
  async event result_t fired();


  /**
   * Diables an edge interrupt or capture interrupt
   * 
   * @return SUCCESS if the interrupt has been disabled
   */ 
  async command result_t disable();
}
