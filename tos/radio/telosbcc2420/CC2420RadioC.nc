/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: CC2420RadioC.nc,v 1.1.4.1 2007/04/27 05:04:11 njain Exp $
 */

/*
 * Authors: Joe Polastre
 * Date last modified: $Revision: 1.1.4.1 $
 *
 */

/**
 * @author Joe Polastre
 */

configuration CC2420RadioC
{
  provides {
    interface StdControl;
    interface SplitControl;
    interface BareSendMsg as Send;
    interface ReceiveMsg as Receive;
    interface CC2420Control;
    interface MacControl;
    interface MacBackoff;
    interface RadioPower;
    interface RadioCoordinator as RadioReceiveCoordinator;
    interface RadioCoordinator as RadioSendCoordinator;
  }
}
implementation
{
  components CC2420RadioM, CC2420ControlM, HPLCC2420C, 
    RandomLFSR, 
    TimerJiffyAsyncC,
    LedsC;

  StdControl = CC2420RadioM;
  SplitControl = CC2420RadioM;
  Send = CC2420RadioM;
  Receive = CC2420RadioM;
  RadioPower = CC2420RadioM;
  MacControl = CC2420RadioM;
  MacBackoff = CC2420RadioM;
  CC2420Control = CC2420ControlM;
  RadioReceiveCoordinator = CC2420RadioM.RadioReceiveCoordinator;
  RadioSendCoordinator = CC2420RadioM.RadioSendCoordinator;

  CC2420RadioM.CC2420SplitControl -> CC2420ControlM;
  CC2420RadioM.CC2420Control -> CC2420ControlM;
  CC2420RadioM.Random -> RandomLFSR;
  CC2420RadioM.TimerControl -> TimerJiffyAsyncC.StdControl;
  CC2420RadioM.BackoffTimerJiffy -> TimerJiffyAsyncC.TimerJiffyAsync;
  CC2420RadioM.HPLChipcon -> HPLCC2420C.HPLCC2420;
  CC2420RadioM.HPLChipconFIFO -> HPLCC2420C.HPLCC2420FIFO;
  CC2420RadioM.FIFOP -> HPLCC2420C.InterruptFIFOP;
  CC2420RadioM.SFD -> HPLCC2420C.CaptureSFD;

  CC2420ControlM.HPLChipconControl -> HPLCC2420C.StdControl;
  CC2420ControlM.HPLChipcon -> HPLCC2420C.HPLCC2420;
  CC2420ControlM.HPLChipconRAM -> HPLCC2420C.HPLCC2420RAM;
  CC2420ControlM.CCA -> HPLCC2420C.InterruptCCA;

  CC2420RadioM.Leds -> LedsC;
}
