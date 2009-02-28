/*
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: MSP430Interrupt.nc,v 1.1.4.1 2007/04/26 22:10:51 njain Exp $
 */

//@author Joe Polastre

interface MSP430Interrupt
{
  /** 
   * Enables MSP430 hardware interrupt on a particular port
   */
  async command void enable();

  /** 
   * Disables MSP430 hardware interrupt on a particular port
   */
  async command void disable();

  /** 
   * Clears the MSP430 Interrupt Pending Flag for a particular port
   */
  async command void clear();

  /** 
   * Gets the current value of the input voltage of a port
   *
   * @return TRUE if the pin is set high, FALSE if it is set low
   */
  async command bool getValue();

  /** 
   * Sets whether the edge should be high to low or low to high.
   * @param TRUE if the interrupt should be triggered on a low to high
   *        edge transition, false for interrupts on a high to low transition
   */
  async command void edge(bool low_to_high);

  /**
   * Signalled when an interrupt occurs on a port
   */
  async event void fired();
}

