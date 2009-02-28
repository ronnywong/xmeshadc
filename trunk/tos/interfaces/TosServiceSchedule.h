/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: TosServiceSchedule.h,v 1.1.4.1 2007/04/25 23:33:28 njain Exp $
 */

/* Author:  Robert Szewczyk
 *
 * $Id: TosServiceSchedule.h,v 1.1.4.1 2007/04/25 23:33:28 njain Exp $
 */

/**
 * @author Robert Szewczyk
 */


#ifndef _TOSSERVICESCHEDULE_H
#define _TOSSERVICESCHEDULE_H 1

#include "TosTime.h"

/**
 * tos_service_schedule describes the schedule of the service.  The service is
 * to be started at start_time, and run for on_time seconds.  If the off_time
 * is a non-negative number, the service is ran again after off_seconds
 * from the stop condition, otherwise it is treated as an one-time service.
 * Flags field is used for scheduling and coordination hints: they indicate
 * the state of the service at any point in time, as well as scheduling
 * policies for the particular service.  To that effect, the lower nibble of
 * the flags field is reserved for the scheduling policy and the upper nibble
 * is used to indicate the runtime state of the service. 
 */
typedef struct {
    tos_time_t start_time;
    int32_t on_time;
    int32_t off_time;
    uint8_t flags;
} tos_service_schedule;

enum {
    DISABLED = 0x00,
    ENABLED = 0x40,
    STOP = 0x10,
    START = 0x20
    
};

#endif /* _TOSSERVICESCHEDULE_H */

