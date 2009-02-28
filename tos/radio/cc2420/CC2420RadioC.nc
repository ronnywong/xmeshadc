/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: CC2420RadioC.nc,v 1.2.2.1 2007/04/27 04:56:56 njain Exp $
 */


/*
 * Authors: Joe Polastre
 * Date last modified: $Revision: 1.2.2.1 $
 *
 */

/**
 * @author Joe Polastre
 */

/*
 *
 * $Log: CC2420RadioC.nc,v $
 * Revision 1.2.2.1  2007/04/27 04:56:56  njain
 * CVS: Please enter a Bugzilla bug number on the next line.
 * BugID: 1100
 *
 * CVS: Please enter the commit log message below.
 * License header modified in each file for MoteWorks_2_0_F release
 *
 * Revision 1.2  2006/02/17 03:10:59  xyang
 * provides new RadioControl interface that is platform independent
 *
 * Revision 1.1  2006/01/03 07:45:02  mturon
 * Initial install of MoteWorks tree
 *
 * Revision 1.2  2005/03/02 22:34:16  jprabhu
 * Added Log-tag for capturing changes in files.
 *
 *
 */


configuration CC2420RadioC
{
  provides {
    interface StdControl;
//    interface SplitControl;
    interface BareSendMsg as Send;
    interface ReceiveMsg as Receive;
    interface CC2420Control;
    interface MacControl;
    interface MacBackoff;
    interface RadioPower;
//    interface RadioCoordinator as RadioReceiveCoordinator;
//    interface RadioCoordinator as RadioSendCoordinator;
	interface RadioControl;
  }
}
implementation
{
  components CC2420RadioM, CC2420ControlM, HPLCC2420C, 
    RandomLFSR, 
    TimerC, 
    TimerJiffyAsyncC,
    LedsC, HPLPowerManagementM;

  StdControl = CC2420RadioM;
//  SplitControl = CC2420RadioM;
  Send = CC2420RadioM;
  RadioPower = CC2420RadioM;
  Receive = CC2420RadioM;
  MacControl = CC2420RadioM;
  MacBackoff = CC2420RadioM;
  CC2420Control = CC2420ControlM;
  RadioControl = CC2420ControlM;
//  RadioReceiveCoordinator = CC2420RadioM.RadioReceiveCoordinator;
//  RadioSendCoordinator = CC2420RadioM.RadioSendCoordinator;

  CC2420RadioM.CC2420StdControl -> CC2420ControlM;
  CC2420RadioM.CC2420Control -> CC2420ControlM;
  CC2420RadioM.Random -> RandomLFSR;
  CC2420RadioM.TimerControl -> TimerC.StdControl;
  CC2420RadioM.BackoffTimerJiffy -> TimerJiffyAsyncC.TimerJiffyAsync;
//  CC2420RadioM.InitialTimerJiffy -> TimerC.TimerJiffy[unique("TimerJiffy")];
//  CC2420RadioM.BackoffTimerJiffy -> TimerC.TimerJiffy[unique("TimerJiffy")];
//  CC2420RadioM.AckTimerJiffy -> TimerC.TimerJiffy[unique("TimerJiffy")];
//  CC2420RadioM.DelayRXTimerJiffy -> TimerC.TimerJiffy[unique("TimerJiffy")];
  CC2420RadioM.HPLChipcon -> HPLCC2420C.HPLCC2420;
  CC2420RadioM.HPLChipconFIFO -> HPLCC2420C.HPLCC2420FIFO;

  CC2420ControlM.HPLChipconControl -> HPLCC2420C.StdControl;
  CC2420ControlM.HPLChipcon -> HPLCC2420C.HPLCC2420;
  CC2420ControlM.HPLChipconRAM -> HPLCC2420C.HPLCC2420RAM;

  CC2420RadioM.EnableLowPower ->HPLPowerManagementM.Enable;

  CC2420RadioM.Leds -> LedsC;
}
