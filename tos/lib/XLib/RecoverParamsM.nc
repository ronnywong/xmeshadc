/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * Copyright (c) 2004 by Sensicast, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: RecoverParamsM.nc,v 1.1.4.1 2007/04/25 23:42:23 njain Exp $
 */

//
// @Author: Michael Newman
//
//

// The point of this file is essentially to implement Config over either
//   ConfigInt16, ConfigInt8 or Config (only one should of those two should be wired).
//
//   When abstract components come along, the names unique to data
//   types can go away.

includes config;

module RecoverParamsM{

    provides interface Config as ExternalConfig[AppParamID_t setting];

    uses interface Config[AppParamID_t setting];
    uses interface ConfigInt8[AppParamID_t setting];
    uses interface ConfigInt16[AppParamID_t setting];
}
implementation {

#include <string.h>

#ifndef MIN
#define MIN(_a,_b) ((_a < _b) ? _a : _b)
#endif

    // retain value of parameter ID for tasks that signal the results
    AppParamID_t setParmID;
    AppParamID_t getParmID;
    
    command result_t ExternalConfig.set[AppParamID_t id](void *buffer, size_t size) {
	return call Config.set[id](buffer, size);
    }

    default command result_t Config.set[AppParamID_t id](void *buffer, size_t size) {
	int16_t value;

	if ((size != sizeof(uint16_t)) && (size != sizeof(uint8_t))) {
	    return FAIL;
	};
	// Config failed, assume it was because it was not wired and
	// try ConfigInt16 and ConfigInt8 (only one of the three should be wired anyway)
	value = 0;
	memcpy(&value, buffer, MIN(size,sizeof(value)));
	if (call ConfigInt16.set[id](value)) {
	    setParmID = id;
	    return SUCCESS;
	}
	if (call ConfigInt8.set[id]((uint8_t)(value&0xFF))) {
	    setParmID = id;
	    return SUCCESS;
	}
	return FAIL;
    }

    default command result_t ConfigInt8.set[AppParamID_t id](uint8_t value) {
	return FAIL;
    }

    default command result_t ConfigInt16.set[AppParamID_t id](uint16_t value) {
	return FAIL;
    }

    command size_t ExternalConfig.get[AppParamID_t id](void *buffer, size_t available) {
	return call Config.get[id](buffer, available);
    }

    default command size_t Config.get[AppParamID_t id](void *buffer, size_t size) {
	uint16_t value;
	uint8_t short_value;
	AppParamID_t curParmID;
	size_t sizeret;
	// Config failed, assume it was because it was not wired and
	// try ConfigInt16 or ConfigInt8 (only one of the three should be wired anyway)
	atomic getParmID = TOS_NO_PARAMETER; // Detect unconnected ConfigIntXX
	value = call ConfigInt16.get[id]();
	atomic  curParmID = getParmID;
	if (curParmID != TOS_UNUSED_PARAMETER) {
	    memcpy(buffer, &value, sizeof(int16_t));
	    curParmID = id;
	    sizeret = sizeof(uint16_t);
	    return sizeof(int16_t);
	};	
	atomic getParmID = TOS_NO_PARAMETER; // Detect unconnected ConfigIntXX
	short_value = call ConfigInt8.get[id]();
	atomic curParmID = getParmID;
	if (curParmID != TOS_UNUSED_PARAMETER) {
	    memcpy(buffer, &short_value, sizeof(int8_t));
	    curParmID = id;
	    return sizeof(uint8_t);
	};
	return 0;
    }

    default command uint16_t ConfigInt16.get[AppParamID_t id]() {
	atomic getParmID = TOS_UNUSED_PARAMETER;
	return 0;
    }

    default command uint8_t ConfigInt8.get[AppParamID_t id]() {
	atomic getParmID = TOS_UNUSED_PARAMETER;
	return 0;
    }
}
