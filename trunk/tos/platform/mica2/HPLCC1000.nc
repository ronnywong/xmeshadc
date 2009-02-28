/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: HPLCC1000.nc,v 1.1.4.1 2007/04/26 00:14:18 njain Exp $
 */
 
/*
 * Authors:		Jason Hill, David Gay, Philip Levis
 * Date last modified:  6/25/02
 *
 *
 */

/**
 * @author Jason Hill
 * @author David Gay
 * @author Philip Levis
 */


interface HPLCC1000 {
  /**
   * Initialize CC1K pins
   *
   * @return SUCCESS if successful
   */
  command result_t init();

  /**
   * Transmit 8-bit data for 7-bit register address
   *
   * @return SUCCESS if successful
   */
  async command result_t write(uint8_t addr, uint8_t data);

  /**
   * Read 8-bit data for 7-bit register address
   *
   * @return data
   */
  async command uint8_t read(uint8_t addr);

  /**
   * Read a BINARY value from the CHP_OUT pin
   *
   * @return TRUE or FALSE
   */
  async command bool GetLOCK();
}
