/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: HPLUART1M.nc,v 1.1.2.3 2007/04/26 00:06:33 njain Exp $
 */
 
/*
 *
 * Authors:		Jason Hill, David Gay, Philip Levis, Phil Buonadonna
 * Date last modified:  $Revision: 1.1.2.3 $
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
 * @author Phil Buonadonna
 */

module HPLUART1M {
  provides interface HPLUART as UART;
  provides async command result_t SetUART1Baud(uint32_t baud_rate);
}
implementation
{
/****************************************************************************
   * Configure uart baudrate and enable uart 
   *  -Set UART to double speed  
   *  -Set frame format: 8 data-bits, 1 stop-bit
   *  -Enable reciever and transmitter and their interrupts
   ***************************************************************************/
  async command result_t SetUART1Baud(uint32_t baud_rate) {
   
   switch(baud_rate) {
      case 4800u:
        outp(0,UBRR1H); 
        outp(191, UBRR1L);
        break;
        
      case 9600u:
        outp(0,UBRR1H); 
        outp(95, UBRR1L);
        break;
   
      case 19200u:
        outp(0,UBRR1H); 
        outp(47, UBRR1L);
        break;

      case 57600u:
        outp(0,UBRR1H); 
        outp(15, UBRR1L);
        break;
  
      case 115200u:
        outp(0,UBRR1H); 
        outp(7, UBRR1L);
        break;

      default:
        return FAIL;
    }
    // Set UART double speed    
    outp((1<<U2X1),UCSR1A);    
    // Set frame format: 8 data-bits, 1 stop-bit    
    outp(((1 << UCSZ11) | (1 << UCSZ10)) , UCSR1C);   
    // Enable reciever and transmitter and their interrupts    
    outp(((1 << RXCIE1) | (1 << TXCIE1) | (1 << RXEN1) | (1 << TXEN1)) ,UCSR1B);
    return SUCCESS;
  }
 	
	
	
  async command result_t UART.init() {

    call SetUART1Baud(TOS_UART1_BAUDRATE);
    return SUCCESS;
  }
  
  async command result_t UART.stop() {
    outp(0x00, UCSR1A);
    outp(0x00, UCSR1B);
    outp(0x00, UCSR1C);
    return SUCCESS;
  }
  

  default async event result_t UART.get(uint8_t data) { return SUCCESS; }
  TOSH_SIGNAL(SIG_USART1_RECV) {
    if (inp(UCSR1A) & (1 << RXC1))
      signal UART.get(inp(UDR1));
  }

  default async event result_t UART.putDone() { return SUCCESS; }
  
#ifdef ENABLE_UART_DEBUG
#warning "UART Interrups Redirected"
#else
  TOSH_INTERRUPT(SIG_USART1_TRANS) {
    signal UART.putDone();
  }
#endif

  command async result_t UART.put(uint8_t data) {
    atomic{
      outp(data, UDR1); 
      sbi(UCSR1A, TXC1);
    }
    return SUCCESS;
  }

}
