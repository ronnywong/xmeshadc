/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: SerialId.nc,v 1.1.4.1 2007/04/26 00:16:42 njain Exp $
 */
 
/**
 *
 * Revision:	$Id: SerialId.nc,v 1.1.4.1 2007/04/26 00:16:42 njain Exp $
 *
 * Read the micas's hardware id from the DS2401.
 */

module SerialId {
  provides interface StdControl;
  provides interface HardwareId;
}

implementation {
  bool gfReadBusy;
  uint8_t *serialId;

  command result_t StdControl.init() {
    gfReadBusy = FALSE;
    TOSH_MAKE_SERIAL_ID_INPUT();
    return SUCCESS;
  }

  command result_t StdControl.start() {
    TOSH_SET_SERIAL_ID_PIN();  // Enable pullup resistor to source current
    return SUCCESS;
  }

  command result_t StdControl.stop() {
    TOSH_CLR_SERIAL_ID_PIN();  // Tri-state pin
    return SUCCESS;
  }

#define SERIAL_ID_LOW() \
	TOSH_MAKE_SERIAL_ID_OUTPUT(); \
	TOSH_CLR_SERIAL_ID_PIN(); 

#define SERIAL_ID_OPEN() \
	TOSH_SET_SERIAL_ID_PIN();	\
	TOSH_MAKE_SERIAL_ID_INPUT();

#define SERIAL_ID_READ TOSH_READ_SERIAL_ID_PIN

  uint8_t serialIdByteRead() {
    uint8_t i, data = 0;

    for(i = 0; i < 8; i ++)  {
      data >>= 1;
      SERIAL_ID_LOW();
      TOSH_uwait(1);
      SERIAL_ID_OPEN();
      TOSH_uwait(10);
      if (SERIAL_ID_READ()) {
	data |= 0x80;
      }
      TOSH_uwait(50);
    }
    return data;
  }

  void serialIdByteWrite(uint8_t data) {
    uint8_t i;

    for(i = 0; i < 8; i ++){
      SERIAL_ID_LOW();
      TOSH_uwait(1);
      if (data & 0x1) {
	SERIAL_ID_OPEN();
      }
      TOSH_uwait(70);
      SERIAL_ID_OPEN();
      TOSH_uwait(2);
      data >>= 1;
    }
  }

  task void serialIdRead() {
    uint8_t cnt = 0;
    result_t success = FAIL;

    atomic {
      /* We're doing pull-lows only */
      TOSH_CLR_SERIAL_ID_PIN();

      SERIAL_ID_LOW();
      TOSH_uwait(500);
      cnt = 0;
      SERIAL_ID_OPEN();

      /* Wait for presence pulse */
      while (SERIAL_ID_READ() && cnt < 30) {
	cnt++;
	TOSH_uwait(30);
      }

      /* Wait for end of presence pulse */
      while (0 == SERIAL_ID_READ() && cnt < 30)	{
	cnt++;
	TOSH_uwait(30);
      }

      if (cnt < 30) {
	TOSH_uwait(500);
	serialIdByteWrite(0x33);
	for(cnt = 0; cnt < HARDWARE_ID_LEN; cnt ++)
	  serialId[cnt] = serialIdByteRead();

	success = SUCCESS;
      }

    }

    gfReadBusy = FALSE;
    signal HardwareId.readDone(serialId, success);
  }

  command result_t HardwareId.read(uint8_t *id) {
    if (!gfReadBusy) {
      gfReadBusy = TRUE;
      serialId = id;
      post serialIdRead();
      return SUCCESS;
    }
    return FAIL;
  }
  
}
