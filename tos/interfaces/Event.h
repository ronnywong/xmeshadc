/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: Event.h,v 1.1.4.1 2007/04/25 23:22:13 njain Exp $
 */

/* 
 * Authors:  Wei Hong
 *           Intel Research Berkeley Lab
 * Date:     9/24/2002
 *
 */

// data structures for Events


/**
 * @author Wei Hong
 * @author Intel Research Berkeley Lab
 */

#include <stdarg.h>
#include "Params.h"

enum {
	MAX_EVENTS = 2,
	MAX_EVENT_NAME_LEN = 8,
	MAX_EVENT_QUEUE_LEN = 8,
	MAX_CMD_PER_EVENT = 4
};

struct EventMsg {
    short nodeid;
    char fromBase;
    char data[0];  
};

enum {
  AM_EVENTMSG = 105
};

typedef struct {
	uint8_t idx; // index into EventDesc array
	char name[MAX_EVENT_NAME_LEN + 1];
	uint8_t cmds[MAX_CMD_PER_EVENT];
	uint8_t numCmds;
	bool deleted;
	ParamList params;
} EventDesc;

typedef EventDesc *EventDescPtr;

typedef struct {
	uint8_t numEvents;
	EventDesc eventDesc[MAX_EVENTS];
} EventDescs;

typedef struct {
	EventDescPtr	eventDesc;
	ParamVals		*eventParams;
} EventInstance;

typedef struct {
	EventInstance	events[MAX_EVENT_QUEUE_LEN];
	bool			inuse;
	short			head;
	short			tail;
	short			size;
} EventQueue;

typedef EventDescs *EventDescsPtr;
