/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: SounderM.nc,v 1.1.2.2 2007/04/27 05:38:43 njain Exp $
 */

/*
 *
 * Authors:	        Alec Woo, David Gay, Philip Levis
 * Date last modified:  6/25/02
 *
 */

/**
 * @author Alec Woo
 * @author David Gay
 * @author Philip Levis
 */


module SounderM {
  provides interface StdControl;
}
implementation 
{
  command result_t StdControl.init() {
    TOSH_MAKE_SOUNDER_CTL_OUTPUT();
    TOSH_CLR_SOUNDER_CTL_PIN();
    dbg(DBG_BOOT, "SOUNDER initialized.\n");
    return SUCCESS;
  }

  command result_t StdControl.start() {
    TOSH_SET_SOUNDER_CTL_PIN();
    dbg(DBG_SOUNDER, "SOUNDER started.\n");
    return SUCCESS;
  }

  command result_t StdControl.stop() {
    TOSH_CLR_SOUNDER_CTL_PIN();
    dbg(DBG_SOUNDER, "SOUNDER stopped.\n");
    return SUCCESS;
  }
}
