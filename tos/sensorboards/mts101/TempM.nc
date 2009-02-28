/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: TempM.nc,v 1.1.4.1 2007/04/27 05:34:13 njain Exp $
 */
 
/*
 *
 * Authors:		Jason Hill, David Gay, Philip Levis
 * Date last modified:  6/25/02
 *
 */


/*  TEMP_INIT command initializes the device */
/*  TEMP_GET_DATA command initiates acquiring a sensor reading. */
/*  It returns immediately.   */
/*  TEMP_DATA_READY is signaled, providing data, when it becomes */
/*  available. */
/*  Access to the sensor is performed in the background by a separate */
/* TOS task. */

/**
 * @author Jason Hill
 * @author David Gay
 * @author Philip Levis
 */


includes sensorboard;
module TempM {
  provides interface StdControl;
  uses {
    interface ADCControl;
  }
}
implementation 
{
  command result_t StdControl.init() {
    call ADCControl.bindPort(TOS_ADC_TEMP_PORT, TOSH_ACTUAL_TEMP_PORT);
    TOSH_MAKE_TEMP_CTL_OUTPUT();
    TOSH_SET_TEMP_CTL_PIN();
    dbg(DBG_BOOT, "TEMP initialized.\n");
    return call ADCControl.init();
  }
  command result_t StdControl.start() {
    TOSH_MAKE_TEMP_CTL_OUTPUT();
    TOSH_SET_TEMP_CTL_PIN();
    return SUCCESS;
  }
  command result_t StdControl.stop() {
    TOSH_CLR_TEMP_CTL_PIN();
    return SUCCESS;
  }
}

