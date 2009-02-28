/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: Timer.h,v 1.1.4.1 2007/04/25 23:32:22 njain Exp $
 */

// Constants for Timer
#ifndef NTIMERS
#if NESC >= 110
#define NTIMERS uniqueCount("Timer")
#else
#define NTIMERS	12
#endif
#endif
enum {
    TIMER_REPEAT = 0,
    TIMER_ONE_SHOT = 1,
    NUM_TIMERS = NTIMERS
};
