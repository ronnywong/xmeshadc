/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: Leds.nc,v 1.1.4.1 2007/04/25 23:25:00 njain Exp $
 */
 
/*
 * Authors:		Jason Hill, David Gay, Philip Levis
 * Date last modified:  6/1/03
 *
 *
 */

/**
 * Abstraction of the LEDs.
 *
 * @author Jason Hill
 * @author David Gay
 * @author Philip Levis
 */

interface Leds {

  /**
   * Initialize the LEDs; among other things, initialization turns
   * them all off.
   *
   * @return SUCCESS always.
   *
   */
  
  async command result_t init();

  /**
   * Turn the red LED on.
   *
   * @return SUCCESS always.
   *
   */
  async command result_t redOn();

  /**
   * Turn the red LED off.
   *
   * @return SUCCESS always.
   *
   */
  async command result_t redOff();

  /**
   * Toggle the red LED. If it was on, turn it off. If it was off,
   * turn it on.
   *
   * @return SUCCESS always.
   *
   */
  async command result_t redToggle();

  /**
   * Turn the green LED on.
   *
   * @return SUCCESS always.
   *
   */
  async command result_t greenOn();

  /**
   * Turn the green LED off.
   *
   * @return SUCCESS always.
   *
   */
  async command result_t greenOff();

  /**
   * Toggle the green LED. If it was on, turn it off. If it was off,
   * turn it on.
   *
   * @return SUCCESS always.
   *
   */
  async command result_t greenToggle();

  /**
   * Turn the yellow LED on.
   *
   * @return SUCCESS always.
   *
   */
  async command result_t yellowOn();

  /**
   * Turn the yellow LED off.
   *
   * @return SUCCESS always.
   *
   */
  async command result_t yellowOff();

  /**
   * Toggle the yellow LED. If it was on, turn it off. If it was off,
   * turn it on.
   *
   * @return SUCCESS always.
   *
   */
  async command result_t yellowToggle();
  
  /**
   * Get current Leds information
   *
   * @return A uint8_t typed value representing Leds status
   *
   */
   async command uint8_t get();

  /**
   * Set Leds to a specified value
   *
   * @param value ranging from 0 to 7 inclusive
   *
   * @return SUCCESS Always
   *
   */
   async command result_t set(uint8_t value);
}
