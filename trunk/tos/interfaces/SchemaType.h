/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: SchemaType.h,v 1.1.4.1 2007/04/25 23:29:52 njain Exp $
 */

/* 
 * Authors:  Wei Hong
 *           Intel Research Berkeley Lab
 * Date:     7/1/2002
 *
 */

/**
 * @author Wei Hong
 * @author Intel Research Berkeley Lab
 */


#ifndef __SCHEMATYPE_H__
#define __SCHEMATYPE_H__

typedef enum {
	SCHEMA_SUCCESS = 0,
	SCHEMA_ERROR,
	SCHEMA_RESULT_READY,
	SCHEMA_RESULT_NULL,
	SCHEMA_RESULT_PENDING
} SchemaErrorNo;

typedef enum {
	VOID = 0,
	INT8 = 1,
	UINT8 = 2,
	INT16 = 3,
	UINT16 = 4,
	INT32 = 5,
	UINT32 = 6,
	TIMESTAMP =7,
	STRING = 8,
	BYTES = 9,
	COMPLEX_TYPE =10 //e.g. a list, tree, etc.
} TOSType;

short
sizeOf(TOSType type)
{
	switch (type) {
	case VOID:
		return 0;
	case INT8:
	case UINT8:
		return 1;
	case INT16:
	case UINT16:
		return 2;
	case INT32:
	case UINT32:
		return 4;
	case TIMESTAMP:
		return 4;
	case STRING:
	  return 8; //hack! strings are of size 8...
	case BYTES:
	  return 8; //hack! strings are of size 8...
	default:
	  break;
	}
	return -1;
}

short
lengthOf(TOSType type, char *data)
{
	short len = sizeOf(type);
	if (type == STRING)
		len = strlen(data) + 1;
	return len;
}

struct CommandMsg {
  short nodeid;
  uint32_t seqNo;
  char data[0];  
};

#endif /* __SCHEMATYPE_H__ */
