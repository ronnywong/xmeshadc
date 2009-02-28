/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: TimeSync.h,v 1.1.4.1 2007/04/25 23:31:48 njain Exp $
 */


// define default time sync interval
enum { 
    // define the amount of time to be adjusted at each clock interrupt
    TIME_OFFSET = 32,  // in unit of binary milliseconds
    // if local time diffs from Master time over TIME_MAX_ERR, 
    // the local time should be reset instead of adjumented
    TIME_MAX_ERR = 32,  // ms
    // define time sync interval 
    TIME_SYNC_INTERVAL = 61440U  // binary ms   
};


