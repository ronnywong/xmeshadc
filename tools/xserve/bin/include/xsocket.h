/**
 * Handles low-level socket communication.
 *
 * @file      xsocket.c
 * @author    Martin Turon
 * @version   2004/8/20    mturon      Initial version
 *
 * Copyright (c) 2004 Crossbow Technology, Inc.   All rights reserved.
 *
 * $Id: xsocket.h,v 1.9.2.10 2007/03/13 22:32:24 rkapur Exp $
 */

#ifndef _XSOCKET_H_
#define _XSOCKET_H_


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
#include "xtimer.h"


int saferead(int fd, void *buffer, int count);
int safewrite(int fd, const void *buffer, int count);
int xsocket_open_client_connection(char* name, unsigned long port);
/*
Reads a packet using the xsocket comm protocol.  The
protocol adds 2 bytes to the header.  The first byte is
the length of the packet and the second byte is the
packet type.
*/
void* xsocket_read_packet(int fd, int* len);
/* Effects: writes len byte packet to serial forwarder on file descriptor
     fd
   Returns: 0 if packet successfully written, -1 otherwise
*/
int xsocket_write_packet(int fd, const void *packet, int len);

void xsocket_allow_interrupt();

void xsocket_initialize();

#endif
