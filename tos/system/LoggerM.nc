/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: LoggerM.nc,v 1.1.4.1 2007/04/27 06:01:35 njain Exp $
 */


/*
 *
 * Authors:		Jason Hill, David Gay, Philip Levis
 * Date last modified:  6/25/02
 *
 */

/**
 * @author Jason Hill
 * @author David Gay
 * @author Philip Levis
 */


includes EEPROM;

module LoggerM
{
  provides {
    interface StdControl;
    interface LoggerWrite;
    interface LoggerRead;
  }
  uses {
    interface StdControl as EEPROMControl;
    interface EEPROMWrite;
    interface EEPROMRead;
  }
}
implementation
{
  uint16_t curWriteLine, curReadLine;
  result_t write_result;

  command result_t StdControl.init() {
    curWriteLine = EEPROM_LOGGER_APPEND_START;
    curReadLine = EEPROM_LOGGER_APPEND_START;
    return call EEPROMControl.init();
  }

  command result_t StdControl.start() {
    return call EEPROMControl.start();
  }

  command result_t StdControl.stop() {
    return call EEPROMControl.stop();
  }

  /* LoggerWrite commands ***********************************************/
  
  command result_t LoggerWrite.append(uint8_t *data) {

    if (call EEPROMWrite.startWrite() == FAIL) return FAIL;
    write_result = SUCCESS;
    if (call EEPROMWrite.write(curWriteLine, data) == FAIL) {
      write_result = FAIL;
      call EEPROMWrite.endWrite();
    }

    return SUCCESS;
  }

  command result_t LoggerWrite.write(uint16_t line, uint8_t *data) {
    if (call LoggerWrite.setPointer(line) == FAIL) return FAIL;
    return call LoggerWrite.append(data);
  }

  command result_t LoggerWrite.resetPointer() {
    curWriteLine = EEPROM_LOGGER_APPEND_START;
    return SUCCESS;
  }

  command result_t LoggerWrite.setPointer(uint16_t line) {
    if (line < EEPROM_LOGGER_APPEND_START ||
	line >= EEPROM_LOGGER_APPEND_END) {
      return FAIL;
    }
    curWriteLine = line;
    return SUCCESS;
  }

  event result_t EEPROMWrite.writeDone(uint8_t *buffer) {
    write_result = call EEPROMWrite.endWrite();
    return SUCCESS;
  }

  event result_t EEPROMWrite.endWriteDone(result_t success) {
    if (success == SUCCESS) {
      curWriteLine++;
      if (curWriteLine == EEPROM_LOGGER_APPEND_END)
       	curWriteLine = EEPROM_LOGGER_APPEND_START;
    }
    return signal LoggerWrite.writeDone(rcombine(write_result, success));
  }

  /* LoggerRead commands ***********************************************/

  command result_t LoggerRead.readNext(uint8_t *buffer) {
    return call EEPROMRead.read(curReadLine, buffer);
  }

  command result_t LoggerRead.read(uint16_t line, uint8_t *buffer) {
    if (call LoggerRead.setPointer(line) == FAIL) return FAIL;
    return call LoggerRead.readNext(buffer);
  }

  command result_t LoggerRead.resetPointer() {
    curReadLine = EEPROM_LOGGER_APPEND_START;
    return SUCCESS;
  }

  command result_t LoggerRead.setPointer(uint16_t line) {
    if (line < EEPROM_LOGGER_APPEND_START ||
	line >= EEPROM_LOGGER_APPEND_END) {
      return FAIL;
    }
    curReadLine = line;
    return SUCCESS;
  }

  event result_t EEPROMRead.readDone(uint8_t *buffer, result_t success) {
    if (success == SUCCESS) {
      curReadLine++;
      if (curReadLine == EEPROM_LOGGER_APPEND_END) {
	curReadLine = EEPROM_LOGGER_APPEND_START;
      }
    }
    return signal LoggerRead.readDone(buffer, success);
  }


}
