/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: HPLWatchdogM.nc,v 1.1.4.1 2007/04/26 00:10:33 njain Exp $
 */

module HPLWatchdogM {
    provides interface StdControl;
    provides command void reset();
}

implementation {
    command result_t StdControl.init() {
	return SUCCESS;
    }
    command result_t StdControl.start() {
	wdt_enable(WDTO_1S);
	return SUCCESS;
    }
    command result_t StdControl.stop() {
	wdt_disable();
	return SUCCESS;
    }

    command void reset() {
	wdt_reset();
    }
    
}
