/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: EEPROMRead.nc,v 1.1.4.1 2007/04/25 23:21:40 njain Exp $
 */
/*
 * Authors:		Jason Hill, David Gay, Philip Levis
 * Date last modified:  6/25/02
 */

/**
 * @author Jason Hill
 * @author David Gay
 * @author Philip Levis
 */


includes EEPROM;

/**
 * Read interface for the non-volatile storage EEPROM
 */
interface EEPROMRead {

  /** 
   * Read a line from the EEPROM.  Each line is 16 bytes.
   * Effects: try to read line <code>line</code> from the eeprom into buffer
   *
   * @param line the address of the line to be read
   * @param buffer an allocated buffer to read the line into
   *
   * @return FAIL if the component is busy or the line is invalid,
   *         SUCCESS otherwise.  If SUCCESS, will signal 
   *         <code>readDone()</code> when read completes.
   */
  command result_t read(uint16_t line, uint8_t *buffer);

  /**
   * Notification that the read has been completed.
   * 
   * @param buffer buffer the line has been read into
   * @param success SUCCESS if the read was successful
   *
   * @return SUCCESS always
   */ 
  event result_t readDone(uint8_t *buffer, result_t success);

}
