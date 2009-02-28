/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: SlavePin.nc,v 1.1.4.1 2007/04/26 00:27:26 njain Exp $
 */
 
/*
 *
 * Authors:		Jason Hill, David Gay, Philip Levis
 * Date last modified:  6/25/02
 *
 */

/**
 * Semaphore-like interface for controlling a hardware pin (shared between
 * the radio and flash)
 * @author Jason Hill
 * @author David Gay
 * @author Philip Levis
 */
interface SlavePin
{
  /**
   * Set the pin low
   * @return SUCCESS
   */
  async command result_t low();

  /**
   * Request the pin be set high. If the number of calls to high is greater
   * or equal to the number of calls to low (since initialisation), then
   *   the pin is set high
   * @param needEvent TRUE if a notifyHigh event is desired if the pin
   *   cannot go high immediately.
   * @return SUCCESS
   */
  async command result_t high(bool needEvent);

  /**
   * Signaled when pin is set high (see high())
   */
  event result_t notifyHigh();
}
