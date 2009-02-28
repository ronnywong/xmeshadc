/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: HPLSpiM.nc,v 1.1.4.1 2007/04/26 00:31:18 njain Exp $
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


/***************************************************************************** 
$Log: HPLSpiM.nc,v $
Revision 1.1.4.1  2007/04/26 00:31:18  njain
CVS: Please enter a Bugzilla bug number on the next line.
BugID: 1100

CVS: Please enter the commit log message below.
License header modified in each file for MoteWorks_2_0_F release

Revision 1.1  2006/01/03 07:46:20  mturon
Initial install of MoteWorks tree

Revision 1.2  2005/03/02 22:45:00  jprabhu
Added Log CVS-Tag

*****************************************************************************/
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
    while(bit_is_clear(SPSR,SPIF));
    outp(data, SPDR);
  //  atomic OutgoingByte = data;
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

  async command result_t SpiByteFifo.initMaster() {
	// Bit 7: SPIE = 1; enable SPI int

	// Bit 6: SPE  = 1; enable SPI 

	// Bit 5: DORD = 0; msb of data xmitted first

	// Bit 4: MSTR = 1; spi is master

	// Bit 3: CPOL = 0; spi clk is low when idle

	// Bit 2: CPHA = 0; sample data on positive edge of sclk

	// Bit 1,0: SPR1,SPR0; clock rate, 0 => fosc/4 (~550ns/bit, 4.4usec/byte)



    atomic {
      TOSH_MAKE_SPI_SCK_OUTPUT();
      TOSH_MAKE_MISO_INPUT();	   // miso
      TOSH_MAKE_MOSI_OUTPUT();	   // mosi

	  sbi (SPSR, SPI2X);           // Double speed spi clock

	  sbi(SPCR, MSTR);             // Set master mode
      cbi(SPCR, CPOL);		       // Set proper polarity...
      cbi(SPCR, CPHA);		       // ...and phase
	  cbi(SPCR, SPR1);             // set clock, fosc/2 (~3.6 Mhz)

      cbi(SPCR, SPR0);

  //    sbi(SPCR, SPIE);	           // enable spi port interrupt
      sbi(SPCR, SPE);              // enable spie port

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
