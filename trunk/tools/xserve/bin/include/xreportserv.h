/**
 * Functions in this file are used to implement HTML reports
 * for a variety of statistics.
 *
 * Report Server prints statistics and data based on a registration mechanism
 * Each module which requires access to the web interface for stats or data
 * registers with the Report Server with a set of call back functions.
 * Every minute, hour, and day the report server calls each of the registered
 * call back methods to produce and HTML report for either stats or data.
 *
 * The Report server is also responsible for calling the node manager for a list
 * of node statistic updates every minute.
 *
 * @file      xreportserv.c
 * @author    Chuck Kring, Rahul Kapur
 * @version   2005/2/19    ckring      Initial version
 * @n         2005/11/1    rkapur      Major rewrite for XServe2
 *
 * Copyright (c) 2004-2005 Crossbow Technology, Inc.   All rights reserved.
 *
 * $Id: xreportserv.h,v 1.9.2.10 2007/03/13 22:31:46 rkapur Exp $
 */

#ifndef _XREPORTSERV_H
#define _XREPORTSERV_H

#include <stdio.h>
#include <time.h>
#include <math.h>
#include <unistd.h>
#include <signal.h>
#include <malloc.h>
#include <memory.h>
#include <stdlib.h>
#include <errno.h>
#include <sys/stat.h>
#include "xutil.h"
#include "xserve_types.h"
#include "xserve_consts.h"
#include "xnodemgr.h"
#include "xparam.h"


void set_next_alarm(time_t cur_time);
void catch_alarm(int sig);
void xreportserv_initialize();
void xreportserv_register_handler(XReportHandler *handler);
void xreportserv_write_html_stats(int report_type);
void write_stats_header( FILE *f, char *title);
void write_stats(int report_type, FILE* f);
void write_stats_footer(FILE *f);
void rotate_file(char *filename, int i);
void xreportserv_write_html_data(int report_type);
void xreportserv_initialize_stats_file();
void xreportserv_initialize_data_file();
void write_data_header( FILE *f, char *title);
void write_data(int report_type, FILE* f);
void xreportserv_write_node_list(xbuffer* buff);


#endif // REPORT_H
