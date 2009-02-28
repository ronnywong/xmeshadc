/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: CC1000RadioC.nc,v 1.2.2.1 2007/04/27 04:54:53 njain Exp $
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
    command uint16_t GetPower();
  }
}
implementation
{
  components RadioC;

  StdControl = RadioC;
  Send = RadioC;
  RadioPower = RadioC;
  Receive = RadioC;
  CC1000Control = RadioC;
  GetPower = RadioC.GetPower;
  RadioReceiveCoordinator = RadioC.RadioReceiveCoordinator;
  RadioSendCoordinator = RadioC.RadioSendCoordinator;
}
