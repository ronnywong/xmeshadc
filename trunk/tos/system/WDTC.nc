/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: WDTC.nc,v 1.1.4.1 2007/04/27 06:05:30 njain Exp $
 */


configuration WDTC {
    provides interface WDT;
    provides interface StdControl;
}

implementation {
    components TimerC, WDTM, HPLWatchdogM;
    WDTM.Timer -> TimerC.Timer[unique("Timer")];
    WDTM.reset -> HPLWatchdogM.reset;
    WDTM.WDTControl -> HPLWatchdogM.StdControl; 
    WDTM.TimerControl -> TimerC.StdControl;
    WDT = WDTM;
    StdControl = WDTM.StdControl;
}
