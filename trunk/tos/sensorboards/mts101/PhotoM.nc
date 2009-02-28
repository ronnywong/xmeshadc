/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: PhotoM.nc,v 1.1.4.1 2007/04/27 05:33:56 njain Exp $
 */
 
/*
 *
 * Authors:		Jason Hill, David Gay, Philip Levis
 * Date last modified:  6/25/02
 *
 */

/*  OS component abstraction of the analog photo sensor and */
/*  associated A/D support.  It provides an asynchronous interface */
/*  to the photo sensor. */

/*  PHOTO_INIT command initializes the device */
/*  PHOTO_GET_DATA command initiates acquiring a sensor reading. */
/*  It returns immediately.   */
/*  PHOTO_DATA_READY is signaled, providing data, when it becomes */
/*  available. */
/*  Access to the sensor is performed in the background by a separate */
/* TOS task. */

/**
 * @author Jason Hill
 * @author David Gay
 * @author Philip Levis
 */


includes sensorboard;
module PhotoM {
  provides interface StdControl;
  uses {
    interface ADCControl;
  }
}
implementation {

  command result_t StdControl.init() {
    call ADCControl.bindPort(TOS_ADC_PHOTO_PORT, TOSH_ACTUAL_PHOTO_PORT);
    TOSH_MAKE_PHOTO_CTL_OUTPUT();
    TOSH_SET_PHOTO_CTL_PIN();
    dbg(DBG_BOOT, "PHOTO initialized.\n");
    return call ADCControl.init();
  }

  command result_t StdControl.start() {
    TOSH_MAKE_PHOTO_CTL_OUTPUT();
    TOSH_SET_PHOTO_CTL_PIN();
    return SUCCESS;
  }
  command result_t StdControl.stop() {
    TOSH_CLR_PHOTO_CTL_PIN();
    return SUCCESS;
  }
}

