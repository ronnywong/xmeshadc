/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: AccelM.nc,v 1.1.4.1 2007/04/27 05:43:37 njain Exp $
 */
 
 /**
 * @author Alec Woo
 * @author Su Ping
 */

includes sensorboard;
module AccelM 
{
  provides interface StdControl;
  uses 
  {
    interface ADCControl;
  }
}
implementation 
{
  command result_t StdControl.init() 
  {
    call ADCControl.bindPort(TOS_ADC_ACCEL_X_PORT, TOSH_ACTUAL_ACCEL_X_PORT);
    call ADCControl.bindPort(TOS_ADC_ACCEL_Y_PORT, TOSH_ACTUAL_ACCEL_Y_PORT);
    TOSH_MAKE_ACCEL_CTL_OUTPUT();
    TOSH_CLR_ACCEL_CTL_PIN();
    dbg(DBG_BOOT, "ACCEL initialized.\n");
    return call ADCControl.init();
  }
  command result_t StdControl.start() 
  {
    TOSH_SET_ACCEL_CTL_PIN();
    return SUCCESS;
  }

  command result_t StdControl.stop() 
  {
      TOSH_CLR_ACCEL_CTL_PIN();
      return SUCCESS;
  }
}

