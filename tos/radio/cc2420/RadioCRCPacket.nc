/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: RadioCRCPacket.nc,v 1.1.4.1 2007/04/27 04:57:55 njain Exp $
 */

/*
 *
 * $Log: RadioCRCPacket.nc,v $
 * Revision 1.1.4.1  2007/04/27 04:57:55  njain
 * CVS: Please enter a Bugzilla bug number on the next line.
 * BugID: 1100
 *
 * CVS: Please enter the commit log message below.
 * License header modified in each file for MoteWorks_2_0_F release
 *
 * Revision 1.1  2006/01/03 07:45:04  mturon
 * Initial install of MoteWorks tree
 *
 * Revision 1.2  2005/03/02 22:34:16  jprabhu
 * Added Log-tag for capturing changes in files.
 *
 *
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
    interface MacControl;
    interface RadioPower;
  }
}
implementation
{
  components CC2420RadioC as RadioCRCPacketM; 

  RadioPower = RadioCRCPacketM;
  Control = RadioCRCPacketM;
  Send = RadioCRCPacketM.Send;
  Receive = RadioCRCPacketM.Receive;
  MacControl = RadioCRCPacketM;
}



