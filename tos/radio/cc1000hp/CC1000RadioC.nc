/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: CC1000RadioC.nc,v 1.2.2.1 2007/04/27 04:53:49 njain Exp $
 */

/*
 * Authors: Philip Buonadonna
 * Date last modified: $Revision: 1.2.2.1 $
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
    interface RadioPower;
    interface RadioControl;
  }
}
implementation
{
  components CC1000RadioM, CC1000ControlM, HPLCC1000M, 
    RandomLFSR, ADCC, HPLSpiM, TimerC, HPLPowerManagementM, LedsC;

  StdControl = CC1000RadioM;
  Send = CC1000RadioM;
  RadioPower = CC1000RadioM;
  Receive = CC1000RadioM;
  CC1000Control = CC1000ControlM;
  RadioReceiveCoordinator = CC1000RadioM.RadioReceiveCoordinator;
  RadioSendCoordinator = CC1000RadioM.RadioSendCoordinator;
  RadioControl = CC1000ControlM;

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
