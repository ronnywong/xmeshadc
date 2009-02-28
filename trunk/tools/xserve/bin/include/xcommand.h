/**
 * The functions in this file are responsible for loading the xcommand server
 * The xcommand server module is xml rpc implementation specific.  This file
 * seperates the XServe core from the library dependencies required by any
 * xml rpc implementation
 *
 *
 * @file      xcommand.c
 * @author    Rahul kapur
 * @version   2005/8/01    rkapur      Initial version
 *
 * Copyright (c) 2004 Crossbow Technology, Inc.   All rights reserved.
 *
 * $Id: xcommand.h,v 1.9.2.10 2007/03/13 22:30:03 rkapur Exp $
 */

#ifndef __XCOMMAND_H__
#define __XCOMMAND_H__

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include "xutil.h"
#include "xserve_consts.h"
#include "xserve_types.h"
#include "xserve.h"
#include "xdebug.h"

#ifndef __CYGWIN__
#include <stdint.h>
#endif

void xcommand_initialize();
void xcommand_print_versions();
void xcommand_load_command_server();

#endif



