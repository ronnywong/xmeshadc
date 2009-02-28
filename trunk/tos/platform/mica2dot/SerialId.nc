/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: SerialId.nc,v 1.1.4.1 2007/04/26 00:22:01 njain Exp $
 */
 
/**
 *
 * Revision:	$Id: SerialId.nc,v 1.1.4.1 2007/04/26 00:22:01 njain Exp $
 *
 * The mica2dot platform does not have a DS2401, nor does it have a SERIAL_ID pin.  
 * This is a dummy module that acts as a placeholder so applications can compile.
 * It DOES NOT return a unique serial ID.
 */

module SerialId {
  provides interface StdControl;
  provides interface HardwareId;
}

implementation {
  bool gfReadBusy;
  uint8_t *serialId;

#warning "SERIALID NOT SUPPORTED ON MICA2DOT PLATFORM!"
  command result_t StdControl.init() {
    gfReadBusy = FALSE;
    return SUCCESS;
  }

  command result_t StdControl.start() {
    return SUCCESS;
  }

  command result_t StdControl.stop() {
    return SUCCESS;
  }

  task void serialIdRead() {
    uint8_t i;

    for (i = 0; i < HARDWARE_ID_LEN; i++) {
      serialId[i] = 0xff;
    }

    signal HardwareId.readDone(serialId, FALSE);

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
