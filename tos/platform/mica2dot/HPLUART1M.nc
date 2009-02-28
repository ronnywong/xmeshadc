/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: HPLUART1M.nc,v 1.1.4.3 2007/04/26 00:21:09 njain Exp $
 */
 
/*
 *
 * Authors:		Jason Hill, David Gay, Philip Levis
 * Date last modified:  $Revision: 1.1.4.3 $
 *
 */

// The hardware presentation layer. See hpl.h for the C side.
// Note: there's a separate C side (hpl.h) to get access to the avr macros

// The model is that HPL is stateless. If the desired interface is as stateless
// it can be implemented here (Clock, FlashBitSPI). Otherwise you should
// create a separate component


/**
 * @author Jason Hill
 * @author David Gay
 * @author Philip Levis
 */
module HPLUART1M {
  provides interface HPLUART as UART;

}
implementation
{
  command result_t UART.init() {

    // Set baudrate to 19.2 KBps
    outp(0,UBRR1H);
    outp(12, UBRR1L);
    inp(UDR1); 

    // Disable U2X and MPCM
    outp(0,UCSR1A);

    // Set frame format: 8 data-bits, 1 stop-bit
    outp(((1 << UCSZ1) | (1 << UCSZ0)) , UCSR1C);

    // Enable reciever and transmitter and their interrupts
    outp(((1 << RXCIE) | (1 << TXCIE) | (1 << RXEN) | (1 << TXEN)) ,UCSR1B);


    return SUCCESS;
  }

  default event result_t UART.get(uint8_t data) { return SUCCESS; }
  TOSH_SIGNAL(SIG_UART1_RECV) {
    if (inp(UCSR1A) & (1 << RXC))
      signal UART.get(inp(UDR1));
  }

  default event result_t UART.putDone() { return SUCCESS; }
  TOSH_INTERRUPT(SIG_UART1_TRANS) {
    signal UART.putDone();
  }

  command result_t UART.put(uint8_t data) {
    sbi(UCSR1A, TXC);
    outp(data, UDR1); 
    return SUCCESS;
  }
}
