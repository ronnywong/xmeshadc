/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: RadioC.nc,v 1.3.4.1 2007/04/27 04:55:26 njain Exp $
 */

component RadioC
{
  uses {
    //from CC1000RadioM
    interface PowerManagement;
    interface StdControl as TimeStart;
    //interface StdControl as CC1000StdControl;
    //interface CC1000Control;
    interface Random;
    interface ADCControl;
    interface ADC as RSSIADC;
    interface SpiByteFifo;
    interface StdControl as TimerControl;
    interface Timer as WakeupTimer;
    interface Timer as SquelchTimer;
    interface Leds;
    interface Time;
    command uint8_t EnableLowPower();
    //from CC1000ControlM
    interface HPLCC1000 as HPLChipcon;
    interface CC1KBoundaryI;
  }
  provides {
    interface StdControl as Control;
    interface BareSendMsg as Send;
    interface ReceiveMsg as Receive;
    interface CC1000Control;
    interface RadioCoordinator as RadioReceiveCoordinator;
    interface RadioCoordinator as RadioSendCoordinator;
    interface RadioPower;
    command result_t EnableRSSI();
    command result_t DisableRSSI();
    command uint8_t GetListeningMode();
    command uint8_t GetTransmitMode();
    command uint16_t GetSquelch();
    command uint16_t GetRxCount();
    command uint16_t GetSendCount();
    command uint16_t GetPower();
    command uint16_t GetPower_check();
    command uint16_t GetPower_send();
    command uint16_t GetPower_receive();
    command uint16_t GetPower_total_sum();
  }
}
