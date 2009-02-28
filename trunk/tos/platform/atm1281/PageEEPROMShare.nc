/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: PageEEPROMShare.nc,v 1.1.2.2 2007/04/26 00:07:24 njain Exp $
 */
 
/**
 * Provide simple multi-client access to a PageEEPROM interface
 * (just request-response matching)
 */
module PageEEPROMShare {
  provides interface PageEEPROM[uint8_t id];
  uses interface PageEEPROM as ActualEEPROM;
}
implementation {
  enum {
    NCLIENTS = uniqueCount("PageEEPROM")
  };
  uint8_t lastClient;

  // Read & write the client id. We special case the 1-client case to
  // eliminate the overhead (still costs 1 byte of ram, though)
  int setClient(uint8_t client) {
    if (NCLIENTS != 1)
      {
	if (lastClient)
	  return FALSE;
	lastClient = client + 1;
      }
    return TRUE;
  }

  uint8_t getClient() {
    uint8_t id = 0;

    if (NCLIENTS != 1)
      {
	id = lastClient - 1;
	lastClient = 0;
      }

    return id;
  }

  /* Clear client if request failed. */
  result_t check(result_t requestOk) {
    if (requestOk != FAIL)
      return requestOk;
    lastClient = 0;
    return FAIL;
  }

  // Simply use the setClient, getClient functions to match requests &
  // responses. The inline reduces the overhead of this layer.
  inline command result_t PageEEPROM.write[uint8_t client](eeprompage_t page, eeprompageoffset_t offset,
						    void *data, eeprompageoffset_t n) {
    if (!setClient(client))
      return FAIL;
    return check(call ActualEEPROM.write(page, offset, data, n));
  }

  inline event result_t ActualEEPROM.writeDone(result_t result) {
    return signal PageEEPROM.writeDone[getClient()](result);
  }

  inline command result_t PageEEPROM.erase[uint8_t client](eeprompage_t page, uint8_t eraseKind) {
    if (!setClient(client))
      return FAIL;
    return check(call ActualEEPROM.erase(page, eraseKind));
  }

  inline event result_t ActualEEPROM.eraseDone(result_t result) {
    return signal PageEEPROM.eraseDone[getClient()](result);
  }

  inline command result_t PageEEPROM.sync[uint8_t client](eeprompage_t page) {
    if (!setClient(client))
      return FAIL;
    return check(call ActualEEPROM.sync(page));
  }

  inline command result_t PageEEPROM.syncAll[uint8_t client]() {
    if (!setClient(client))
      return FAIL;
    return check(call ActualEEPROM.syncAll());
  }

  inline event result_t ActualEEPROM.syncDone(result_t result) {
    return signal PageEEPROM.syncDone[getClient()](result);
  }

  inline command result_t PageEEPROM.flush[uint8_t client](eeprompage_t page) {
    if (!setClient(client))
      return FAIL;
    return check(call ActualEEPROM.flush(page));
  }

  inline command result_t PageEEPROM.flushAll[uint8_t client]() {
    if (!setClient(client))
      return FAIL;
    return check(call ActualEEPROM.flushAll());
  }

  inline event result_t ActualEEPROM.flushDone(result_t result) {
    return signal PageEEPROM.flushDone[getClient()](result);
  }

  inline command result_t PageEEPROM.read[uint8_t client](eeprompage_t page, eeprompageoffset_t offset,
						   void *data, eeprompageoffset_t n) {
    if (!setClient(client))
      return FAIL;
    return check(call ActualEEPROM.read(page, offset, data, n));
  }

  inline event result_t ActualEEPROM.readDone(result_t result) {
    return signal PageEEPROM.readDone[getClient()](result);
  }

  inline command result_t PageEEPROM.computeCrc[uint8_t client](eeprompage_t page, eeprompageoffset_t offset,
							 eeprompageoffset_t n) {
    if (!setClient(client))
      return FAIL;
    return check(call ActualEEPROM.computeCrc(page, offset, n));
  }

  inline event result_t ActualEEPROM.computeCrcDone(result_t result, uint16_t crc) {
    return signal PageEEPROM.computeCrcDone[getClient()](result, crc);
  }
  
  default event result_t PageEEPROM.writeDone[uint8_t client](result_t result) {
    return FAIL;
  }

  default event result_t PageEEPROM.eraseDone[uint8_t client](result_t result) {
    return FAIL;
  }

  default event result_t PageEEPROM.syncDone[uint8_t client](result_t result) {
    return FAIL;
  }

  default event result_t PageEEPROM.flushDone[uint8_t client](result_t result) {
    return FAIL;
  }

  default event result_t PageEEPROM.readDone[uint8_t client](result_t result) {
    return FAIL;
  }

  default event result_t PageEEPROM.computeCrcDone[uint8_t client](result_t result, uint16_t crc) {
    return FAIL;
  }
}
