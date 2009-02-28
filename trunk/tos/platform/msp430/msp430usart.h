/*
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: msp430usart.h,v 1.1.4.1 2007/04/26 22:16:51 njain Exp $
 */

/**
 * @author Joe Polastre
 * Revision:  $Revision: 1.1.4.1 $
 */

#ifndef MSP430USART_H
#define MSP430USART_H

typedef enum
{
  USART_NONE = 0,
  USART_UART = 1,
  USART_UART_TX = 2,
  USART_UART_RX = 3,
  USART_SPI = 4,
  USART_I2C = 5
} msp430_usartmode_t;

#endif
