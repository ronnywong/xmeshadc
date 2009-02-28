/*
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: HPLSTM25PM.nc,v 1.1.4.1 2007/04/26 22:25:08 njain Exp $
 */

/*
 * @author: Jonathan Hui <jwhui@cs.berkeley.edu>
 */

module HPLSTM25PM {
  provides {
    interface StdControl;
    interface HPLSTM25P;
  }
  uses {
    interface BusArbitration;
    interface HPLUSARTControl as USARTControl;    
  }
}

implementation {

  command result_t StdControl.init() { 
    call USARTControl.setModeSPI();
    call USARTControl.disableRxIntr();
    call USARTControl.disableTxIntr();
    return SUCCESS; 
  }
  
  command result_t StdControl.start() { 
    call USARTControl.setModeSPI();
    call USARTControl.disableRxIntr();
    call USARTControl.disableTxIntr();
    return SUCCESS; 
  }

  command result_t StdControl.stop() { 
    call USARTControl.disableSPI();
    return SUCCESS; 
  }

  async command result_t HPLSTM25P.getBus() {
    return call BusArbitration.getBus();
  }
  
  async command result_t HPLSTM25P.releaseBus() {
    return call BusArbitration.releaseBus();
  }

  async command result_t HPLSTM25P.beginCmd(uint8_t cmd) {
    TOSH_CLR_FLASH_CS_PIN();
    call HPLSTM25P.unhold();
    // send command byte
    call USARTControl.tx(cmd);
    while(!(call USARTControl.isTxIntrPending()));
    return SUCCESS;
  }

  async command result_t HPLSTM25P.endCmd() {
    while(!(call USARTControl.isTxEmpty()));
    TOSH_SET_FLASH_CS_PIN();
    return SUCCESS;
  }

  async command result_t HPLSTM25P.hold() {
    TOSH_CLR_FLASH_HOLD_PIN();
    return SUCCESS;
  }

  async command result_t HPLSTM25P.unhold() {
    TOSH_SET_FLASH_HOLD_PIN();
    return SUCCESS;
  }

  async command result_t HPLSTM25P.txBuf(uint8_t* buf, stm25p_addr_t len) {

    stm25p_addr_t i;

    for ( i = 0; i < len; i++ ) {
      call USARTControl.tx(*buf++);
      while(!(call USARTControl.isTxIntrPending()));
    }

    return SUCCESS;

  }

  async command result_t HPLSTM25P.rxBuf(uint8_t* buf, stm25p_addr_t len) {

    stm25p_addr_t i;

    call USARTControl.rx(); // clear receive interrupt
    for ( i = 0; i < len; i++ ) {
      call USARTControl.tx(0);
      while(!(call USARTControl.isRxIntrPending()));
      *buf++ = call USARTControl.rx();
    }

    return SUCCESS;
    
  }

  async command result_t HPLSTM25P.computeCrc(uint16_t* crcResult, stm25p_addr_t len) {

    stm25p_addr_t i;
    uint16_t crc = 0;

    call USARTControl.rx(); // clear receive interrupt
    for ( i = 0; i < len; i++ ) {
      call USARTControl.tx(0);
      while(!(call USARTControl.isRxIntrPending()));
      crc = crcByte(crc, call USARTControl.rx());
    }

    *crcResult = crc;

    return SUCCESS;

  }

  event result_t BusArbitration.busFree() { return SUCCESS; }

}
