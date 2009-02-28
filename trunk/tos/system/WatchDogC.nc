/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: WatchDogC.nc,v 1.1.4.1 2007/04/27 06:05:46 njain Exp $
 */

/*
 * Authors:		Su Ping  <sping@intel-research.net>
 *
 */

/**
 * The Watch dog interface. 
 * When enabled, the watch dog will reset a mote at a specified time
 * @author Su Ping <sping@intel-research.net>
 **/
includes TosTime;
configuration WatchDogC {
    provides interface WatchDog;  
}
implementation {
    components WatchDogM, AbsoluteTimerC, RandomLFSR, LogicalTime;

    WatchDog = WatchDogM;
    WatchDogM.Random -> RandomLFSR;
    WatchDogM.TimeUtil -> LogicalTime.TimeUtil;
    WatchDogM.AbsoluteTimer2 -> AbsoluteTimerC.AbsoluteTimer[unique("AbsoluteTimer")];
}

