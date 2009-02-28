/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: ServiceSchedulerC.nc,v 1.1.4.1 2007/04/27 06:03:32 njain Exp $
 */

// Authors: Robert Szewczyk


configuration ServiceSchedulerC {
    provides interface ServiceScheduler;
    provides interface StdControl as SchedulerClt;
    uses interface StdControl[uint8_t id];
}

implementation {
    components ServiceSchedulerM, LogicalTime;
    ServiceSchedulerM.AbsoluteTimer -> LogicalTime.AbsoluteTimer[unique("AbsoluteTimer")];
    ServiceSchedulerM.TimeUtil -> LogicalTime.TimeUtil;
    ServiceSchedulerM.Time -> LogicalTime.Time;
    ServiceSchedulerM.SchedulerClt = SchedulerClt;

    ServiceScheduler = ServiceSchedulerM;
    StdControl = ServiceSchedulerM.Services;

}
