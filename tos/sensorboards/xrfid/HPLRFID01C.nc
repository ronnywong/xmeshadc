/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: HPLRFID01C.nc,v 1.1.4.1 2007/04/27 05:57:13 njain Exp $
 */
 
/*****************************************************
Modified By: Waylon Brunette
$Log: HPLRFID01C.nc,v $
Revision 1.1.4.1  2007/04/27 05:57:13  njain
CVS: Please enter a Bugzilla bug number on the next line.
BugID: 1100

CVS: Please enter the commit log message below.
License header modified in each file for MoteWorks_2_0_F release

Revision 1.1  2006/01/03 07:48:24  mturon
Initial install of MoteWorks tree

Revision 1.1  2005/03/17 01:53:39  jprabhu
Initial Check of Test app - sources from MMiller 03142005


*************************************************/


configuration HPLRFID01C
{
  provides {
    interface StdControl as Control;
    interface HPLRFID01 as HPLRFID;
  }
}
implementation
{
  components HPLRFID01M as HPLRFIDM, UART1;

  Control = HPLRFIDM.Control;
  HPLRFID = HPLRFIDM;
//  SendVar = Packet.SendVarLenPacket;
  
  HPLRFIDM.ByteControl -> UART1;
  HPLRFIDM.ByteComm -> UART1;
}
