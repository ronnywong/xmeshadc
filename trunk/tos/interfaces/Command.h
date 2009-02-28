/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: Command.h,v 1.1.4.1 2007/04/25 23:21:15 njain Exp $
 */

/* 
 * Authors:  Wei Hong
 *           Intel Research Berkeley Lab
 * Date:     6/27/2002
 *
 */

//Header fields for Commands -- See CommandUse.ti and CommandRegister.ti


/**
 * @author Wei Hong
 * @author Intel Research Berkeley Lab
 */

#include <stdarg.h>
#include "Params.h"

enum {
#if NESC >= 110
  MAX_COMMANDS = uniqueCount("Command"),
#else
  MAX_COMMANDS = 8
#endif
};

enum {
  AM_COMMANDMSG = 103,
};

typedef struct {
	uint8_t idx; // index into CommandDesc array
	char *name;
	uint8_t id; // id for CommandRegister interface dispatch
	TOSType retType;
	uint8_t retLen;
	ParamList params;
} CommandDesc;

typedef CommandDesc *CommandDescPtr;

typedef struct {
	uint8_t numCmds;
	CommandDesc commandDesc[MAX_COMMANDS];
} CommandDescs;

typedef CommandDescs *CommandDescsPtr;
