/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: TimeSyncMsg.h,v 1.1.4.1 2007/04/25 23:32:05 njain Exp $
 */

// AM msg type
enum { AM_TIMESYNCMSG =37
};

struct TimeSyncMsg {
    uint16_t source_addr;
    uint32_t timeH;
    uint32_t timeL;      
    uint8_t level; // time sync depth
    uint8_t phase;
};

// constants for source_status field of the TimeSync Structure
// A simple of efficient way is to set time master as status 0
// and other motes' source_status = hop_cnt 
enum {
	MASTER = 1, 
        SLAVE_SYNCED=2,
        SLAVE_UNSYNCED=0
}; 

