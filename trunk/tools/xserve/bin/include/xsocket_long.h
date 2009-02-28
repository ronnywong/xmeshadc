/**
 * Handles low-level socket communication.
 *
 * @file      xsocket_long.c
 * @author    Martin Turon
 * @version   2004/8/20    mturon      Initial version
 * @n		  2005/11/01   rkapur	   New protocol based on original xsocket which uses a 4 byte length field
 *
 * Copyright (c) 2004 Crossbow Technology, Inc.   All rights reserved.
 *
 * $Id: xsocket_long.h,v 1.9.2.10 2007/03/13 22:32:30 rkapur Exp $
 */

#ifndef _XSOCKET_LONG_H_
#define _XSOCKET_LONG_H_


#include <sys/types.h>
#include <sys/socket.h>
#include <netdb.h>
#include <netinet/in.h>
#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>
#include <string.h>

#include "xutil.h"
#include "xsocket.h"

void* xsocket_long_read_packet(int fd, int* len);
int xsocket_long_write_packet(int fd, const void *packet, int len);

#endif
