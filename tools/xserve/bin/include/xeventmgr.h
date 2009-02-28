/**
 * Event manager manages event based applications which
 * wait for an input from a set of connections (file descp)
 * It manages the set of events and uses event call back functions
 * when an event has occured (ie a blocked select on the list of file
 * desc has returned)
 *
 * @file      xeventmgr.c
 * @author    Rahul kapur
 * @version   2005/8/01    rkapur      Initial version
 *
 * Copyright (c) 2004 Crossbow Technology, Inc.   All rights reserved.
 *
 * $Id: xeventmgr.h,v 1.9.2.10 2007/03/13 22:31:04 rkapur Exp $
 */

#ifndef _XEVENTMGR_H_
#define _XEVENTMGR_H_


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
#include "xdebug.h"

enum{
	EVENT_STATE_REMOVED = 2,
	EVENT_STATE_ADDED = 1,
	EVENT_STATE_NORMAL = 0
};


typedef void (*event_cb)(int fd, void* data);

typedef struct event_elem{
  int fd;
  void* data;
  event_cb event;
  struct event_elem *next;
  int state;
} XEventElem;

void fd_wait(fd_set *fds, int *maxfd, int fd);
void wait_event_list(fd_set *fds, int *maxfd);
void check_event_list(fd_set *fds);
void xeventmgr_add_event(int fd, void* data, event_cb ecb);
void xeventmgr_remove_event(int fd);
void xeventmgr_start();
void xeventmgr_destroy();

#endif
