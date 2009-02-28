
/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: HPLCC2420FIFOM.nc,v 1.1.2.2 2007/04/26 22:00:49 njain Exp $
 */

/*
 *
 * Authors: Alan Broad, Crossbow
 * Date last modified:  $Revision: 1.1.2.2 $
 *
 */

/**
 * Low level hardware access to the CC2420 Rx,Tx fifos
 * @author Alan Broad
 */

module HPLCC2420FIFOM {
  provides {
    interface HPLCC2420FIFO;
  }
}
implementation
{
  norace bool bSpiAvail;                    //true if Spi bus available
  norace uint8_t* txbuf; uint8_t* rxbuf;
  norace uint8_t txlength, rxlength;

  task void signalTXdone() {
    signal HPLCC2420FIFO.TXFIFODone(txlength, txbuf);
  }
/**
Returns data buffer from RXFIFO and number of bytes read.
@param rxlength Nofbytes read from RXFIFO (including 1st byte which is usually length
@param rxbuf pointer to buffer
**********************************************************************************/
  task void signalRXdone() {
    signal HPLCC2420FIFO.RXFIFODone(rxlength, rxbuf);
  }

  /**
   * Writes a series of bytes to the transmit FIFO.
   *
   * @param length nof bytes be written
   * @param msg pointer to first byte of data
   *
   * @return SUCCESS if the bus is free to write to the FIFO
   */
  async command result_t HPLCC2420FIFO.writeTXFIFO(uint8_t len, uint8_t *msg) {
     uint8_t i = 0;
     uint8_t status;

 //   while (!bSpiAvail){};                      //wait for spi bus

	atomic {
		bSpiAvail = FALSE;
		txlength = len;
		txbuf = msg;
		TOSH_CLR_CC_CS_PIN();                   //enable chip select
		outp(CC2420_TXFIFO,SPDR);
		while (!(inp(SPSR) & 0x80)){};          //wait for spi xfr to complete
		status = inp(SPDR);
		for (i=0; i < txlength; i++){
			outp(*txbuf,SPDR);
			txbuf++;
			while (!(inp(SPSR) & 0x80)){};          //wait for spi xfr to complete
			}
		bSpiAvail = TRUE;
		}  //atomic
	TOSH_SET_CC_CS_PIN();                       //disable chip select
#ifdef standard
    post signalTXdone();
    return status;
#else
	if(!status)
		txlength = status;		//0==fail
	return(txlength);
#endif
  }
  /**
   * Read from the RX FIFO queue.  Will read bytes from the queue
   * until the length is reached (determined by the first byte read).
   * RXFIFODone() is signalled when all bytes have been read or the
   * end of the packet has been reached.
   *
   * @param length number of bytes requested from the FIFO
   * @param data buffer bytes should be placed into
   *
   * @return SUCCESS if the bus is free to read from the FIFO
   */

//new version - just return requested number of bytes or as many as in buffer
/****************************************************************************
* .readRXFIFO
* - read requested number of bytes from RX FIFO
* -
* - returns	actual number of bytes in return.
* Note
* 1. Differs from MICAZ version- this code does NOT interpret the first byte
* in RXFIFO as a length byte.
***************************************************************************/

  async command result_t HPLCC2420FIFO.readRXFIFO(uint8_t len, uint8_t *msg) {
     uint8_t status,i;

 //   while (!bSpiAvail){};                      //wait for spi bus

	atomic {
	  bSpiAvail = FALSE;
      atomic rxbuf = msg;
	  rxlength = len;
	  TOSH_CLR_CC_CS_PIN();                   //enable chip select
	  outp(CC2420_RXFIFO | 0x40 ,SPDR);       //output Rxfifo address
	  while (!(inp(SPSR) & 0x80)){};          //wait for spi xfr to complete
	  status = inp(SPDR);

	  i = 0;
	  while( TOSH_READ_CC_FIFO_PIN() && (i<rxlength) ) {  //fifo not empty & get more
		outp(0,SPDR);
		while (!(inp(SPSR) & 0x80)){};          //wait for spi xfr to complete
		rxbuf[i] = inp(SPDR);
		i++;
	   }
	rxlength = i;	//nofbytes transfered
	  bSpiAvail = TRUE;
    } //atomic
	TOSH_SET_CC_CS_PIN();                       //disable chip select
#ifdef standard
    if (rxlength > 0) {
      return post signalRXdone();	  //return also indicates completion...
    }
    else {
      return FAIL;
    }
#else
	return(rxlength);	//now caller has all the info
#endif
  }// readRXFIFO

} //module



