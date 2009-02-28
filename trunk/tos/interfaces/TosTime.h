/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: TosTime.h,v 1.1.4.1 2007/04/25 23:33:37 njain Exp $
 */

#ifndef __TOS_TIME__
#define __TOS_TIME__
typedef struct {
    uint32_t high32;
    uint32_t low32;
}tos_time_t;
#endif
