/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: HPLUART1M.nc,v 1.1.4.1 2007/04/27 05:58:17 njain Exp $
 */

/*
 *
 * Authors:		Jason Hill, David Gay, Philip Levis
 * Date last modified:  $Revision: 1.1.4.1 $
 *
 */

// The hardware presentation layer. See hpl.h for the C side.
// Note: there's a separate C side (hpl.h) to get access to the avr macros

// The model is that HPL is stateless. If the desired interface is as stateless
// it can be implemented here (Clock, FlashBitSPI). Otherwise you should
// create a separate component
/*========================================================
REVISION HISTORY
03mar05 mm	MICA2DOT changed to UART1 from UART0. Not tested
			Changed .stop - just disable interrupts, do NOT clear baud/mode
******************************************************************/

module HPLUART1M {
  provides interface HPLUART as UART;

}

implementation
{
  async command result_t UART.init() {


#ifdef PLATFORM_MICA2DOT
 //using UART0????
    // Set baudrate to 9600 Kbps )
    outp(0,UBRR1H);
    outp(25, UBRR1L);  // MICA2DOT frequency = 4.0 MHz (U2X==0)
    inp(UDR0); 

    // Disable U2X and MPCM
    outp(0,UCSR0A);

    // Set frame format: 8 data-bits, 1 stop-bit
    outp(((1 << UCSZ1) | (1 << UCSZ0)) , UCSR1C);

    // Enable reciever and transmitter and their interrupts	   
    outp(((1 << RXCIE) | (1 << TXCIE) | (1 << RXEN) | (1 << TXEN)) ,UCSR1B);

#else // else MICA2 or MICAZ (uses UART1)

    // Set baudrate to 9600 Kbps
    outp(0,UBRR1H);
    outp(47, UBRR1L);  // MICA2 frequency = 7.3728 MHz (U2X==0)
    inp(UDR1); 

    // Disable U2X and MPCM
    outp(0,UCSR1A);

    // Set frame format: 8 data-bits, 1 stop-bit
    outp(((1 << UCSZ1) | (1 << UCSZ0)) , UCSR1C);

    // Enable reciever and transmitter and their interrupts	
    //sideeffect is clears Zn2 bit - prevents 9bit data format   
    outp(((1 << RXCIE) | (1 << TXCIE) | (1 << RXEN) | (1 << TXEN)) ,UCSR1B);

#endif

    return SUCCESS;
  }

  async command result_t UART.stop() {

#ifdef PLATFORM_MICA2DOT

    outp(0x00, UCSR0A);
    outp(0x00, UCSR0B);
    outp(0x00, UCSR0C);

#else // else MICA2 or MICAZ (uses UART1)
    // Disable reciever and transmitter and their interrupts	   
    outp(((0 << RXCIE) | (0 << TXCIE) | (0 << RXEN) | (0 << TXEN)) ,UCSR1B);
    
#endif

    return SUCCESS;
  }

  default async event result_t UART.get(uint8_t data) { return SUCCESS; }

#ifdef PLATFORM_MICA2DOT

  TOSH_SIGNAL(SIG_UART0_RECV) {
    if (inp(UCSR0A) & (1 << RXC))
      signal UART.get(inp(UDR0));
  }

#else // MICA2 or MICAZ (uses UART1)

  TOSH_SIGNAL(SIG_UART1_RECV) {
    if (inp(UCSR1A) & (1 << RXC))
      signal UART.get(inp(UDR1));
  }

#endif




  default async event result_t UART.putDone() { return SUCCESS; }


#ifdef ENABLE_UART_DEBUG
#warning "UART Interrups Redirected"
#else


#ifdef PLATFORM_MICA2DOT
  TOSH_INTERRUPT(SIG_UART0_TRANS) {

#else  // MICA2 or MICAZ(uses UART1)
  TOSH_INTERRUPT(SIG_UART1_TRANS) {

#endif

    signal UART.putDone();
  }
  
#endif



  async command result_t UART.put(uint8_t data) {

#ifdef PLATFORM_MICA2DOT
    outp(data, UDR0); 
    sbi(UCSR0A, TXC);

#else // MICA2 or MICAZ (uses UART1)
    outp(data, UDR1); 
    sbi(UCSR1A, TXC);

#endif
    return SUCCESS;
  }
}
