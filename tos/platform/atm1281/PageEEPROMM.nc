/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: PageEEPROMM.nc,v 1.1.2.2 2007/04/26 00:07:15 njain Exp $
 */
 
includes crc;
includes PageEEPROM;
module PageEEPROMM {
  provides {
    interface StdControl;
    interface PageEEPROM;
  }
  uses {
    interface StdControl as FlashControl;
    interface SlavePin as FlashSelect;
    interface FastSPI as FlashSPI;
    interface Resource as FlashIdle;
    command bool getCompareStatus();
    interface Leds;
  }
}
implementation
{
#define CHECKARGS

#if 0
  uint8_t work[20];
  uint8_t woffset;

  void wdbg(uint8_t x) {
    work[woffset++] = x;
    if (woffset == sizeof work)
      woffset = 0;
  }
#else
#define wdbg(n)
#endif

  enum { // requests
    IDLE,
    R_READ,
    R_READCRC,
    R_WRITE,
    R_ERASE,
    R_SYNC,
    R_SYNCALL,
    R_FLUSH,
    R_FLUSHALL
  };
  uint8_t request;
  uint8_t *reqBuf;
  eeprompageoffset_t reqOffset, reqBytes;
  eeprompage_t reqPage;

  bool deselectRequested; /* deselect of EEPROM requested (needed between
			     two commands) */
  bool broken; // Write failed. Fail all subsequent requests.
  bool compareOk;

  enum {
    P_SEND_CMD, 
    P_READ,
    P_READCRC,
    P_WRITE,
    P_FLUSH,
    P_FILL,
    P_ERASE,
    P_COMPARE,
    P_COMPARE_CHECK
  };
  uint8_t cmdPhase, waiting;
  uint8_t *data, cmd[4];
  uint8_t cmdCount;
  eeprompageoffset_t dataCount;
  uint16_t computedCrc;

  struct {
    eeprompage_t page;
    bool busy : 1;
    bool clean : 1;
    bool erased : 1;
    uint8_t unchecked : 2;
  } buffer[2];
  uint8_t selected; // buffer used by the current op
  uint8_t checking;
  bool flashBusy;

  enum { // commands we're executing (all SPI Mode 0 or 3)
    C_READ_BUFFER1 = 0xd4,
    C_READ_BUFFER2 = 0xd6,
    C_WRITE_BUFFER1 = 0x84,
    C_WRITE_BUFFER2 = 0x87,
    C_FILL_BUFFER1 = 0x53, 
    C_FILL_BUFFER2 = 0x55, 
    C_FLUSH_BUFFER1 = 0x83,
    C_FLUSH_BUFFER2 = 0x86,
    C_QFLUSH_BUFFER1 = 0x88,
    C_QFLUSH_BUFFER2 = 0x89,
    C_COMPARE_BUFFER1 = 0x60,
    C_COMPARE_BUFFER2 = 0x61,
    C_REQ_STATUS = 0xd7,
    C_ERASE_PAGE = 0x81
  };
  // Select a command for the current buffer
#define OPN(n, name) ((n) ? name ## 1 : name ## 2)
#define OP(name) OPN(selected, name)

  command result_t StdControl.init() {
    request = IDLE;
    waiting = deselectRequested = FALSE;
    flashBusy = TRUE;
      
    // pretend we're on an invalid non-existent page
    buffer[0].page = buffer[1].page = TOS_EEPROM_MAX_PAGES;
    buffer[0].busy = buffer[1].busy = FALSE;
    buffer[0].clean = buffer[1].clean = TRUE;
    buffer[0].unchecked = buffer[1].unchecked = 0;
    buffer[0].erased = buffer[1].erased = FALSE;

    return call FlashControl.init();
  }
  
  command result_t StdControl.start() {
    return call FlashControl.start();
  }

  command result_t StdControl.stop() {
    return call FlashControl.stop();
  }

  /* Select EEPROM, start a SPI transaction */
  void selectFlash() {
    call FlashSelect.low();
  }

  /* Deselect EEPROM via SlavePin */
  void requestDeselect() {
    deselectRequested = TRUE;
    call FlashSelect.high(TRUE);
  }

  event result_t FlashIdle.available() {
    if (cmdPhase == P_COMPARE_CHECK)
      compareOk = call getCompareStatus();
    requestDeselect();
    return SUCCESS;
  }

  void requestFlashStatus() {
    waiting = TRUE;
    selectFlash();

    wdbg(C_REQ_STATUS);
    call FlashSPI.txByte(C_REQ_STATUS);
    if (call FlashIdle.wait() == FAIL) // already done
      signal FlashIdle.available();
  }

  void sendFlashCommand() {
    uint8_t in = 0, out = 0;
    uint8_t *ptr = cmd;
    eeprompageoffset_t count = cmdCount;
    uint16_t crc = 0;
    uint8_t lphase = P_SEND_CMD;

    /* For a 3% speedup, we could use labels and goto *.
       But: very gcc-specific. Also, need to do
              asm ("ijmp" : : "z" (state))
	    instead of goto *state
    */

    wdbg(cmd[0]);

    selectFlash();

    for (;;)
      {
	if (lphase == P_READCRC)
	  {
	    crc = crcByte(crc, in);

	    --count;
	    if (!count)
	      {
		computedCrc = crc;
		break;
	      }
	  }
	else if (lphase == P_SEND_CMD)
	  { 
	    out = *ptr++;
	    count--;
	    if (!count)
	      {
		lphase = cmdPhase;
		ptr = data;
		count = dataCount;
	      }
	  }
	else if (lphase == P_READ)
	  {
	    *ptr++ = in;
	    --count;
	    if (!count)
	      break;
	  }
	else if (lphase == P_WRITE)
	  {
	    if (!count)
	      break;

	    out = *ptr++;
	    --count;
	  }
	else /* P_FILL, P_FLUSH, P_ERASE, P_COMPARE */
	  break;
	
	in = call FlashSPI.txByte(out);
      }

    requestDeselect();
  }

  void requestDone(result_t result);

  task void taskSuccess() {
    requestDone(SUCCESS);
  }

  task void taskFail() {
    requestDone(FAIL);
  }

  void handleRWRequest();
  void execCommand(bool wait, uint8_t reqCmd, uint8_t dontCare,
		   eeprompage_t page, eeprompageoffset_t offset);

  void checkBuffer(uint8_t buf) {
    cmdPhase = P_COMPARE;
    checking = buf;
    execCommand(TRUE, OPN(buf, C_COMPARE_BUFFER), 0,
		buffer[buf].page, 0);
  }

  void flushBuffer() {
    cmdPhase = P_FLUSH;
    execCommand(TRUE, buffer[selected].erased ?
		OP(C_QFLUSH_BUFFER) :
		OP(C_FLUSH_BUFFER), 0,
		buffer[selected].page, 0);
  }

  void flashCommandComplete() {
    if (waiting)
      {
	waiting = flashBusy = buffer[0].busy = buffer[1].busy = FALSE;

	if (cmdPhase == P_COMPARE_CHECK)
	  {
	    if (compareOk)
	      buffer[checking].unchecked = 0;
	    else if (buffer[checking].unchecked < 2)
	      buffer[checking].clean = FALSE;
	    else
	      {
		broken = TRUE; // write failed. refuse all further reqs
		requestDone(FAIL);
		return;
	      }
	    handleRWRequest();
	  }
	else
	  {
	    // Eager compare - this steals the current command
#if 1
	    if ((buffer[0].unchecked || buffer[1].unchecked) &&
		!(cmdPhase == P_COMPARE || cmdPhase == P_COMPARE_CHECK))
	      checkBuffer(buffer[0].unchecked ? 0 : 1);
	    else
#endif
	      sendFlashCommand();
	  }
	return;
      }
    switch (cmdPhase)
      {
      default: // shouldn't happen
	requestDone(FAIL);
	break;

      case P_READ: case P_READCRC: case P_WRITE:
	requestDone(SUCCESS);
	break;

      case P_FLUSH:
	flashBusy = TRUE;
	buffer[selected].clean = buffer[selected].busy = TRUE;
	buffer[selected].unchecked++;
	buffer[selected].erased = FALSE;
	handleRWRequest();
	break;

      case P_COMPARE:
	cmdPhase = P_COMPARE_CHECK;
	flashBusy = TRUE;
	buffer[checking].busy = TRUE;
	// The 10us wait makes old mica motes (Atmega 103) happy, for
	// some mysterious reason (w/o this wait, the first compare
	// always fail, even though the compare after the rewrite
	// succeeds...)
	TOSH_uwait(10);
	requestFlashStatus();
	break;

      case P_FILL: // page load started
	flashBusy = TRUE;
	buffer[selected].page = reqPage;
	buffer[selected].clean = buffer[selected].busy = TRUE;
	buffer[selected].erased = FALSE;
	handleRWRequest();
	break;

      case P_ERASE:
	flashBusy = TRUE;
	// The buffer contains garbage, but we don't care about the state
	// of bits on this page anyway (if we do, we'll perform a 
	// subsequent write)
	buffer[selected].page = reqPage;
	buffer[selected].clean = TRUE;
	buffer[selected].erased = TRUE;
	requestDone(SUCCESS);
	break;
      }
  }

  event result_t FlashSelect.notifyHigh() {
    if (deselectRequested)
      {
	deselectRequested = FALSE;
	flashCommandComplete();
      }
    return SUCCESS;
  }

  void execCommand(bool wait, uint8_t reqCmd, uint8_t dontCare,
		   eeprompage_t page, eeprompageoffset_t offset) {
    // page (2 bytes) and highest bit of offset
    cmd[0] = reqCmd;
    cmd[1] = page >> 7;
    cmd[2] = page << 1 | offset >> 8;
    cmd[3] = offset; // low-order 8 bits
    cmdCount = 4 + dontCare;

    if (wait && flashBusy)
      requestFlashStatus();
    else
      sendFlashCommand();
  }

  void execRWBuffer(uint8_t reqCmd, uint8_t dontCare, eeprompageoffset_t offset) {
    execCommand(buffer[selected].busy, reqCmd, dontCare, 0, offset);
  }

  result_t syncOrFlushAll(uint8_t newReq);

  void handleRWRequest() {
    if (reqPage == buffer[selected].page)
      switch (request)
	{
	case R_ERASE:
	  switch (reqOffset)
	    {
	    case TOS_EEPROM_ERASE:
	      cmdPhase = P_ERASE;
	      execCommand(TRUE, C_ERASE_PAGE, 0, reqPage, 0);
	      break;
	    case TOS_EEPROM_PREVIOUSLY_ERASED:
	      // We believe the user...
	      buffer[selected].erased = TRUE;
	      /* Fallthrough */
	    case TOS_EEPROM_DONT_ERASE:
	      // The buffer contains garbage, but we don't care about the state
	      // of bits on this page anyway (if we do, we'll perform a 
	      // subsequent write)
	      buffer[selected].clean = TRUE;
	      requestDone(SUCCESS);
	      break;
	    }
	  break;

	case R_SYNC: case R_SYNCALL:
	  if (buffer[selected].clean && buffer[selected].unchecked)
	    {
	      checkBuffer(selected);
	      return;
	    }
	  /* fall through */
	case R_FLUSH: case R_FLUSHALL:
	  if (!buffer[selected].clean)
	    flushBuffer();
	  else if (request == R_FLUSH || request == R_SYNC)
	    post taskSuccess();
	  else
	    {
	      // Check for more dirty pages
	      uint8_t oreq = request;

	      request = IDLE;
	      syncOrFlushAll(oreq);
	    }
	  break;

	case R_READ:
	  data = reqBuf;
	  dataCount = reqBytes;
	  cmdPhase = P_READ;
	  execRWBuffer(OP(C_READ_BUFFER), 2, reqOffset);
	  break;

	case R_READCRC:
	  dataCount = reqBytes;
	  cmdPhase = P_READCRC;
	  execRWBuffer(OP(C_READ_BUFFER), 2, 0);
	  break;

	case R_WRITE:
	  data = reqBuf;
	  dataCount = reqBytes;
	  cmdPhase = P_WRITE;
	  buffer[selected].clean = FALSE;
	  buffer[selected].unchecked = 0;
	  execRWBuffer(OP(C_WRITE_BUFFER), 0, reqOffset);
	  break;
	}
    else if (!buffer[selected].clean)
      flushBuffer();
    else if (buffer[selected].unchecked)
      checkBuffer(selected);
    else
      {
	// just get the new page (except for erase)
	if (request == R_ERASE)
	  {
	    buffer[selected].page = reqPage;
	    handleRWRequest();
	  }
	else
	  {
	    cmdPhase = P_FILL;
	    execCommand(TRUE, OP(C_FILL_BUFFER), 0, reqPage, 0);
	  }
      }
  }

  void requestDone(result_t result) {
    uint8_t orequest = request;

    request = IDLE;
    switch (orequest)
      {
      case R_READ: signal PageEEPROM.readDone(result); break;
      case R_READCRC: signal PageEEPROM.computeCrcDone(result, computedCrc); break;
      case R_WRITE: signal PageEEPROM.writeDone(result); break;
      case R_SYNC: case R_SYNCALL: signal PageEEPROM.syncDone(result); break;
      case R_FLUSH: case R_FLUSHALL: signal PageEEPROM.flushDone(result); break;
      case R_ERASE: signal PageEEPROM.eraseDone(result); break;
      }
  }

  result_t newRequest(uint8_t req, eeprompage_t page,
		      eeprompageoffset_t offset,
		      void *reqdata, eeprompageoffset_t n) {
#ifdef CHECKARGS
    if (page >= TOS_EEPROM_MAX_PAGES || offset >= TOS_EEPROM_PAGE_SIZE ||
	n > TOS_EEPROM_PAGE_SIZE || offset + n > TOS_EEPROM_PAGE_SIZE)
      return FAIL;
#endif

    if (request != IDLE)
      return FAIL;
    request = req;

    if (broken)
      {
	post taskFail();
	return SUCCESS;
      }

    reqBuf = reqdata;
    reqBytes = n;
    reqPage = page;
    reqOffset = offset;

    if (page == buffer[0].page)
      selected = 0;
    else if (page == buffer[1].page)
      selected = 1;
    else
      selected = !selected; // LRU with 2 buffers...

    handleRWRequest();
    
    return SUCCESS;
  }

  command result_t PageEEPROM.read(eeprompage_t page, eeprompageoffset_t offset,
				   void *reqdata, eeprompageoffset_t n) {
    return newRequest(R_READ, page, offset, reqdata, n);
  }

  command result_t PageEEPROM.computeCrc(eeprompage_t page,
					 eeprompageoffset_t offset,
					 eeprompageoffset_t n) {
    if (n == 0)
      {
	request = R_READCRC;
	computedCrc = 0;
	post taskSuccess();
	return SUCCESS;
      }
    else
      return newRequest(R_READCRC, page, offset, NULL, n);
  }

  command result_t PageEEPROM.write(eeprompage_t page, eeprompageoffset_t offset,
				    void *reqdata, eeprompageoffset_t n) {
#if 0
    /* Fast write path */
    if (request == IDLE && !broken && page == buffer[selected].page &&
	!buffer[selected].busy)
      {
	eeprompageoffset_t i;

	request = R_WRITE;
	data = reqdata;
	dataCount = n;
	cmdPhase = P_WRITE;
	buffer[selected].clean = FALSE;
	buffer[selected].unchecked = 0;

	selectFlash();

	call FlashSPI.txByte(OP(C_WRITE_BUFFER));
	call FlashSPI.txByte(page >> 7);
	call FlashSPI.txByte(page << 1 | offset >> 8);
	call FlashSPI.txByte(offset);

	for (i = 0; i < n; i++)
	  call FlashSPI.txByte(((uint8_t *)reqdata)[i]);

	requestDeselect();

	return SUCCESS;
      }
#endif

    return newRequest(R_WRITE, page, offset, reqdata, n);
  }


  command result_t PageEEPROM.erase(eeprompage_t page, uint8_t eraseKind) {
    return newRequest(R_ERASE, page, eraseKind, NULL, 0);
  }

  result_t syncOrFlush(eeprompage_t page, uint8_t newReq) {
    if (request != IDLE)
      return FAIL;
    request = newReq;

    if (broken)
      {
	post taskFail();
	return SUCCESS;
      }
    else if (buffer[0].page == page)
      selected = 0;
    else if (buffer[1].page == page)
      selected = 1;
    else
      {
	post taskSuccess();
	return SUCCESS;
      }

    buffer[selected].unchecked = 0;
    handleRWRequest();

    return SUCCESS;
  }

  command result_t PageEEPROM.sync(eeprompage_t page) {
    return syncOrFlush(page, R_SYNC);
  }

  command result_t PageEEPROM.flush(eeprompage_t page) {
    return syncOrFlush(page, R_FLUSH);
  }

  result_t syncOrFlushAll(uint8_t newReq) {
    if (request != IDLE)
      return FAIL;
    request = newReq;

    if (broken)
      {
	post taskFail();
	return SUCCESS;
      }
    else if (!buffer[0].clean)
      selected = 0;
    else if (!buffer[1].clean)
      selected = 1;
    else
      {
	post taskSuccess();
	return SUCCESS;
      }

    buffer[selected].unchecked = 0;
    handleRWRequest();

    return SUCCESS;
  }

  command result_t PageEEPROM.syncAll() {
    return syncOrFlushAll(R_SYNCALL);
  }

  command result_t PageEEPROM.flushAll() {
    return syncOrFlushAll(R_FLUSHALL);
  }
}
