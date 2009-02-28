/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: TimerMilli.nc,v 1.1.4.1 2007/04/26 21:51:58 njain Exp $
 */

//$Id: TimerMilli.nc,v 1.1.4.1 2007/04/26 21:51:58 njain Exp $
// @author Cory Sharp <cssharp@eecs.berkeley.edu>
/***************************************************************************** 
$Log: TimerMilli.nc,v $
Revision 1.1.4.1  2007/04/26 21:51:58  njain
CVS: Please enter a Bugzilla bug number on the next line.
BugID: 1100

CVS: Please enter the commit log message below.
License header modified in each file for MoteWorks_2_0_F release

Revision 1.1  2006/01/03 07:46:24  mturon
Initial install of MoteWorks tree

Revision 1.2  2005/03/02 22:45:01  jprabhu
Added Log CVS-Tag

*****************************************************************************/

interface TimerMilli
{
  command result_t setPeriodic( int32_t millis );
  command result_t setOneShot( int32_t millis );

  command result_t stop();

  command bool isSet();
  command bool isPeriodic();
  command bool isOneShot();
  command int32_t getPeriod();

  event result_t fired();
}

