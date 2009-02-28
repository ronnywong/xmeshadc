/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: Attr.h,v 1.1.4.1 2007/04/25 23:18:20 njain Exp $
 */

/* 
 * Authors:  Wei Hong
 *           Intel Research Berkeley Lab
 * Date:     6/27/2002
 *
 */

// Header files for attributes -- See AttrUse.ti and AttrRegister.ti

// XXX nested .th files are not supported yet
// includes SchemaType;


/**
 * @author Wei Hong
 * @author Intel Research Berkeley Lab
 */

#define NUM_SYSTEM_ATTRS	13
#ifdef BOARD_MICASB
#define	NUM_SENSOR_ATTRS	10
#elif BOARD_MICAWB
#define NUM_SENSOR_ATTRS	6
#elif BOARD_MICAWBDOT
#define NUM_SENSOR_ATTRS	16
#endif

enum {
#if NESC >= 110
	MAX_ATTRS = uniqueCount("Attr")
#else
	MAX_ATTRS = NUM_SYSTEM_ATTRS 
//may not always be defined
#ifdef NUM_SENSOR_ATTRS
	   + NUM_SENSOR_ATTRS
#endif
#endif /* NESC >= 110 */
,
	MAX_CONST_LEN = 4,
	MAX_CONST_ATTRS = 1
};

// will add support for other languages later
typedef struct {
	TOSType type;	
	uint8_t nbytes;
    uint8_t idx; //index into AttrDesc array
	uint8_t id; // id for AttrRegister interface dispatch
	int8_t constIdx;  // index for constant values
	char *name;
} AttrDesc;

typedef AttrDesc *AttrDescPtr;

typedef struct {
  uint8_t numAttrs;
  AttrDesc attrDesc[MAX_ATTRS];
} AttrDescs;

typedef AttrDescs *AttrDescsPtr;
