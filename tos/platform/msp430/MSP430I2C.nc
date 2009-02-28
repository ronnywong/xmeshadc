/*
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: MSP430I2C.nc,v 1.1.4.1 2007/04/26 22:10:07 njain Exp $
 */

/**
 * @author Joe Polastre
 * Revision:  $Revision: 1.1.4.1 $
 *
 */
interface MSP430I2C {
  /**
   * Enable the I2C module (set the I2CEN bit)
   */
  async command result_t enable();
  /**
   * Disable the I2C module (clear the I2CEN bit)
   */
  async command result_t disable();

  /**
   * Set Master I2C mode
   */
  async command result_t setModeMaster();
  /**
   * Set Slave I2C mode
   */
  async command result_t setModeSlave();

  /**
   * Use 7-bit addressing mode
   */
  async command result_t setAddr7bit();
  /**
   * Use 10-bit addressing mode
   */
  async command result_t setAddr10bit();

  /**
   * Set the MSP430's own address
   */
  async command result_t setOwnAddr(uint16_t addr);
  /**
   * Set the slave address of the device for the next i2c bus transaction
   */
  async command result_t setSlaveAddr(uint16_t addr);

  /**
   * Only valid in Master mode.  Set the next i2c bus transaction to
   * transmit to a slave device.
   */
  async command result_t setTx();
  /**
   * Only valid in Master mode.  Set the next i2c bus transaction to
   * receive from a slave device.
   */
  async command result_t setRx();

  /**
   * Set the data to transmit in the I2C data register.
   */
  async command result_t setData(uint16_t value);
  /**
   * Get data from the I2C data register when in receive mode.
   */
  async command uint16_t getData();

  /**
   * Set the number of bytes to transmit or receive in master mode.
   */
  async command result_t setByteCount(uint8_t value);
  /**
   * Number of bytes to transmit or receive remaining in master mode.
   */
  async command uint8_t  getByteCount();

  async command result_t isArbitrationLostPending();
  async command result_t isNoAckPending();
  async command result_t isOwnAddrPending();
  async command result_t isReadyRegAccessPending();
  async command result_t isReadyRxDataPending();
  async command result_t isReadyTxDataPending();
  async command result_t isGeneralCallPending();
  async command result_t isStartRecvPending();

  async command void enableArbitrationLost();
  async command void disableArbitrationLost();

  async command void enableNoAck();
  async command void disableNoAck();

  async command void enableOwnAddr();
  async command void disableOwnAddr();

  async command void enableReadyRegAccess();
  async command void disableReadyRegAccess();

  async command void enableReadyRxData();
  async command void disableReadyRxData();

  async command void enableReadyTxData();
  async command void disableReadyTxData();

  async command void enableGeneralCall();
  async command void disableGeneralCall();

  async command void enableStartRecv();
  async command void disableStartRecv();

}
