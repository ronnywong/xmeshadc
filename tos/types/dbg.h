/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: dbg.h,v 1.1.4.1 2007/04/27 06:07:37 njain Exp $
 */

/*
 *
 * Authors:		David Gay, Philip Levis (from work by Mike Castelle), Nelson Lee
 * Date last modified:  6/25/02
 *
 */

 /*
 *   FILE: dbg.h
 * AUTHOR: pal
 *  DESCR: Run-time configuration of debug output in FULLPC mode. 
 *
 * Debug output determined by DBG environment variable. dbg_modes.h has
 * definitions of the settings possible. One can specify multiple debugging
 * outputs by comma-delimiting (e.g. DBG=sched,timer). Compiling with
 * NDEBUG defined (e.g. -DNDEBUG) will stop all of the debugging
 * output, will remove the debugging commands from the object file.
 *
 * example usage: dbg(DBG_TIMER, "timer went off at %d\n", time);
 *
 */

/**
 * @author David Gay
 * @author Philip Levis (from work by Mike Castelle)
 * @author Nelson Lee
 * @author pal
 */

#ifndef DBG_H
#define DBG_H

#include "dbg_modes.h"
/* We're in FULLPC mode, and debugging is not turned off */
#if defined(PLATFORM_PC) && !defined(NDEBUG)

#include <stdio.h>
#include <stdarg.h>
#include "nido.h"
#include "GuiMsg.h"

typedef struct dbg_mode {
	char* d_name;
	unsigned long long d_mode;
} TOS_dbg_mode_names;

TOS_dbg_mode dbg_modes = 0;
norace bool dbg_suppress_stdout = 0;

static bool dbg_active(TOS_dbg_mode mode) 
{ 
  return (dbg_modes & mode) != 0;
}

static void dbg_add_mode(const char *mode);
static void dbg_add_modes(const char *modes);
static void dbg_init(void);
static void dbg_help(void);
static void dbg_unset();
static void dbg_set(TOS_dbg_mode);

static void dbg(TOS_dbg_mode mode, const char *format, ...) 
{ 
  DebugMsgEvent ev;
  if (dbg_active(mode)) {
    va_list args;
    // XXX MDW - used to be printf 
    va_start(args, format); 
    if (!(mode & DBG_SIM)) {
      vsnprintf(ev.debugMessage, sizeof(ev.debugMessage), format, args);
      sendTossimEvent(NODE_NUM, AM_DEBUGMSGEVENT, tos_state.tos_time, &ev);
    }
    if (! dbg_suppress_stdout) {
      // XXX MDW - used to be vprintf 
      fprintf(stdout, "%i: ", NODE_NUM);
      vfprintf(stdout, format, args);
      va_end(args);
    }
  }    
}

static void dbg_clear(TOS_dbg_mode mode, const char *format, ...) 
{ 
  DebugMsgEvent ev;
  if (dbg_active(mode)) {
    va_list args;
    va_start(args, format);
    if (!(mode & DBG_SIM)) {
      vsnprintf(ev.debugMessage, sizeof(ev.debugMessage), format, args);
      sendTossimEvent(NODE_NUM, AM_DEBUGMSGEVENT, tos_state.tos_time, &ev);
    }
    if (! dbg_suppress_stdout) {
      // XXX MDW - used to be vprintf 
      vfprintf(stdout, format, args);
      va_end(args);
    }
  }    
}

#else 
/* No debugging */

#define dbg(...) { }
#define dbg_clear(...) { }
#define dbg_add_mode(...) { }
#define dbg_add_modes(...) { }
#define dbg_init() { }
#define dbg_help() { }
#define dbg_active(x) (FALSE)

//static inline void dbg(TOS_dbg_mode mode, const char *format, ...) { }
//static inline void dbg_clear(TOS_dbg_mode mode, const char *format, ...) { }
//static inline bool dbg_active(TOS_dbg_mode mode) { return FALSE; }
//static inline void dbg_add_mode(const char *mode) { }
//static inline void dbg_add_modes(const char *modes) { }
//static inline void dbg_init(void) { }
//static inline void dbg_help(void) { }
#endif 

#endif /* DBG_H */
