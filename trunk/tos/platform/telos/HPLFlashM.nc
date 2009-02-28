/*
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: HPLFlashM.nc,v 1.1.4.1 2007/04/26 22:19:59 njain Exp $
 */

/**
 * HPLFlashM.nc - Driver for AT45DB041 flash on telos. 
 * 
 * This driver is intended to force as little change as possible to
 * the existing PageEEPROM implementation for Micas.
 *
 * @author Jonathan Hui <jwhui@cs.berkeley.edu>
 */

module HPLFlashM {
  provides {
    interface StdControl as FlashControl;
    interface BusArbitration as FlashSelect;
    interface FastSPI as FlashSPI;
  }
  uses {
    interface HPLUSARTControl as USARTControl;
    interface BusArbitration;
  }
}

implementation {

  command result_t FlashControl.init() {
    TOSH_SET_FLASH_CS_PIN();
    TOSH_MAKE_FLASH_CS_OUTPUT();
    call USARTControl.setModeSPI();
    call USARTControl.disableRxIntr();
    call USARTControl.disableTxIntr();
    return SUCCESS;
  }

  command result_t FlashControl.start() {
    TOSH_SET_FLASH_CS_PIN();
    TOSH_MAKE_FLASH_CS_OUTPUT();
    call USARTControl.setModeSPI();
    call USARTControl.disableRxIntr();
    call USARTControl.disableTxIntr();
    return SUCCESS;
  }

  command result_t FlashControl.stop() {
    return SUCCESS;
  }

  async command result_t FlashSelect.getBus() {
    if (call BusArbitration.getBus() == FAIL)
      return FAIL;
    TOSH_CLR_FLASH_CS_PIN();
    return SUCCESS;
  }

  async command result_t FlashSelect.releaseBus() {
    TOSH_SET_FLASH_CS_PIN();
    return call BusArbitration.releaseBus();
  }

  event result_t BusArbitration.busFree() {
    return signal FlashSelect.busFree();
  }

  async command uint8_t FlashSPI.txByte(uint8_t spiOut) {
    uint8_t spiIn = 0;
    atomic {
      call USARTControl.isTxIntrPending();
      call USARTControl.rx();
      call USARTControl.tx(spiOut);
      TOSH_uwait(20);
      spiIn = call USARTControl.rx();
    }
    return spiIn;
  }

  default event result_t FlashSelect.busFree() {
    return SUCCESS;
  }

}
