/*
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: RadioCoordinator.nc,v 1.1.4.1 2007/04/25 23:27:55 njain Exp $
 */

interface RadioCoordinator
{
  /**
   * This event indicates that the start symbol has been detected 
   * and its offset
   */
  async event void startSymbol(uint8_t bitsPerBlock, uint8_t offset, TOS_MsgPtr msgBuff);

  /**
   * This event indicates that another byte of the current packet has been rxd
   */
  async event void byte(TOS_MsgPtr msg, uint8_t byteCount);

  /**
   * Signals the start of processing of a new block by the radio. This
   * event is signaled regardless of the state of the radio.  This
   * function is currently used to aid radio-based time synchronization.
   */
  async event void blockTimer();
}

