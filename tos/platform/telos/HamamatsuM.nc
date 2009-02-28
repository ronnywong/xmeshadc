/*
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: HamamatsuM.nc,v 1.1.4.1 2007/04/26 22:20:38 njain Exp $
 */

/*
 *
 * Authors:		Joe Polastre
 *
 * $Id: HamamatsuM.nc,v 1.1.4.1 2007/04/26 22:20:38 njain Exp $
 */

includes Hamamatsu;

module HamamatsuM {
  provides {
    interface StdControl;
  }
  uses {
    interface ADCControl;
  }
}
implementation {
  command result_t StdControl.init() {
    return SUCCESS;
  }

  command result_t StdControl.start() {
    result_t ok;
    atomic P6SEL |= 0x30;
    ok = call ADCControl.init();
    ok &= call ADCControl.bindPort(TOS_ADC_TSR_PORT,
				   TOSH_ACTUAL_ADC_TSR_PORT);
    ok &= call ADCControl.bindPort(TOS_ADC_PAR_PORT,
				   TOSH_ACTUAL_ADC_PAR_PORT);
    return ok;
  }

  command result_t StdControl.stop() {
    atomic P6SEL &= ~0x30;
    return SUCCESS;
  }
}
