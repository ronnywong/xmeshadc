/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: CC1000RadioC.nc,v 1.1.4.1 2007/04/26 00:18:13 njain Exp $
 */

/*
 * Authors: Philip Buonadonna
 * Date last modified: $Revision: 1.1.4.1 $
 *
 */

/**
 * @author Philip Buonadonna
 */

configuration CC1000RadioC
{
  provides {
    interface StdControl;
    interface BareSendMsg as Send;
    interface ReceiveMsg as Receive;
    interface CC1000Control;
    interface RadioCoordinator as RadioReceiveCoordinator;
    interface RadioCoordinator as RadioSendCoordinator;
  }
}
implementation
{
  components CC1000RadioIntM as CC1000RadioM, CC1000ControlM, HPLCC1000M, 
    RandomLFSR, ADCC, HPLSpiM, TimerC, HPLPowerManagementM, TinySecC, LedsC;

  StdControl = CC1000RadioM;

  StdControl = TinySecC;
  Send = TinySecC.Send;
  Receive = TinySecC.Receive;
  TinySecC.RadioSend -> CC1000RadioM;
  TinySecC.RadioReceive -> CC1000RadioM;
  TinySecC.TinySecRadio -> CC1000RadioM.TinySecRadio;
  CC1000RadioM.TinySec -> TinySecC.TinySec;

  CC1000Control = CC1000ControlM;
  RadioReceiveCoordinator = CC1000RadioM.RadioReceiveCoordinator;
  RadioSendCoordinator = CC1000RadioM.RadioSendCoordinator;

  CC1000RadioM.CC1000StdControl -> CC1000ControlM;
  CC1000RadioM.CC1000Control -> CC1000ControlM;
  CC1000RadioM.Random -> RandomLFSR;
  CC1000RadioM.ADCControl -> ADCC;
  CC1000RadioM.RSSIADC -> ADCC.ADC[TOS_ADC_CC_RSSI_PORT];
  CC1000RadioM.SpiByteFifo -> HPLSpiM;

  CC1000RadioM.TimerControl -> TimerC.StdControl;
  CC1000RadioM.SquelchTimer -> TimerC.Timer[unique("Timer")];
  CC1000RadioM.WakeupTimer -> TimerC.Timer[unique("Timer")];
  CC1000RadioM.Leds -> LedsC;
  //  CC1000RadioM.SysTime->SysTimeC;

  CC1000ControlM.HPLChipcon -> HPLCC1000M;
  CC1000RadioM.PowerManagement ->HPLPowerManagementM.PowerManagement;
  HPLSpiM.PowerManagement ->HPLPowerManagementM.PowerManagement;
}
