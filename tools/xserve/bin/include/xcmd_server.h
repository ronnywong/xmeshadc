/**
 * The functions in this file are responsible for loading dynamic command
 * modules.  It uses the XML RPC Epinion implementation to provide XML RPC
 * functionality to registered methods
 *
 *
 * @file      xcommand.c
 * @author    Rahul kapur
 * @version   2005/8/01    rkapur      Initial version
 *
 * Copyright (c) 2004 Crossbow Technology, Inc.   All rights reserved.
 *
 * $Id: xcmd_server.h,v 1.9.2.10 2007/03/13 22:29:57 rkapur Exp $
 */

#ifndef __XCOMMANDSERV_H__
#define __XCOMMANDSERV_H__

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include "xutil.h"
#include "xserve_consts.h"
#include "xserve_types.h"
#include "xserve.h"
#include "xdebug.h"
#include "xsocket.h"
#include "xsocket_long.h"
#include "xservsocket.h"
#include "xparam.h"
#include "xmlrpc.h"


#ifndef __CYGWIN__
#include <stdint.h>
#endif


typedef XMLRPC_VALUE (*XCommandResp)(char* buffer, int len);

typedef struct _XCmdKeyMap{
	uint8_t cmdkey;
	uint8_t active;
	int fd;
	XCommandResp respcallback;
} XCmdKeyMap;


typedef XMLRPC_VALUE (*XCommandRPC)(XMLRPC_SERVER server, XMLRPC_REQUEST input, void* userData);

typedef struct _XCommandHandler {
  char*   name;
  char*   version;
  XCommandRPC rpccallback;
} XCommandHandler;

void xcommand_server_initialize();
void xcommand_server_print_versions();
void xcommand_server_load_config_libs();
char* xcommand_server_handle_command(void* buffer, int len, int* outlen);
void xcommand_server_handle_client_in(int fd, void* data);
void xcommand_server_handle_server_in(int fd, void* data);
void xcommand_server_initialize_server();
void xcommand_server_register_handler(XCommandHandler *handler);
XMLRPC_VALUE xcommand_server_create_simple_response(char* name, int code, char* desc);
void xcommand_server_register_description(const char* desc_xml);

void xcommand_server_initialize_cmdkeymap();
XCmdKeyMap* xcommand_server_generate_cmdkeymap(int fd);
void xcommand_server_bind_cmdkeymap(XCmdKeyMap* cmdkeymap, XCommandResp cmdresp);
void xcommand_server_release_by_fd(int fd);
void xcommand_server_handle_cmd_response(uint8_t cmdkey, char* buffer, int len);
void xcommand_server_release_cmdkeymap(XCmdKeyMap* cmdkeymap);


#endif



