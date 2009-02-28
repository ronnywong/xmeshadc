/**
 * Opens a server socket and handles a list of client connections associated
 * with a server socket
 * Each connection contains a connection file descriptor and a connection type
 * It is up to the application to decide what the type field means
 *
 * @file      xservesocket.h
 * @author    Rahul kapur
 * @version   2005/8/01    rkapur      Initial version
 *
 * Copyright (c) 2004 Crossbow Technology, Inc.   All rights reserved.
 *
 * $Id: xservsocket.h,v 1.9.2.10 2007/03/13 22:32:17 rkapur Exp $
 */

#ifndef _XSERVSOCKET_H_
#define _XSERVSOCKET_H_

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

typedef void (*read_cb)(int fd);

typedef struct _connelem {
	int conn_fd;
	int type;
	void* next;
} XConnElem;

typedef struct _connlist {
  int length;
  int server_fd;
  XConnElem* head;
  XConnElem* tail;
} XConnList;

int xservsocket_open_server_socket(int port);
XConnList* xservsocket_create_list(int sfd);
XConnElem* xservsocket_create_elem(int cfd, int ctype);
void xservsocket_add_client(XConnList* clist, XConnElem* elem);
void xservsocket_remove_client(XConnList* clist, int fd);
void xservsocket_destroy_list(XConnList* clist);

#endif
