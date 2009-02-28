/**
 * Provides access to the input parameters.  Parameters can be loaded from either the
 * command line or the xparam.properties file.
 *
 * @file      xparam.c
 * @author    Rahul kapur
 * @version   2005/8/01    rkapur      Initial version
 *
 * Copyright (c) 2004 Crossbow Technology, Inc.   All rights reserved.
 *
 * $Id: xparam.h,v 1.9.2.10 2007/03/13 22:31:27 rkapur Exp $
 */


#ifndef _XPARAM_H_
#define _XPARAM_H_

#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <ctype.h>
#include "xdebug.h"
#include "xutil.h"
#include "xserve_types.h"
#include "xserve_consts.h"

int xparams_is_cooked(XServeParams* xparams);
int xparams_is_parsed(XServeParams* xparams);
int xparams_is_raw(XServeParams* xparams);
int xparams_is_display(XServeParams* xparams);
int xparams_is_export(XServeParams* xparams);
int xparams_is_xml(XServeParams* xparams);
int xparams_is_db(XServeParams* xparams);
int xparams_is_modbus(XServeParams* xparams);
int xparams_is_xtest(XServeParams* xparams);

char* xparams_get_param(char* key, char* default_val);

void xparams_load_params();

XServeParams* xparams_get_xserveparams();

#endif
