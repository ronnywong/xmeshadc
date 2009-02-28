/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: EEPROMWrite.nc,v 1.1.4.1 2007/04/25 23:21:48 njain Exp $
 */
 
/*
 * Authors:		Jason Hill, David Gay, Philip Levis
 * Date last modified:  6/3/03
 */

/**
 * @author Jason Hill
 * @author David Gay
 * @author Philip Levis
 */


includes EEPROM;

/**
 * Write interface for the non-volatile EEPROM
 * <p>
 * Write lines to the EEPROM.
 * Each line is 16 bytes.
 * <p>
 * Writes must be surrounded by a <code>startWrite</code>, 
 * <code>endWrite</code> pair. Writes
 * are only final when <code>endWrite</code> is called. 
 * If <code>endWrite</code> is not called,
 * writes written since the last <code>startWrite</code> have 
 * undefined contents.
 */
interface EEPROMWrite {

  /**
   * Tells the EEPROM that we are going to start writing a line
   *
   * @return SUCCESS if the write is accepted
   */
  command result_t startWrite();

  /**
   * Writes the line to the EEPROM
   *
   * @param line address of the line to be written
   * @param buffer buffer of the bytes to be written
   *
   * @return SUCCESS if successful
   */
  command result_t write(uint16_t line, uint8_t *buffer);

  /**
   * Tells the EEPROM that we're done writing
   *
   * @return SUCCESS if the end command is accepted
   */
  command result_t endWrite();

  /**
   * Notification that the write has been completed
   *
   * @param buffer buffer written to the EEPROM
   *
   * @return SUCCESS always
   */
  event result_t writeDone(uint8_t *buffer);
  
  /**
   * Notification that the EEPROM has completed writing and ended
   * write mode
   *
   * @param success SUCCESS if the end command was successful
   *
   * @return SUCCESS always
   */
  event result_t endWriteDone(result_t success);
}
