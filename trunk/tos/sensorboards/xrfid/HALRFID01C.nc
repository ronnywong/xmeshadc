/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: HALRFID01C.nc,v 1.1.4.1 2007/04/27 05:56:47 njain Exp $
 */

/*
 *
 * Systemic Realtime Design, LLC.
 * http://www.sysrtime.com
 *
 * Authors:  Qingwei Ma
 *           Michael Li
 *
 * Date last modified:  9/30/04
 *
 */
/****************************************************************************
* MODULE     : HALRFID01C.nc
* -PURPOSE   :RFID Hardware Abstraction Layer configuration 
* -DETAILS   :
*
* 
* -PLATFORM  :MICA Series  
* -OS        :TinyOS-1.x
* -See Also  :
===========================================================================
REVISION HISTORY (c)2005 Crossbow Technology, Inc
$Id: HALRFID01C.nc,v 1.1.4.1 2007/04/27 05:56:47 njain Exp $
$Log: HALRFID01C.nc,v $
Revision 1.1.4.1  2007/04/27 05:56:47  njain
CVS: Please enter a Bugzilla bug number on the next line.
BugID: 1100

CVS: Please enter the commit log message below.
License header modified in each file for MoteWorks_2_0_F release

Revision 1.1  2006/01/03 07:48:23  mturon
Initial install of MoteWorks tree

Revision 1.1  2005/03/17 01:53:39  jprabhu
Initial Check of Test app - sources from MMiller 03142005

***************************************************************************/
//includes SkyeReadMini;
//includes sensorboard;
includes HALRFID;
includes RFIDtags;

configuration HALRFID01C 
{
  provides
  {
    interface StdControl;
    interface SplitControl;
    interface HALRFID;
  }
}

implementation 
{
  components HALRFID01M, TimerC, HPLRFID01C as HPLRFIDC; 

  StdControl = HALRFID01M;
  SplitControl = HALRFID01M;
  HALRFID = HALRFID01M;

//  HALRFID01M.UARTControl -> HPLRFIDC;
  HALRFID01M.TimerControl -> TimerC;
  HALRFID01M.HPLRFID -> HPLRFIDC;
  HALRFID01M.HPLRFIDControl -> HPLRFIDC;
  HALRFID01M.WDT -> TimerC.Timer[unique("Timer")];

}
