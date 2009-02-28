/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: RadioCRCPacket.nc,v 1.1.2.2 2007/04/27 05:02:38 njain Exp $
 */

/**
 * Wrapper for GenericComm/AM to interface with the platform specific radio
 * @author Joe Polastre
 */
configuration RadioCRCPacket
{
  provides {
    interface StdControl as Control;
    interface BareSendMsg as Send;
    interface ReceiveMsg as Receive;
    interface RadioControl;
    interface RadioPower;
  }
}
implementation
{
  components RadioControlM, RF230ControlM, RF230RadioC as RadioCRCPacketM; 

  Control = RadioCRCPacketM;
  Send = RadioCRCPacketM.Send;
  Receive = RadioCRCPacketM.Receive;
  RadioControl = RadioControlM;
  RadioPower = RadioCRCPacketM;
  
  RadioControlM.RF230Control -> RF230ControlM;
}



