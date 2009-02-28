/**
 * Listens to the serial port, forwards to socket, provides packet parsing
 * services, and supplies web interface.  This is the core module.  At its most
 * basic it is a serial forwarder.  Additional functionality is based on modules
 * it is able to load for parsing, datasinks, command, etc.
 *
 * @file      xserve.c
 * @author    Martin Turon, Pi Peng, Rahul Kapur
 *
 * @version   2005/2/19    mturon      Initial version
 * @n         2005/5/19    pipeng      Added serial forwarder, httpd, threads
 * @n         2005/8/19    rkapur      Major rewrite -- xserve2, xmonitor
 *
 * Copyright (c) 2004-2005 Crossbow Technology, Inc.   All rights reserved.
 *
 * $Id: xserve.h,v 1.9.2.10 2007/03/13 22:31:59 rkapur Exp $
 */

#ifndef _XSERVE_H_
#define _XSERVE_H_

#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <netdb.h>
#include <errno.h>
#include <fcntl.h>
#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <signal.h>
#include <time.h>

#if !defined(__CYGWIN__)
#include <inttypes.h>
#else //__CYGWIN
#include <sys/types.h>
#endif //__CYGWIN

#include "xutil.h"
#include "xserve_types.h"
#include "xserve_consts.h"
#include "serialsource.h"
#include "xdatarow.h"
#include "xparse.h"
#include "xstore.h"
#include "xsocket.h"
#include "xdebug.h"
#include "xservsocket.h"
#include "xeventmgr.h"
#include "st.h"
#include "xreportserv.h"
#include "xnodemgr.h"
#include "xparam.h"
#include "xcommand.h"

void xserve_print_stats(int report_type, xbuffer* buffer);
void xserve_updateSfStats(sfStats_t *data, sfStats_t *update );
void xserve_count_packet(int direction, int len);
void xserve_initialize();
void stderr_msg(serial_source_msg problem);
int  xserve_check_serial_protocol(int fd);
int xserve_forward_packet(const void *packet, int len, int type);
void xserve_dispatch_packet_to_clients(const void *packet, int len);
void xserve_handle_client_in(int fd, void* data);
void xserve_handle_serial_in(int fd, void* data);
void xserve_handle_server_in(int fd, void* data);
void xserve_parse_serialforwarder(char* hostport);
void xserve_parse_device(char *dev);
int  xserve_parse_platform(char *platformName);
void xserve_parse_args(int argc, char** argv);
void xserve_print_input_params();
int xserve_main(int argc, char **argv);
void xserve_shutdown(int val);

#endif
