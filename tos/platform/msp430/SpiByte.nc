/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: SpiByte.nc,v 1.1.4.1 2007/04/26 22:14:25 njain Exp $
 */

interface SpiByte
{
  /**
   * Initialize the SPI bus
   */
  command result_t init();

  /**
   * Enable the SPI bus functionality
   */
  async command result_t enable();

  /**
   * Disable the SPI bus functionality
   */
  async command result_t disable();

  /**
   * Write a byte to the SPI bus
   * @param data value written to the MOSI pin
   * @return value read on the MISO pin
   */
  async command uint8_t write(uint8_t data);
}
