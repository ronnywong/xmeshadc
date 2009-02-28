/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: HPLUARTM.nc,v 1.1.4.1 2007/04/26 00:10:23 njain Exp $
 */
 
/*
 *
 * Authors:		Jason Hill, David Gay, Philip Levis
 * Date last modified:  $Id: HPLUARTM.nc,v 1.1.4.1 2007/04/26 00:10:23 njain Exp $
 *
 */

// The hardware presentation layer. 

// The model is that HPL is stateless. If the desired interface is as stateless
// it can be implemented here (Clock, FlashBitSPI). Otherwise you should
// create a separate component


/**
 * @author Jason Hill
 * @author David Gay
 * @author Philip Levis
 */
module HPLUARTM {
  provides interface HPLUART as UART;

}
implementation
{
  async command result_t UART.init() {
    outp(12, UBRR);
    inp(UDR); 
    outp(0xd8,UCR);
    TOSH_SET_UART_RXD0_PIN();

    return SUCCESS;
  }

  async command result_t UART.stop() {
      outp(0x00, UCR);
      return SUCCESS;
  }

  default async event result_t UART.get(uint8_t data) { return SUCCESS; }
  TOSH_SIGNAL(SIG_UART_RECV) {
    if (inp(USR) & 0x80)
      signal UART.get(inp(UDR));
  }

  default event async result_t UART.putDone() { return SUCCESS; }
  TOSH_INTERRUPT(SIG_UART_TRANS) {
    signal UART.putDone();
  }

  command async result_t UART.put(uint8_t data) {
    sbi(USR, TXC);
    outp(data, UDR); 
    return SUCCESS;
  }
}
