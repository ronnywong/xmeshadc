/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: FastSPI.nc,v 1.1.4.1 2007/04/25 23:22:39 njain Exp $
 */
 
/*
 * Authors:		Jason Hill, David Gay, Philip Levis
 * Date last modified:  6/12/03
 *
 *
 */

/**
 * An SPI byte-level interface. 
 * Every bit/byte transmitted produces a result bit/byte.
 * Every call to the <code>txByte()</bode> command 
 * returns the result byte.
 *
 * Note: ByteSPI is a split-phase version of this interface. FastSPI
 * should be used when a single byte transaction on the SPI is 
 * sufficiently fast.
 * @author Jason Hill
 * @author David Gay
 * @author Philip Levis
 */
interface FastSPI {
  /**
   * Transmits a byte to the SPI bus
   *
   * @param data the byte to be transmitted
   *
   * @return the received SPI byte
   */
  async command uint8_t txByte(uint8_t data);
}
