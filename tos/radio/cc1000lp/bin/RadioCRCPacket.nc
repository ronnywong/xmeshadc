/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: RadioCRCPacket.nc,v 1.2.4.1 2007/04/27 04:55:35 njain Exp $
 */

configuration RadioCRCPacket
{
  provides {
    interface StdControl as Control;
    interface BareSendMsg as Send;
    interface ReceiveMsg as Receive;
    interface RadioPower;
  }
}
implementation
{
  components RadioC,
             DefaultEventM,
             CC1KBoundaryM,
             HPLCC1000M,
             RandomLFSR, 
             ADCC, 
             HPLSpiM, 
             TimerC, 
             HPLPowerManagementM, 
             LedsC, 
             TimeSyncService;

  Control = RadioC;
  Send = DefaultEventM.Send;
  Receive = DefaultEventM.Receive;
  RadioPower = RadioC.RadioPower;

  RadioC.TimeStart -> TimeSyncService;
  RadioC.Random -> RandomLFSR;
  RadioC.ADCControl -> ADCC;
  RadioC.RSSIADC -> ADCC.ADC[TOS_ADC_CC_RSSI_PORT];
  RadioC.SpiByteFifo -> HPLSpiM;

  RadioC.Time -> TimeSyncService;
  RadioC.TimerControl -> TimerC.StdControl;
  RadioC.SquelchTimer -> TimerC.Timer[unique("Timer")];
  RadioC.WakeupTimer -> TimerC.RadioTimer;
  RadioC.Leds -> LedsC;
  RadioC.CC1KBoundaryI -> CC1KBoundaryM;

  RadioC.HPLChipcon -> HPLCC1000M;
  RadioC.PowerManagement ->HPLPowerManagementM.PowerManagement;
  HPLSpiM.PowerManagement ->HPLPowerManagementM.PowerManagement;
  RadioC.EnableLowPower ->HPLPowerManagementM.Enable;

  DefaultEventM.SendActual -> RadioC.Send;
  DefaultEventM.ReceiveActual -> RadioC.Receive;
  DefaultEventM.RadioReceiveCoordinatorActual -> RadioC.RadioReceiveCoordinator;
  DefaultEventM.RadioSendCoordinatorActual -> RadioC.RadioSendCoordinator;
}
