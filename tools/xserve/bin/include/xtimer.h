/**
 * Constructs a single timer using the itimers posix interface driven by a given signal
 * All signals used by the single timer must be unique.  Single timer does not check uniqueness
 *
 * @file      xtimer.c
 * @author    Rahul kapur
 * @version   2005/8/01    rkapur      Initial version
 *
 * Copyright (c) 2004 Crossbow Technology, Inc.   All rights reserved.
 *
 * $Id: xtimer.h,v 1.9.2.10 2007/03/13 22:32:42 rkapur Exp $
 */



#ifndef _XTIMER_H_
#define _XTIMER_H_



#include <signal.h>
#include <time.h>
#include <errno.h>
#include "xdebug.h"


#define TIMER_ONE_SHOT 1
#define TIMER_REPEAT 2

#define MAX_XTIMERS 100

#define NSECS_PER_MSEC 1000000

typedef void (*TimerCallback)();
typedef void (*TimerHandler)(int, siginfo_t*, void*);

int xtimer_single_timer_create(timer_t* timer_id, int signo, TimerHandler action);
int xtimer_single_timer_destroy(timer_t* timer_id);
int xtimer_single_timer_start(timer_t* timer_id, int type, int millisecs);
int xtimer_single_timer_stop(timer_t* timer_id);
int xtimer_single_timer_timeLeft(timer_t* timer_id, int* millisecs);

#endif



