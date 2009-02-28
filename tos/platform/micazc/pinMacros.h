/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: pinMacros.h,v 1.1.2.2 2007/04/26 22:03:40 njain Exp $
 */

 /* Last Modified: $Date: 2007/04/26 22:03:40 $
  *
  * $Log: pinMacros.h,v $
  * Revision 1.1.2.2  2007/04/26 22:03:40  njain
  * CVS: Please enter a Bugzilla bug number on the next line.
  * BugID: 1100
  *
  * CVS: Please enter the commit log message below.
  * License header modified in each file for MoteWorks_2_0_F release
  *
  * Revision 1.1.2.1  2007/01/12 10:51:55  lwei
  * CVS: Please enter a Bugzilla bug number on the next line.
  * BugID:
  * CVS: Please enter the commit log message below.
  * 1.  Commit the 2.0.E RC1 version for new M2110 M2100 M9100 M4100 Platform, it need to use the new toolchain for 1281 and RF230.
  * CVS: ----------------------------------------------------------------------
  * CVS: Enter Log. Lines beginning with `CVS:' are removed automatically
  * CVS:
  * CVS: Committing in <DIRECTORY NAME>
  * CVS:
  * CVS: Modified Files:
  * CVS: Tag: MoteWorks_2_0_RELEASE_BRANCH
  * CVS: <FILE1> <FILE2> ... <FILEn>
  * CVS: ----------------------------------------------------------------------
  *
  * Revision 1.1  2006/11/16 06:03:04  lwei
  * ----------
  * Added the files for MicazC and RCB230
  *
  * 1. Rearranged the files for MicazC
  * 2. The  files has passed MicazC HP and LP radio testing, and sensor boards testing.
  * ------------
  *
  * Revision 1.2  2006/07/10 22:09:20  rkapur
  * Updating MAIN to 2.1 tree
  *
  * Revision 1.1.2.3  2006/06/20 22:50:07  xyang
  * Bug fix in HPLRF230.h.  Was checking crc and length buth doesn't return 0 when check failed.
  *
  * Revision 1.1.2.1  2006/06/06 21:25:55  xyang
  * RCB230 initial check in
  *
  * Revision 1.1.2.1  2006/06/06 20:21:55  xyang
  * RCB230 Initial Check in
  *
  * Revision 1.1  2006/01/16 00:24:08  xyang
  * Moved debugging file pinMacros.h to platform level
  *
  * Revision 1.1  2006/01/06 03:09:27  xyang
  * Unified MicaZ stack.
  *
  * Revision 1.2  2005/10/09 22:48:20  xyang
  *
  * First Implemenation of async MicaZ LP Mac layer.
  *
  */ 

#ifndef DEBUG_PINS__
#define DEBUG_PINS__

///////////////////////////////////////
// Main Macro Functions
///////////////////////////////////////

#define IO_DEBUG_SET(name)
#define IO_DEBUG_CLR(name)
#define IO_DEBUG_TOGGLE(name)

///////////////////////////////////////
// PIN_ASSIGNMENTS
///////////////////////////////////////

void TOSH_DEBUG_SET_PIN_DIRECTION() { }



#endif

