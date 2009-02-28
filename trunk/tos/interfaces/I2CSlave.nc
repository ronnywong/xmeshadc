/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: I2CSlave.nc,v 1.1.4.1 2007/04/25 23:24:19 njain Exp $
 */

/**
 * Byte and Command interface for using the I2C hardware bus
 */
interface I2CSlave
{
  /**
   * Sets the address of the I2C Slave
   *
   * @return SUCCESS always
   */
  command result_t setAddress(uint8_t value);

  /**
   * Gets the address of the I2C Slave
   *
   * @return I2C Slave Address
   */
  command uint8_t getAddress();

  /**
   * Notifies the application that the master has written
   * a byte to the slave
   *
   * @return SUCCESS always
   */
  event result_t masterWrite(uint8_t value);

  /**
   * Notifies the application that the current data transfer
   * from the master has been completed
   *
   * @return SUCCESS always
   */
  event result_t masterWriteDone();

  /**
   * Notifies the application that the master is requesting
   * a byte from the slave.  The slave must *immediately* return
   * the next byte to be send and tell the I2C protocol if another
   * byte will be sent.
   *
   * @return byte to be sent to the master
   */
  event uint8_t masterRead();

  /**
   * Notifies the application that the master is done reading
   * from the slave
   *
   * @return SUCCESS always
   */
  event result_t masterReadDone();
  
}
