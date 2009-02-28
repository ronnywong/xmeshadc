/**
 * debugging util functions.  provides the ability to turn on/off debugging levels
 * and logs debug messages to a log file.
 *
 * @file      xdebug.c
 * @author    Rahul kapur
 * @version   2005/8/01    rkapur      Initial version
 *
 * Copyright (c) 2004 Crossbow Technology, Inc.   All rights reserved.
 *
 * $Id: xdebug.h,v 1.9.2.10 2007/03/13 22:30:57 rkapur Exp $
 */


#ifndef _XDEBUG_H_
#define _XDEBUG_H_

#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <stdarg.h>
#include <errno.h>
#include "xserve_consts.h"
#include "xserve_types.h"
#include "xparam.h"
//#include "xserve.h"

enum
{
 XDBG_1,
 XDBG_2,
 XDBG_3,
 XDBG_4,
 XDBG_5,
 XDBG_INFO,
 XDBG_WARNING,
 XDBG_ERROR,
 XDBG_OFF
};

void xdebug_set_level_s(char* level);
void xdebug_set_level(int level);
int xdebug_get_level();
void xdebug(int debug_level,char* fmt, ...);
void xdebug_nl(int debug_level,char* fmt, ...);
void xdebug_raw(int debug_level,char* fmt, ...);
void xdebug_initialize(char* filename);

//interesting way of doing this to get more info.
/*
#define xdebug(debug_level,fmt,args...) \
do { if (g_debug_level>=(debug_level)) xdebug_real((debug_level), __FUNCTION__, fmt, args);\
} while (0)
*/

#endif
