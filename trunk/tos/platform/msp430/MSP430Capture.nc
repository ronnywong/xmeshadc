/*
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: MSP430Capture.nc,v 1.1.4.1 2007/04/26 22:08:41 njain Exp $
 */

//@author Joe Polastre

includes MSP430Timer;

interface MSP430Capture
{
  /**
   * Reads the value of the last capture event in TxCCRx
   */
  async command uint16_t getEvent();

  /**
   * Set the edge that the capture should occur
   *
   * @param cm Capture Mode for edge capture.
   * enums exist for:
   *   MSP430TIMER_CM_NONE is no capture.
   *   MSP430TIMER_CM_RISING is rising edge capture.
   *   MSP430TIMER_CM_FALLING is a falling edge capture.
   *   MSP430TIMER_CM_BOTH captures on both rising and falling edges.
   */
  async command void setEdge(uint8_t cm);

  /**
   * Determine if a capture overflow is pending.
   *
   * @return TRUE if the capture register has overflowed
   */
  async command bool isOverflowPending();

  /**
   * Clear the capture overflow flag for when multiple captures occur
   */
  async command void clearOverflow();

  /**
   * Set whether the capture should occur synchronously or asynchronously.
   * TinyOS default is synchronous captures.
   * WARNING: if the capture signal is asynchronous to the timer clock,
   *          it could case a race condition (see Timer documentation
   *          in MSP430F1xx user guide)
   * @param synchronous TRUE to synchronize the timer capture with the
   *        next timer clock instead of occurring asynchronously.
   */
  async command void setSynchronous(bool synchronous);

  /**
   * Signalled when an event is captured.
   *
   * @param time The time of the capture event
   */
  async event void captured(uint16_t time);

}

