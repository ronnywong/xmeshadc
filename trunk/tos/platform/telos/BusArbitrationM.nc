/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: BusArbitrationM.nc,v 1.1.4.1 2007/04/26 22:18:53 njain Exp $
 */

/*
 *
 * Authors:		Joe Polastre
 *
 * $Id: BusArbitrationM.nc,v 1.1.4.1 2007/04/26 22:18:53 njain Exp $
 */

module BusArbitrationM {
  provides {
    interface BusArbitration[uint8_t id];
    interface StdControl;
  }
}
implementation {

  uint8_t state;
  uint8_t busid;
  bool isBusReleasedPending;
  enum { BUS_IDLE, BUS_BUSY, BUS_OFF };

  task void busReleased() {
    uint8_t i;
    uint8_t currentstate;
    // tell everyone the bus has been released
    atomic isBusReleasedPending = FALSE;
    for (i = 0; i < uniqueCount("BusArbitration"); i++) {
      atomic currentstate = state;
      if (currentstate == BUS_IDLE) 
        signal BusArbitration.busFree[i]();
    }
  }
 
  command result_t StdControl.init() {
    state = BUS_OFF;
    isBusReleasedPending = FALSE;
    return SUCCESS;
  }

  command result_t StdControl.start() {
    if (state == BUS_OFF) {
      state = BUS_IDLE;
      isBusReleasedPending = FALSE;
      return SUCCESS;
    }
    return FAIL;
  }

  command result_t StdControl.stop() {
    if (state == BUS_IDLE) {
      state = BUS_OFF;
      isBusReleasedPending = FALSE;
      return SUCCESS;
    }
    return FAIL;
  }

  async command result_t BusArbitration.getBus[uint8_t id]() {
    bool gotbus = FALSE;
    atomic {
      if (state == BUS_IDLE) {
        state = BUS_BUSY;
        gotbus = TRUE;
        busid = id;
      }
    }
    if (gotbus)
      return SUCCESS;
    return FAIL;
  }
 
  async command result_t BusArbitration.releaseBus[uint8_t id]() {
    atomic {
      if ((state == BUS_BUSY) && (busid == id)) {
        state = BUS_IDLE;

	// Post busReleased inside the if-statement so it's only posted if the
	// bus has actually been released.  And, only post if the task isn't
	// already pending.  And, it's inside the atomic because
	// isBusReleasedPending is a state variable that must be guarded.
	if( (isBusReleasedPending == FALSE) && (post busReleased() == TRUE) )
	  isBusReleasedPending = TRUE;

      }
    }
    return SUCCESS;
  }

  default event result_t BusArbitration.busFree[uint8_t id]() {
    return SUCCESS;
  }

}

