/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: MTS450EEPROM.nc,v 1.1.4.1 2007/04/27 05:53:06 njain Exp $
 */

/**
 * A higher level interface to send or receive a series of bytes
 * over the I2C hardware bus to/from a specified address.  
 * The underlying implementation uses the
 * <code>I2C</code> byte level command interface
 *
 *@modified by Xfshen , 2005/7/15 
 */
interface MTS450EEPROM
{
  /**
   * Reads a series of bytes from a slave device
   *
   * @param addr the start address to be written in 24**64,the highest three bits are not care
   * @param length the number of bytes to be read
   * @param flags bitmask that is defined:<br>
   * <table border=0><tr><td><code>STOP_FLAG</code></td>
   * <td><code>0x01</code></td>
   * <td>The stop/end command is sent at the end of the packet if set</td></tr>
   * <tr><td><code>ACK_FLAG</code></td>
   * <td><code>0x02</code></td>
   * <td>The master acks every byte except for the last received if set</td></tr>
   * <tr><td><code>ACK_END_FLAG</code></td>
   * <td><code>0x04</code></td>
   * <td>The master acks after the last byte read if set</td></tr>
   * <tr><td><code>ADDR_8BITS_FLAG</code></td>
   * <td><code>0x80</code></td>
   * <td>The slave address is a full eight bits, not seven and a read flag.</td></tr>
   * </table>
   *
   * @return SUCCESS if the bus is free and the request is accepted
   */
  command result_t readPacket(uint16_t addr, char length, char flags);
  /**
   * Writes a series of bytes to a slave device
   *
   * @param addr the start address to be written in 24**64,the highest three bits are not care
   * @param length the number of bytes to be written
   * @param data a pointer to the data to be written
   * @param flags bitmask that is defined:<br>
   * <table border=0><tr><td><code>STOP_FLAG</code></td>
   * <td><code>0x01</code></td>
   * <td>The stop/end command is sent at the end of the packet if set</td></tr>
   * <tr><td><code>ADDR_8BITS_FLAG</code></td>
   * <td><code>0x80</code></td>
   * <td>The slave address is a full eight bits, not seven and a read flag.</td></tr>
   * </table>
   *
   * @return SUCCESS if the bus is free and the request is accepted
   */
  command result_t writePacket(uint16_t addr, char length, char* data, char flags);  

  /**
   * Notifies that the bytes have been read from the slave device
   *
   * @param length the length of resulting data.  the application should
   * check if the length is equal to the requested length in the
   * <code>readPacket()</code> command.  If not, the application may assume
   * that the request has failed
   *
   * @param data a pointer to the bytes read from the bus
   *
   * @return SUCCESS to retain control of the bus, FAIL to release it
   */
  event result_t readPacketDone(char length, char* data);
  /**
   * Notifies that the bytes have been written to the slave device
   *
   * @param result SUCCESS if the slave acknowledged all bytes, FAIL otherwise
   *
   * @return SUCCESS to retain control of the bus, FAIL to release it
   */
  event result_t writePacketDone(bool result);
}
