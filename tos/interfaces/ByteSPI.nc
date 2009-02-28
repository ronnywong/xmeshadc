/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: ByteSPI.nc,v 1.1.4.1 2007/04/25 23:19:52 njain Exp $
 */

/*
 * Authors:		Jason Hill, David Gay, Philip Levis
 * Date last modified:  6/25/02
 *
 *
 */

/**
 * An SPI byte-level interface. 
 * Every bit/byte transmitted produces a result bit/byte.
 * Every call to the <code>txByte()</bode> command 
 * results in a corresponding rxByte()
 * event which contains the byte read while transmitting.
 *
 * Note: FastSPI is a non-split-phase version of this interface. ByteSPI
 * should be used when a single byte transaction on the SPI is 
 * slow.
 * @author Jason Hill
 * @author David Gay
 * @author Philip Levis
 */
interface ByteSPI {
  /**
   * Transmits a byte to the SPI bus
   *
   * @param data the byte to be transmitted
   *
   * @return SUCCESS if successful
   */
  async command result_t txByte(uint8_t data);

  /**
   * Notification of a byte received on the SPI bus.
   * Every byte transmitted results in a byte received.
   *
   * @param data the byte received
   *
   * @return SUCCESS if successful
   */
  async event result_t rxByte(uint8_t data);
}
