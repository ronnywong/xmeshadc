/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: AbsoluteTimer.h,v 1.1.4.1 2007/04/25 23:17:47 njain Exp $
 */

enum { 
#if NESC >= 110
    MAX_NUM_TIMERS= uniqueCount("AbsoluteTimer"),
#else
    MAX_NUM_TIMERS= 3
#endif
};
