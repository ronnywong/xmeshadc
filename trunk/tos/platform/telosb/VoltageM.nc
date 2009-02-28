/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: VoltageM.nc,v 1.1.4.1 2007/04/26 22:26:04 njain Exp $
 */

/*
 *
 * Authors:	Wei Hong
 *
 */

/**
 * @author Wei Hong
 */


module VoltageM {
  provides interface StdControl;
  uses {
    interface ADCControl;
  }
}
implementation {

  command result_t StdControl.init() {
    call ADCControl.bindPort(TOS_ADC_INTERNAL_VOLTAGE_PORT, TOSH_ACTUAL_ADC_INTERNAL_VOLTAGE_PORT);
    dbg(DBG_BOOT, "Voltage initialized.\n");
    return call ADCControl.init();
  }
  command result_t StdControl.start() {
    return SUCCESS;
  }

  command result_t StdControl.stop() {
      return SUCCESS;
  }
}
