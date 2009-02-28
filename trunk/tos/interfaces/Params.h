/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: Params.h,v 1.1.4.1 2007/04/25 23:27:05 njain Exp $
 */

/* 
 * Authors:  Wei Hong
 *           Intel Research Berkeley Lab
 * Date:     9/25/2002
 *
 */

// data structures for command or event parameters


/**
 * @author Wei Hong
 * @author Intel Research Berkeley Lab
 */

#ifndef __PARAMS_H__
#define __PARAMS_H__

#include <stdarg.h>
#include "SchemaType.h"

enum {
	MAX_PARAMS = 4,
};

typedef struct {
	uint8_t numParams;	
	TOSType params[MAX_PARAMS];  //length == numParams
} ParamList;

typedef struct {
  uint8_t numParams;	
  char *paramDataPtr[MAX_PARAMS];  //list of pointers of parameter data, 
  			  // NULL pointer means NULL value
} ParamVals;

void
setParamList(ParamList *params, uint8_t nargs, ... /* variable number of TOSType arguments */)
{
	short i;
	va_list ap;
	params->numParams = nargs;
	va_start(ap, nargs);
	for (i = 0; i < nargs; i++)
		params->params[i] = va_arg(ap, TOSType);
	va_end(ap);
}
#endif /* __PARAMS_H__ */
