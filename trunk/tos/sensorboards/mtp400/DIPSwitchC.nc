/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: DIPSwitchC.nc,v 1.1.4.1 2007/04/27 05:31:59 njain Exp $
 */

/* $Log: DIPSwitchC.nc,v $
/* Revision 1.1.4.1  2007/04/27 05:31:59  njain
/* CVS: Please enter a Bugzilla bug number on the next line.
/* BugID: 1100
/*
/* CVS: Please enter the commit log message below.
/* License header modified in each file for MoteWorks_2_0_F release
/*
 * Revision 1.1  2006/01/05 09:14:56  pipeng
 * move mtp400 from xdev to MoteWorks.
 *
 * Revision 1.2  2005/09/16 10:41:29  husq
 * Update licence and rearange chan order
 * 
 */
/*
 * Description:
 *
 * driver for DIP Switch on mtp400ca
 *
 * PW5 control the power of DIP Switch
 * PB5 indicate the sensor type {RTD, CT} of Channel 1
 * PB6 indicate the sensor type {RTD, CT} of Channel 2
 * PE2 indicate the sensor type {RTD, CT} of Channel 3
 * 
 * 
 * Authors: Hu Siquan <husq@xbow.com>
 *
 * $Id: DIPSwitchC.nc,v 1.1.4.1 2007/04/27 05:31:59 njain Exp $  
 */

configuration DIPSwitchC
{
  provides {
    interface DIP;
  }
}
implementation
{
  components DIPSwitchM, TimerC;
  DIP = DIPSwitchM;
  DIPSwitchM.PowerUpTimer -> TimerC.Timer[unique("Timer")];  
}
