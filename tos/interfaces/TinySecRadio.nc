/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: TinySecRadio.nc,v 1.1.4.1 2007/04/25 23:33:12 njain Exp $
 */

interface TinySecRadio
{

  /**
   * Requests the next byte to be sent from TinySec.
   *
   * Pre-condition:
   * TinySec has been initialized and TinySec.sendInit
   * and TinySec.send have been called.
   *
   * Post-condition:
   * none
   *
   * @return The next byte to be sent.
   */  
  async event uint8_t getTransmitByte();

  /**
   * Signals the next received byte to TinySec.
   *
   * Pre-condition:
   * TinySec has been initialized and TinySec.receiveInit
   * has been called and a TinySec.receiveInitDone event
   * has been received.
   *
   * Post-condition:
   * none
   *
   * @return Whether the signal handler was successful.
   */
  async event result_t byteReceived(uint8_t byte);
}
