/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: LoggerRead.nc,v 1.1.4.1 2007/04/25 23:25:17 njain Exp $
 */
 
/*
 * Authors:		Matt Welsh 
 * Date last modified:  8/27/02
 *
 *
 */

/**
 * @author Matt Welsh 
 */


includes EEPROM;

/**
 * Interface to read a line at a time from the EEPROM, maintaining
 * an internal "current line" pointer.
 */
interface LoggerRead {

  /**
   * Read the next line from the log, wrapping around to the beginning
   * of the log.
   * @param buffer The buffer to read data into.
   * @return FAIL if the component is busy, SUCCESS otherwise.
   */
  command result_t readNext(uint8_t *buffer);

  /**
   * Equivalent to calling setPointer(line) followed by read(buffer).
   * @param line The line to read from
   * @param buffer The buffer to read data into.
   * @return FAIL if the component is busy or the line is invalid, 
   *   SUCCESS otherwise.
   */
  command result_t read(uint16_t line, uint8_t *buffer);

  /**
   * Reset the current read pointer to the beginning of the log.
   * @return Always return SUCCESS.
   */
  command result_t resetPointer();

  /**
   * Set the current read pointer to the given value.
   * Not all pointer values are valid.
   * @param line The line to set the pointer to.
   * @return FAIL if the line is invalid, SUCCESS otherwise.
   */
  command result_t setPointer(uint16_t line);

  /**
   * Signaled when a read completes. 
   * @param buffer The buffer containing the read data.
   * @param success Whether the read was successful. If FAIL, the
   *   buffer data is invalid.
   */
  event result_t readDone(uint8_t *buffer, result_t success);

}

