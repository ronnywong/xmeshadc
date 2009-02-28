/*
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: Ident.h,v 1.1.4.1 2007/04/27 06:01:09 njain Exp $
 */

// @author Cory Sharp <cssharp@eecs.berkeley.edu>

#ifndef _H_Ident_h
#define _H_Ident_h

enum
{
  IDENT_MAX_PROGRAM_NAME_LENGTH = 17,
};

typedef struct
{
  uint32_t unix_time;  //the unix time that the program was compiled
  uint32_t user_hash;  //a hash of the username and hostname that did the compile
  char program_name[IDENT_MAX_PROGRAM_NAME_LENGTH];  //name of the installed program
} Ident_t;

//  Don't use the program name string because passing quotes in through nesc
//  seems to be broken again.
//#ifndef IDENT_PROGRAM_NAME
//#define IDENT_PROGRAM_NAME "(none)"
//#endif

#ifndef IDENT_PROGRAM_NAME_BYTES
#define IDENT_PROGRAM_NAME_BYTES 0
#endif

#ifndef IDENT_USER_HASH
#define IDENT_USER_HASH 0
#endif

#ifndef IDENT_UNIX_TIME
#define IDENT_UNIX_TIME 0
#endif

static const Ident_t G_Ident = {
  unix_time : IDENT_UNIX_TIME,
  user_hash : IDENT_USER_HASH,
  program_name : { IDENT_PROGRAM_NAME_BYTES },
};


#endif//_H_Ident_h

