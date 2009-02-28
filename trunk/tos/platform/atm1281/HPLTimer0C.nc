/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: HPLTimer0C.nc,v 1.2.2.2 2007/04/26 00:06:00 njain Exp $
 */
 
// @author Cory Sharp <cssharp@eecs.berkeley.edu>
/***************************************************************************** 
$Log: HPLTimer0C.nc,v $
Revision 1.2.2.2  2007/04/26 00:06:00  njain
CVS: Please enter a Bugzilla bug number on the next line.
BugID: 1100

CVS: Please enter the commit log message below.
License header modified in each file for MoteWorks_2_0_F release

Revision 1.2.2.1  2007/01/12 10:46:05  lwei
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

Revision 1.2  2006/07/10 22:08:54  rkapur
Updating MAIN to 2.1 tree

Revision 1.1.2.1  2006/06/06 21:53:10  xyang
RCB230 Initial Check in

Revision 1.1  2006/01/03 07:46:21  mturon
Initial install of MoteWorks tree

Revision 1.2  2005/03/02 22:45:00  jprabhu
Added Log CVS-Tag

*****************************************************************************/

configuration HPLTimer0C
{
  provides interface StdControl;
  provides interface Clock;
}
implementation
{
  components HPLTimer0, LedsC, NoLeds;

  StdControl = HPLTimer0;
  Clock = HPLTimer0;
  HPLTimer0.Leds -> NoLeds;

}

