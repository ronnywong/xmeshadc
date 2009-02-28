/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: PageEEPROM.nc,v 1.1.4.1 2007/04/26 00:25:31 njain Exp $
 */
 
includes PageEEPROM;
interface PageEEPROM {
  command result_t write(eeprompage_t page, eeprompageoffset_t offset,
			 void *data, eeprompageoffset_t n);
  event result_t writeDone(result_t result);

  command result_t erase(eeprompage_t page, uint8_t eraseKind);
  event result_t eraseDone(result_t result);

  command result_t sync(eeprompage_t page);
  command result_t syncAll();
  event result_t syncDone(result_t result);

  command result_t flush(eeprompage_t page);
  command result_t flushAll();
  event result_t flushDone(result_t result);

  command result_t read(eeprompage_t page, eeprompageoffset_t offset,
			void *data, eeprompageoffset_t n);
  event result_t readDone(result_t result);

  command result_t computeCrc(eeprompage_t page, eeprompageoffset_t offset,
			      eeprompageoffset_t n);
  event result_t computeCrcDone(result_t result, uint16_t crc);
}
