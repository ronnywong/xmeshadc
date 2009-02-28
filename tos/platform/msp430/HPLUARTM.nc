/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2004, Technische Universitaet Berlin
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: HPLUARTM.nc,v 1.1.4.1 2007/04/26 22:05:57 njain Exp $
 */

/* - Description ----------------------------------------------------------
 * Implementation of UART0 lowlevel functionality - stateless.
 * - Revision -------------------------------------------------------------
 * $Revision: 1.1.4.1 $
 * $Date: 2007/04/26 22:05:57 $
 * @author Jan Hauer 
 * @author Vlado Handziski
 * @author Joe Polastre
 * ========================================================================
 */

includes msp430baudrates;

module HPLUARTM {
  provides interface HPLUART as UART;
  uses interface HPLUSARTControl as USARTControl;
  uses interface HPLUSARTFeedback as USARTData;
}
implementation
{

  async command result_t UART.init() {
    // set up the USART to be a UART
    call USARTControl.setModeUART();
    // use SMCLK
    call USARTControl.setClockSource(SSEL_SMCLK);
    // set the bitrate to 19200
    call USARTControl.setClockRate(UBR_SMCLK_57600, UMCTL_SMCLK_57600);
    // enable interrupts
    
    call USARTControl.enableRxIntr();
    call USARTControl.enableTxIntr();
    return SUCCESS;
  }

  async command result_t UART.stop() {
    call USARTControl.disableRxIntr();
    call USARTControl.disableTxIntr();
    // disable the UART modules so that we can go in deeper LowPower mode
    call USARTControl.disableUART();
    return SUCCESS;
  }

  async event result_t USARTData.rxDone(uint8_t b) {
    return signal UART.get(b);
  }

  async event result_t USARTData.txDone() {
    return signal UART.putDone();
  }

  async command result_t UART.put(uint8_t data){
    return call USARTControl.tx(data);
  }

  default async event result_t UART.get(uint8_t data) { return SUCCESS; }
  
  default async event result_t UART.putDone() { return SUCCESS; }
}
