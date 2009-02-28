/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2004, Technische Universitaet Berlin
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: HPLUSARTControl.nc,v 1.1.4.1 2007/04/26 22:06:23 njain Exp $
 */
 
/*
 * - Description ----------------------------------------------------------
 * Byte-level interface to control a USART. 
 * <p>The USART can be switched to SPI- or UART-mode. The interface follows
 * the convention of being stateless, thus a higher layer has to maintain
 * state information. I.e. calling <code>tx</done> will transmit a byte of
 * data in the mode (SPI or UART) the USART has been set to before.
 * - Revision -------------------------------------------------------------
 * $Revision: 1.1.4.1 $
 * $Date: 2007/04/26 22:06:23 $
 * @author Jan Hauer (hauer@tkn.tu-berlin.de)
 * @author Joe Polastre
 * ========================================================================
 */
 
includes msp430usart;

interface HPLUSARTControl {

  /**
   * Returns an enum value corresponding to the current mode of the USART
   * module.  Allows one to read the module mode, change it, and then
   * reset it back to its original state after use.
   */
  async command msp430_usartmode_t getMode();

  /**
   * Sets the USART mode to one of the options from msp430_usartmode_t
   * defined in MSP430USART.h
   *
   * @return SUCCESS if the mode was changed
   */
  async command void setMode(msp430_usartmode_t mode);

  /**
   * Returns TRUE if the USART has UART TX mode enabled
   */
  async command bool isUARTtx();

  /**
   * Returns TRUE if the USART has UART RX mode enabled
   */
  async command bool isUARTrx();

  /**
   * Returns TRUE if the USART is set to UART mode (both RX and TX)
   */
  async command bool isUART();

 /**
   * Enables both the Rx and the Tx UART modules.
   */
  async command void enableUART();
  
 /**
   * Disables both the Rx and the Tx UART modules.
   */
  async command void disableUART();
 
 /**
   * Enables the UART TX functionality of the USART module.
   */
  async command void enableUARTTx();

 /**
   * Disables the UART TX module.
   */
  async command void disableUARTTx();

 /**
   * Enables the UART RX functionality of the USART module.
   */
  async command void enableUARTRx();

 /**
   * Disables the UART RX module.
   */
  async command void disableUARTRx();
  
 /**
   * Enables the USART when in SPI mode.
   */
  async command void enableSPI();
  
 /**
   * Disables the USART when in SPI mode.
   */
  async command void disableSPI();
  

  /**
   * Returns TRUE if the USART is set to SPI mode
   */
  async command bool isSPI();

 /**
   * Switches USART to SPI mode.
   */
  async command void setModeSPI();
	
 /**
   * Switches USART to UART TX mode (RX pins disabled).
   * Interrupts disabled by default.
   */	
  async command void setModeUART_TX();
	
 /**
   * Switches USART to UART RX mode (TX pins disabled)..
   * Interrupts disabled by default.
   */	
  async command void setModeUART_RX();

 /**
   * Switches USART to UART mode (RX and TX enabled)
   * Interrupts disabled by default.
   */	
  async command void setModeUART();

  /**
   * Returns TRUE if the module is set to I2C mode for MSP430 parts that
   * support hardware I2C.
   */
  async command bool isI2C();

  /**
   * Switches USART to I2C mode for MSP430 parts that support
   * hardware I2C. Interrupts disabled by default.
   */
  async command void setModeI2C();
 
  async command void setClockSource(uint8_t source);

  async command void setClockRate(uint16_t baudrate, uint8_t mctl);

  /* Dis/enabling of UTXIFG / URXIFG */
  async command result_t disableRxIntr();
  async command result_t disableTxIntr();
  async command result_t enableRxIntr();
  async command result_t enableTxIntr();
 
  /**
   * SUCCESS if TX interrupt pending, flag is cleared automatically 
   */
  async command result_t isTxIntrPending();

  /**
   * SUCCESS if RX interrupt pending, flag is cleared automatically 
   */
  async command result_t isRxIntrPending();

  /** 
   * SUCCESS if the TX buffer is empty and all of the bits have been
   * shifted out 
   */
  async command result_t isTxEmpty();

 /**
   * Transmit a byte of data. When the transmission is completed,
   * <code>txDone</done> is generated. Only then a new byte may be
   * transmitted, otherwise the previous byte will be overwritten.
   * The mode of transmission (UART or SPI) depends on the current state
   * of the USART, which must be managed by a higher layer.
   *
   * @return SUCCESS always.
   */
  async command result_t tx(uint8_t data);

  /**
   * Get current value from RX-buffer.
   *
   * @return SUCCESS always.
   */
  async command uint8_t rx();

}

