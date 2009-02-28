/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: I2C.nc,v 1.1.4.1 2007/04/25 23:23:54 njain Exp $
 */

/**
 * Byte and Command interface for using the I2C hardware bus
 */
interface I2C
{
  /**
   * Checks if the bus is free and sends a start condition
   *
   * @return SUCCESS if the start request is accepted, FAIL otherwise
   */
  command result_t sendStart();

  /**
   * Sends a stop/end condition over the bus
   *
   * @return SUCCESS if the end request is accepted, FAIL otherwise
   */
  command result_t sendEnd();

  /**
   * reads a single byte from the I2C bus from a slave device
   *
   * @return SUCCESS if the read request is accepted, FAIL otherwise
   */
  command result_t read(bool ack);

  /**
   * writes a single byte to the I2C bus from master to slave
   *
   * @return SUCCESS if the write request is accepted, FAIL otherwise
   */
  command result_t write(char data);
  
  /**
   * Notifies that the start condition has been established
   *
   * @return SUCCESS to continue using the bus, FAIL to release it
   */
  event result_t sendStartDone();

  /**
   * Notifies that the end condition has been established
   *
   * @return Always return SUCCESS (you have released the bus)
   */
  event result_t sendEndDone();

  /**
   * Returns the byte read from the I2C bus
   *
   * @return SUCCESS to continue using the bus, FAIL to release it
   */
  event result_t readDone(char data);

  /**
   * Notifies that the byte has been written to the I2C bus
   *
   * @param success SUCCESS if the slave acknowledged the byte, FAIL otherwise
   *
   * @return SUCCESS to continue using the bus, FAIL to release it
   */
  event result_t writeDone(bool success);
}
