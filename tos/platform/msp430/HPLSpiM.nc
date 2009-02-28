/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * Copyright (c) 2004, Technische Universitaet Berlin
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: HPLSpiM.nc,v 1.1.4.1 2007/04/26 22:05:48 njain Exp $
 */

module HPLSpiM {
  provides {
    interface SpiByte;
  }
  uses {
    interface HPLUSARTControl as USARTControl;
  }
}
implementation {

  /**
   * Initialize the SPI bus
   */
  command result_t SpiByte.init() {
    call USARTControl.setModeSPI();
    call USARTControl.disableRxIntr();
    call USARTControl.disableTxIntr();
    return SUCCESS;
  }

  /**
   * Enable the SPI bus functionality
   */
  async command result_t SpiByte.enable() {
    call USARTControl.setModeSPI();
    call USARTControl.disableRxIntr();
    call USARTControl.disableTxIntr();
    return SUCCESS;
  }

  /**
   * Disable the SPI bus functionality
   */
  async command result_t SpiByte.disable() {
    return SUCCESS;
  }

  /**
   * Write a byte to the SPI bus
   * @param data value written to the MOSI pin
   * @return value read on the MISO pin
   */
  async command uint8_t SpiByte.write(uint8_t data) {
    uint8_t retdata;
    atomic {
      call USARTControl.tx(data);
      while(!(call USARTControl.isRxIntrPending())) ;
      retdata = call USARTControl.rx();
    }
    return retdata;
  }

}
