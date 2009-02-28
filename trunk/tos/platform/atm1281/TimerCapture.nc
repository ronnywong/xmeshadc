/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: TimerCapture.nc,v 1.2.2.2 2007/04/26 00:07:49 njain Exp $
 */

//@author Joe Polastre


interface TimerCapture
{
  /**
   * Reads the value of the last capture event in TxCCRx
   */
  async command uint16_t getEvent();

  /**
   * Set the edge that the capture should occur
   *
   * @param cm Capture Mode for edge capture.
      FALSE high-to-low edge
	  TRUE  low-to-high edge
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
   * @param synchronous TRUE to synchronize the timer capture with the
   *        next timer clock instead of occurring asynchronously.
   */
  async command void setSynchronous(bool synchronous);

  async command void enableEvents();
  async command void disableEvents();
  async command void clearPendingInterrupt();
  async command bool areEventsEnabled(); 

  /**
   * Signalled when an event is captured.
   *
   * @param time The time of the capture event
   */
  async event void captured(uint16_t time);

}

