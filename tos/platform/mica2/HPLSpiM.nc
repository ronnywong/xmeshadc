/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: HPLSpiM.nc,v 1.1.4.1 2007/04/26 00:15:16 njain Exp $
 */
 
/* 
 * Authors: Jaein Jeong, Philip buonadonna
 * Date last modified: $Revision: 1.1.4.1 $
 *
 */

/**
 * @author Jaein Jeong
 * @author Philip buonadonna
 */


module HPLSpiM
{
  provides interface SpiByteFifo;
  uses interface PowerManagement;
}
implementation
{
  norace uint8_t OutgoingByte; // Define norace to prevent nesC 1.1 warnings

  TOSH_SIGNAL(SIG_SPI) {
    register uint8_t temp = inp(SPDR);
    outp(OutgoingByte,SPDR);
    signal SpiByteFifo.dataReady(temp);
  }

  async command result_t SpiByteFifo.writeByte(uint8_t data) {
    //while(bit_is_clear(SPSR,SPIF));
    //outp(data, SPDR);
    atomic OutgoingByte = data;
    return SUCCESS;
  }

  async command result_t SpiByteFifo.isBufBusy() {
    return bit_is_clear(SPSR,SPIF);
  }

  async command uint8_t SpiByteFifo.readByte() {
    return inp(SPDR);
  }

  async command result_t SpiByteFifo.enableIntr() {
    //sbi(SPCR,SPIE);
    outp(0xC0, SPCR);
    cbi(DDRB, 0);
    call PowerManagement.adjustPower();
    return SUCCESS;
  }

  async command result_t SpiByteFifo.disableIntr() {
    cbi(SPCR, SPIE);
    sbi(DDRB, 0);
    cbi(PORTB, 0);
    call PowerManagement.adjustPower();
    return SUCCESS;
  }

  async command result_t SpiByteFifo.initSlave() {
    atomic {
      TOSH_MAKE_SPI_SCK_INPUT();
      TOSH_MAKE_MISO_INPUT();	// miso
      TOSH_MAKE_MOSI_INPUT();	// mosi
      cbi(SPCR, CPOL);		// Set proper polarity...
      cbi(SPCR, CPHA);		// ...and phase
      sbi(SPCR, SPIE);	// enable spi port
      sbi(SPCR, SPE);
    } 
    return SUCCESS;
  }
	
  async command result_t SpiByteFifo.txMode() {
    TOSH_MAKE_MISO_OUTPUT();
    TOSH_MAKE_MOSI_OUTPUT();
    return SUCCESS;
  }

  async command result_t SpiByteFifo.rxMode() {
    TOSH_MAKE_MISO_INPUT();
    TOSH_MAKE_MOSI_INPUT();
    return SUCCESS;
  }
}
