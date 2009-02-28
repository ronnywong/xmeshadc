/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: SerialId.nc,v 1.1.4.1 2007/04/26 00:27:17 njain Exp $
 */
 
/**
 *
 * Revision:	$Id: SerialId.nc,v 1.1.4.1 2007/04/26 00:27:17 njain Exp $
 *
 * Read the mica's hardware id from the DS2401.
 * Warning: attempts to send radio messages or read the EEPROM during the
 * hardware id read may fail (because of weirdnesses in the flash select,
 * SPI and 1-wire pins (PB0/PE5), and missing software coordination to
 * compensate...)
 */
module SerialId {
  provides interface StdControl;
  provides interface HardwareId;

}
implementation {
  bool busy;
  uint8_t *serialId;

  command result_t StdControl.init() {
    busy = FALSE;
    return SUCCESS;
  }

  command result_t StdControl.start() {
    return SUCCESS;
  }

  command result_t StdControl.stop() {
    return SUCCESS;
  }

#define ONE_WIRE_LOW TOSH_MAKE_ONE_WIRE_OUTPUT
#define ONE_WIRE_OPEN TOSH_MAKE_ONE_WIRE_INPUT
#define ONE_WIRE_READ TOSH_READ_ONE_WIRE_PIN

  uint8_t serialIdByteRead() {
    uint8_t i, data = 0;

    for(i = 0; i < 8; i ++) 
      {
	data >>= 1;
	ONE_WIRE_LOW();
	TOSH_uwait(1);
	ONE_WIRE_OPEN();
	TOSH_uwait(10);
	if (ONE_WIRE_READ())
	  data |= 0x80;
	TOSH_uwait(50);
      }
    return data;
  }

  void serialIdByteWrite(uint8_t data) {
    uint8_t i;

    for(i = 0; i < 8; i ++)
      {
	ONE_WIRE_LOW();
	TOSH_uwait(1);
	if (data & 0x1)
	  ONE_WIRE_OPEN();
	TOSH_uwait(70);
	ONE_WIRE_OPEN();
	TOSH_uwait(2);
	data >>= 1;
      }
  }

  task void serialIdRead() {
    uint8_t cnt = 0;
    result_t success = FAIL;

    atomic {
      /* We're doing pull-lows only */
      TOSH_CLR_ONE_WIRE_PIN();

      ONE_WIRE_LOW();
      TOSH_uwait(500);
      cnt = 0;
      ONE_WIRE_OPEN();

      /* Wait for presence pulse */
      while (ONE_WIRE_READ() && cnt < 30)
	{
	  cnt++;
	  TOSH_uwait(30);
	}

      /* Wait for end of presence pulse */
      while (0 == ONE_WIRE_READ() && cnt < 30)
	{
	  cnt++;
	  TOSH_uwait(30);
	}

      if (cnt < 30)
	{
	  TOSH_uwait(500);
	  serialIdByteWrite(0x33);
	  for(cnt = 0; cnt < HARDWARE_ID_LEN; cnt ++)
	    serialId[cnt] = serialIdByteRead();

	  success = SUCCESS;
	}

      /* Restore flash select to its usual output role */
      TOSH_MAKE_FLASH_SELECT_OUTPUT();
    }

    busy = FALSE;
    signal HardwareId.readDone(serialId, success);
  }

  command result_t HardwareId.read(uint8_t *id) {
    if (!busy)
      {
	busy = TRUE;
	serialId = id;
	post serialIdRead();
	return SUCCESS;
      }
    return FAIL;
  }
  
}
