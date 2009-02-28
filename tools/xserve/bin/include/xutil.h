
/**
 * Misc util functions
 * Parses to parse command line inputs
 * Assert and Alloc functions
 * Shared Library loading functions
 * Print functions
 * Dynamic buffer management functions
 *
 * @file      xutil.c
 * @author    Rahul kapur
 * @version   2005/8/01    rkapur      Initial version
 *
 * Copyright (c) 2004 Crossbow Technology, Inc.   All rights reserved.
 *
 * $Id: xutil.h,v 1.9.2.10 2007/03/13 22:32:49 rkapur Exp $
 */

#ifndef _XUTIL_H_
#define _XUTIL_H_

#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <dlfcn.h>
#include <dirent.h>
#include <math.h>
#include <ctype.h>
#include "timestamp.h"
#include "xdebug.h"
#include "xserve_types.h"
#include "xserve_consts.h"


int xparse_switch(int argc, char** argv, char* switch_val);
char* xparse_option(int argc, char** argv, char* option_key);
int xassert_fatal(const char *msg, int result);
int xassert_warning(const char *msg, int result);
void *xmalloc(size_t s);
int xlib_is_lib(char* libname);
void* xlib_load_lib(char* libname);
void* xlib_get_func(void* lib_handle,char* func_name);
char* xprint_get_timestamp();
void xprint_print_timestamp();
void xprint_print_ascii(unsigned char *buffer, int len);
void xprint_print_raw(unsigned char *buffer, int len);
xbuffer* xbuffer_new(int pre_alloc);
void xbuffer_destroy(xbuffer* xbuf);
void xbuffer_copy(xbuffer* to, char* from, int length);
void xbuffer_cat(xbuffer* to, xbuffer* from);
void xbuffer_bprintf(xbuffer* to, char* fmt, ...);
int xbuffer_loadfile(xbuffer* xbuf, FILE* file);
void xutil_str_trim(char* str);

#endif
