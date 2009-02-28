/**
 * Handles loading the parser modules, registering them, and then
 * routing individual packets to the correct parsing module
 *
 * @file      xparse.c
 * @author    Martin Turon, Rahul Kapur
 * @version   2004/3/10    mturon      Initial version
 * @n         2005/11/1	   rkapur	   Major revisons for XServe2
 *
 * Copyright (c) 2004 Crossbow Technology, Inc.   All rights reserved.
 *
 * $Id: xparse.h,v 1.9.2.10 2007/03/13 22:31:33 rkapur Exp $
 */

#ifndef __XPARSE_H__
#define __XPARSE_H__

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include "xutil.h"
#include "xserve_consts.h"
#include "xserve_types.h"
#include "xserve.h"
#include "xdatarow.h"
#include "xdebug.h"

#ifndef __CYGWIN__
#include <stdint.h>
#endif

void xparse_initialize();
void xparse_register_handler(XParseHandler *handler);
XDataRow* xparse_parse_packet(unsigned char* buffer,int length);
void xparse_print_versions();


#endif



