/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: UARTGpsPacket.nc,v 1.1.4.3 2007/04/27 05:42:37 njain Exp $
 */

/*
 *
 * Authors:		Jason Hill, David Gay, Philip Levis
 * Date last modified:  6/25/02
 *
 */

configuration UARTGpsPacket
{
  provides {
    interface StdControl as Control;
    interface BareSendMsg as Send;
    interface ReceiveMsg as Receive;
//    interface I2CSwitchCmds as GpsCmd;
    interface GpsCmd;

  }
}
implementation
{
  components GpsPacket as Packet, UART1 as UART,MicaWbSwitch;

  GpsCmd = Packet.GpsCmd;
  Control = Packet.Control;
  Send = Packet.Send;
  Receive = Packet.Receive;
  
  Packet.ByteControl -> UART;
  Packet.ByteComm -> UART;

  Packet.SwitchControl -> MicaWbSwitch.StdControl;
  Packet.Switch1 -> MicaWbSwitch.Switch[0];
  Packet.SwitchI2W -> MicaWbSwitch.Switch[1];



}
