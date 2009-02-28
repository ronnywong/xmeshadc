/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: RadioCRCPacket.nc,v 1.1.4.1 2007/04/27 04:54:15 njain Exp $
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
#ifdef PLATFORM_MICAZ
  components CC2420RadioC as RadioCRCPacketM; 
#else
  components CC1000RadioC as RadioCRCPacketM; 
#endif

  Control = RadioCRCPacketM;
  Send = RadioCRCPacketM.Send;
  Receive = RadioCRCPacketM.Receive;
  RadioPower = RadioCRCPacketM.RadioPower;
#ifdef PLATFORM_MICAZ  
  MacControl = RadioCRCPacketM;
#endif  
}



