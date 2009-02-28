/**
 * Utility functions for database logging.
 *
 * @file      xdb.c
 * @author    Martin Turon
 *
 * @version   2004/7/29    mturon      Initial version
 *
 * Copyright (c) 2004 Crossbow Technology, Inc.   All rights reserved.
 *
 * $Id: xdbpgres.h,v 1.9.2.10 2007/03/13 22:30:50 rkapur Exp $
 */

#ifndef __XDB_POSTGRES_H__
#define __XDB_POSTGRES_H__

#include <libpq-fe.h>
#include "timestamp.h"
#include "xserve_types.h"
#include "xparam.h"

PGconn *xdbpgres_connect ();
PGconn *xdbpgres_exit    (PGconn *conn);
int     xdbpgres_execute (char *command);

char   *xdbpgres_get_table    ();
void    xdbpgres_set_table    (char *table);
int     xdbpgres_table_exists (char *table);
void   xdbpgres_set_server(char *server);
void   xdbpgres_set_port(char *port);
void   xdbpgres_set_user(char *user);
void   xdbpgres_set_passwd(char *passwd);
void   xdbpgres_set_dbname(char *dbname);


#endif  /* __XDB_H__ */



