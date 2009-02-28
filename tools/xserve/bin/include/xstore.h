/**
 * Handles dynamically loading datasinks and routing datarow entries
 * produced by the parsers to all the requesting datasinks.
 *
 * @file      xstore.c
 * @author    Martin Turon, Rahul kapur
 * @version   2004/3/10    mturon      Initial version
 * @n         2005/11/1    rkapur      Major rewrite for XServe2
 *
 * Copyright (c) 2004 Crossbow Technology, Inc.   All rights reserved.
 *
 * $Id: xstore.h,v 1.9.2.10 2007/03/13 22:32:36 rkapur Exp $
 */

#ifndef __XSTORE_H__
#define __XSTORE_H__

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include "xutil.h"
#include "xserve_types.h"
#include "xserve_consts.h"
#include "xserve.h"
#include "xdatarow.h"
#include "xdebug.h"

#ifndef __CYGWIN__
#include <stdint.h>
#endif


void xstore_initialize();
void xstore_register_handler(XStoreHandler *handler);
void xstore_store_row(XDataRow* row);
void xstore_print_versions();


#endif  /* __SENSORS_H__ */



