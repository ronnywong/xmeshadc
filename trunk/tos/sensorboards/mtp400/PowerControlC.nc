/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: PowerControlC.nc,v 1.1.4.1 2007/04/27 05:32:24 njain Exp $
 */
 
/*
 *
 *
 * Power Control Component for mtp400ca
 *
 *
 * Authors: Hu Siquan <husq@xbow.com>
 * 
 */

configuration PowerControlC
{
  provides {
    interface SplitControl as PowerControl;
  }
}
implementation
{
  components PowerControlM, TimerC;
  
  PowerControl = PowerControlM;
  
  PowerControlM.PowerStabalizingTimer -> TimerC.Timer[unique("Timer")];
}
