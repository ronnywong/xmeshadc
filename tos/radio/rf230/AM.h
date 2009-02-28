/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: AM.h,v 1.1.2.2 2007/04/27 05:00:33 njain Exp $
 */

/*
 *
 * Authors:		Jason Hill, David Gay, Philip Levis, Chris Karlof
 * Date last modified:  6/25/02
 *
 */

// Message format


/**
 * @author Jason Hill
 * @author David Gay
 * @author Philip Levis
 * @author Chris Karlof
 */
/*****************************************************************************
$Log: AM.h,v $
Revision 1.1.2.2  2007/04/27 05:00:33  njain
CVS: Please enter a Bugzilla bug number on the next line.
BugID: 1100

CVS: Please enter the commit log message below.
License header modified in each file for MoteWorks_2_0_F release

Revision 1.1.2.1  2007/02/28 00:07:51  xyang
BugID: 1002

Moving rf230 radio stack out of internal

Revision 1.1.2.1  2007/01/12 11:06:58  lwei
CVS: Please enter a Bugzilla bug number on the next line.
BugID:
CVS: Please enter the commit log message below.
1.  Commit the 2.0.E RC1 version for new M2110 M2100 M9100 M4100 Platform, it need to use the new toolchain for 1281 and RF230.
CVS: ----------------------------------------------------------------------
CVS: Enter Log. Lines beginning with `CVS:' are removed automatically
CVS:
CVS: Committing in <DIRECTORY NAME>
CVS:
CVS: Modified Files:
CVS: Tag: MoteWorks_2_0_RELEASE_BRANCH
CVS: <FILE1> <FILE2> ... <FILEn>
CVS: ----------------------------------------------------------------------

Revision 1.1  2006/11/16 06:07:54  lwei
----------
Added the files for MicazC and RCB230

1. Rearranged the files for MicazC
2. The  files has passed MicazC HP and LP radio testing, and sensor boards testing.
------------

Revision 1.2  2006/07/10 22:09:13  rkapur
Updating MAIN to 2.1 tree

Revision 1.1.2.1  2006/06/06 21:25:40  xyang
RCB230 initial check in

Revision 1.1.2.1  2006/06/06 20:21:49  xyang
RCB230 Initial Check in

Revision 1.3  2006/02/17 01:47:26  nxu
make TOS_AM_GROUP extern for XMesh binary

Revision 1.2  2006/01/07 01:14:51  rkapur
Changed AMPromiscous to allow TOS_BCAST_GROUP pass through and defined the var in AM.h

Revision 1.1  2006/01/03 07:46:18  mturon
Initial install of MoteWorks tree

Revision 1.2  2005/03/02 22:40:44  jprabhu
Deleted MICAZOLD compiler directives

*****************************************************************************/
#ifndef AM_H_INCLUDED
#define AM_H_INCLUDED

enum {
  TOS_BCAST_ADDR = 0xffff,
  TOS_UART_ADDR = 0x007e,
};

//RK - change for XJoin
#define TOS_BCAST_GROUP  0xFF
//RK - end change

#ifndef DEF_TOS_AM_GROUP
#define DEF_TOS_AM_GROUP 0x7d
#endif

enum {
  TOS_DEFAULT_AM_GROUP = DEF_TOS_AM_GROUP
};

#ifndef NESC_BUILD_BINARY
uint8_t TOS_AM_GROUP = TOS_DEFAULT_AM_GROUP;
#else
extern uint8_t TOS_AM_GROUP;
#endif

#ifndef TOSH_DATA_LENGTH
#define TOSH_DATA_LENGTH 29
#endif

#ifndef TOSH_AM_LENGTH
#define TOSH_AM_LENGTH 1
#endif

#ifndef TINYSEC_MAC_LENGTH
#define TINYSEC_MAC_LENGTH 4
#endif

#ifndef TINYSEC_IV_LENGTH
#define TINYSEC_IV_LENGTH 4
#endif

#ifndef TINYSEC_ACK_LENGTH
#define TINYSEC_ACK_LENGTH 1
#endif

typedef struct TOS_Msg
{
  /* The following fields are transmitted/received on the radio. */
  uint8_t length;
  uint8_t fcfhi;
  uint8_t fcflo;
  uint8_t dsn;
  uint16_t destpan;
  uint16_t addr;
  uint8_t type;
  uint8_t group;
  int8_t data[TOSH_DATA_LENGTH +3 ];

  /* The following fields are not actually transmitted or received
   * on the radio! They are used for internal accounting only.
   * The reason they are in this structure is that the AM interface
   * requires them to be part of the TOS_Msg that is passed to
   * send/receive operations.
   */
  uint8_t strength;
  uint8_t lqi;
  bool crc;
  uint8_t ack;
  uint16_t time;
} TOS_Msg;

typedef struct TinySec_Msg
{
  uint8_t invalid;
} TinySec_Msg;

typedef struct Ack_Msg
{
  uint8_t length;
  uint8_t fcfhi;
  uint8_t fcflo;
  uint8_t dsn;
  uint8_t fcshi;
  uint8_t fcslo;
} Ack_Msg;

enum {
  // size of the header NOT including the length byte
  MSG_HEADER_SIZE = offsetof(struct TOS_Msg, data) - 1,	  //data offset = 10, - 1 = 9 size of header without length
  // size of the footer
  MSG_FOOTER_SIZE = 2,
  // size of the full packet-including length byte
  MSG_DATA_SIZE = offsetof(struct TOS_Msg, strength) + sizeof(uint16_t), //1+7+5+29+1+2
  // size of the data length
  DATA_LENGTH = TOSH_DATA_LENGTH,
  // position of the length byte
  LENGTH_BYTE_NUMBER = offsetof(struct TOS_Msg, length) + 1,
  // size of MAC Header
  TOS_HEADER_SIZE = 5, 	   //TOSHeader=addr(2)+type(1)+groupid(1)+length(1)
};

typedef TOS_Msg *TOS_MsgPtr;

uint8_t TOS_MsgLength(uint8_t type)
{
#if 0
  uint8_t i;

  for (i = 0; i < MSGLEN_TABLE_SIZE; i++)
    if (msgTable[i].handler == type)
      return msgTable[i].length;
#endif

  return offsetof(TOS_Msg, crc);
}
#endif
