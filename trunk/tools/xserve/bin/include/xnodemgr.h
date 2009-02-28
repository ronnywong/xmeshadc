/**
 *  Contains functions to monitor individual nodes in the connected mesh network.
 *  Each parsed packet is searched for a special node id flag.  A table is maintained
 *  with an entry for each node.  The nodes NODEID, PARENTID, BOARDID, adn Time Last Heard
 *  are kept in each row.  The values can be accessed over the web interface by way of a
 *  call back function from the report server.
 *
 *
 * @file      xnodemgr.c
 * @author    Rahul kapur
 * @version   2005/8/01    rkapur      Initial version
 *
 * Copyright (c) 2004 Crossbow Technology, Inc.   All rights reserved.
 *
 * $Id: xnodemgr.h,v 1.9.2.10 2007/03/13 22:31:21 rkapur Exp $
 */


#ifndef __XNODEMGR_H__
#define __XNODEMGR_H__

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <time.h>
#include "xutil.h"
#include "xserve_types.h"
#include "xserve_consts.h"
#include "xdatarow.h"
#include "xdebug.h"
#include "xreportserv.h"

#ifndef __CYGWIN__
#include <stdint.h>
#endif


void xnodemgr_manage(XDataRow* dr);
void xnodemgr_print_html();

#endif



