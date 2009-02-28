/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: BufferedLog.nc,v 1.1.4.1 2007/04/27 05:59:29 njain Exp $
 */
 
/**
 * This components supports high frequency logging.  While one buffer is
 * filled by application, the other buffer is written to EEPROM as a
 * background task.
 *
 * It supports the <code>LogData</code> interface, but only allows
 * individual appends up to the buffer size (currently 128). It is 
 * expected that each append will be small (e.g., a single or small
 * group of sensor samples) 
 */
module BufferedLog {
  provides {
    interface LogData;
    async command result_t fastAppend(uint8_t *data, uint8_t n);
  }
  uses interface LogData as Logger;
}
implementation {
  enum {
    BUFSIZE = 128
  };

  // sync operation state
  enum {
    F_NONE, // not running
    F_PENDING, // waiting for internal flush to complete
    F_FLUSHING // waiting for user flush to complete
  };
  enum {
    S_WRITE,
    S_BUSY,
    S_NOWRITE
  };
  uint8_t syncState;

  norace uint8_t buffer1[BUFSIZE], buffer2[BUFSIZE];
  norace uint8_t *buffer, *toFlush;
  norace uint8_t offset, flushCount;
  norace bool flushing;
  uint8_t state = S_NOWRITE;

  task void flushBuffer() {
    call Logger.append(toFlush, flushCount);
  }

  async command result_t fastAppend(uint8_t *data, uint8_t n) {
    uint8_t *ptr;
    result_t ok = SUCCESS;
    uint8_t oops;

    // Check for reentrancy attempt
    atomic
      {
	oops = state;
	if (oops == S_WRITE)
	  state = S_BUSY;
      }
    if (oops != S_WRITE)
      return FAIL;

    if (offset + n > BUFSIZE)
      {
	if (flushing)
	  ok = FAIL;
	else
	  {
	    flushing = TRUE;
	    toFlush = buffer;
	    flushCount = offset;
	    post flushBuffer();

	    offset = 0;
	    if (buffer == buffer1)
	      buffer = buffer2;
	    else
	      buffer = buffer1;
	  }
      }

    if (ok)
      {
	ptr = buffer + offset;
	offset += n;

	while (n--)
	  *ptr++ = *data++;
      }

    atomic state = S_WRITE;

    return ok;
  }

  command result_t LogData.append(uint8_t* data, uint32_t numBytes) {
    return FAIL;
  }

  void userFlushDone();
  void systemFlushDone();

  event result_t Logger.appendDone(uint8_t* data, uint32_t numBytes,
				   result_t success) {
    switch (syncState)
      {
      case F_FLUSHING:
	userFlushDone();
	break;
      case F_PENDING:
	systemFlushDone();
	break;
      case F_NONE: // Internal flush
	atomic flushing = FALSE;
	break;
      }
    return SUCCESS;
  }

  command result_t LogData.sync() {
    bool oops;

    // User-requested flush. Note that an internal flush may already
    // be in progress, and that must not be an error...

    atomic
      {
	oops = state;
	state = S_BUSY; // prevent further fastAppends
      }

    if (oops == S_BUSY)
      return FAIL;

    if (flushing) // Wait for internal flush to complete
      syncState = F_PENDING;
    else
      systemFlushDone();

    return SUCCESS;
  }

  void systemFlushDone() {
    if (offset)
      {
	syncState = F_FLUSHING;
	call Logger.append(buffer, offset);
      }
    else
      userFlushDone();
  }

  void userFlushDone() {
    call Logger.sync();
  }

  event result_t Logger.syncDone(result_t success) {
    atomic state = S_NOWRITE;
    return signal LogData.syncDone(success);
  }

  command result_t LogData.erase() {
    bool oops;

    atomic
      {
	oops = state;
	state = S_BUSY;
      }

    if (oops == S_BUSY)
      return FAIL;

    // Start logging to 1st buffer
    buffer = buffer1;
    offset = 0;
    flushing = FALSE;
    syncState = F_NONE;

    return call Logger.erase();
  }

  event result_t Logger.eraseDone(result_t success) {
    atomic state = S_WRITE;
    return signal LogData.eraseDone(success);
  }

  command uint32_t LogData.currentOffset() {
    return call Logger.currentOffset() + offset + (flushing ? flushCount : 0);
  }
}
