/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: SkyeReadMini.h,v 1.1.4.1 2007/04/27 05:57:38 njain Exp $
 */

/****************************************************************************
* MODULE     : HALRFID.h
* -PURPOSE   :RFID Reader Driver definitions
* -DETAILS   :
*
* 
* -PLATFORM  :MICA Series  
* -OS        :TinyOS-1.x
* -See Also  :
===========================================================================
REVISION HISTORY 
yy.mm.dd	who	created
$Log: SkyeReadMini.h,v $
Revision 1.1.4.1  2007/04/27 05:57:38  njain
CVS: Please enter a Bugzilla bug number on the next line.
BugID: 1100

CVS: Please enter the commit log message below.
License header modified in each file for MoteWorks_2_0_F release

Revision 1.1  2006/01/03 07:48:24  mturon
Initial install of MoteWorks tree

Revision 1.1  2005/03/17 01:53:39  jprabhu
Initial Check of Test app - sources from MMiller 03142005

***************************************************************************/

#ifndef HALRFID_H
#define HALRFID_H

#define CONVERT_TO_RAW_DATA(data) data-2
#define CONVERT_TO_RAW_SIZE(size) size+2

typedef struct TagCommand
{
  uint8_t flag[2];
  uint8_t request[2];
  uint8_t type[2];
  uint8_t TID[16];
  uint8_t start[2];
  uint8_t length[2];
  uint8_t data[8];
} TagCommand;


enum {
  MAX_CMD_SIZE = sizeof(TagCommand),   // maximum command length (writing 1 block at a time)
  MAX_RSP_SIZE = 20,                   /* maximum response length 2 bytes for response code + 18 bytes for TID */
};

enum { //sSTATES
	SLEEP,
	SLEEP_RESET,
	SLEEP_PENDING,
	WAKEUP_PENDING,
	IDLE,
	TAG_SEARCH,
	SEARCH_PENDING,
	TAG_READ,
	TAG_WRITE,
	TAG_RAWCMD
};

enum { //response types
	RESP_SLEEPWAKEUP,
	RESP_TAGSEARCH_OK,
	RESP_TAGREAD_OK,
	RESP_TAGWRITE_OK,
	RESP_TAGSEARCH_FAIL,
	RESP_UNKNOWN
};

enum {
 	PWRSTATE_SLEEP,
	PWRSTATE_IDLE,
	PWRSTATE_ACTIVE
};

#endif
