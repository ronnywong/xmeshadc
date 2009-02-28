/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: VoltageM.nc,v 1.3.2.1 2007/04/27 06:05:21 njain Exp $
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
    call ADCControl.bindPort(TOS_ADC_VOLTAGE_PORT, TOSH_ACTUAL_BANDGAP_PORT);
    dbg(DBG_BOOT, "Voltage initialized.\n");
    return call ADCControl.init();
  }
  command result_t StdControl.start() {
//#ifdef PLATFORM_MICA2
//	TOSH_MAKE_BAT_MON_OUTPUT();
//	TOSH_SET_BAT_MON_PIN();
//#endif
    return SUCCESS;
  }

  command result_t StdControl.stop() {
//#ifdef PLATFORM_MICA2
//	TOSH_CLR_BAT_MON_PIN();
//#endif
      return SUCCESS;
  }
}
