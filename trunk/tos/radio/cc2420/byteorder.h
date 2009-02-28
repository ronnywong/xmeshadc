/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: byteorder.h,v 1.1.4.1 2007/04/27 04:58:12 njain Exp $
 */


#ifndef __BYTEORDER
#define __BYTEORDER

/*
 *
 * $Log: byteorder.h,v $
 * Revision 1.1.4.1  2007/04/27 04:58:12  njain
 * CVS: Please enter a Bugzilla bug number on the next line.
 * BugID: 1100
 *
 * CVS: Please enter the commit log message below.
 * License header modified in each file for MoteWorks_2_0_F release
 *
 * Revision 1.1  2006/01/03 07:45:05  mturon
 * Initial install of MoteWorks tree
 *
 * Revision 1.2  2005/03/02 22:34:16  jprabhu
 * Added Log-tag for capturing changes in files.
 *
 *
 */

inline int is_host_msb()
{
   const uint8_t n[2] = {0,1};
   return ((*(uint16_t*)n) == 1);
}

inline int is_host_lsb()
{
   const uint8_t n[2] = {1,0};
   return ((*(uint16_t*)n) == 1);
}

inline uint16_t toLSB16( uint16_t a )
{
   return is_host_lsb() ? a : ((a<<8)|(a>>8));
}

inline uint16_t fromLSB16( uint16_t a )
{
   return is_host_lsb() ? a : ((a<<8)|(a>>8));
}

#endif
