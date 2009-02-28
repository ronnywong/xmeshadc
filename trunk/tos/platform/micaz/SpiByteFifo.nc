/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: SpiByteFifo.nc,v 1.1.4.1 2007/04/26 21:49:37 njain Exp $
 */
 
/***************************************************************************** 
$Log: SpiByteFifo.nc,v $
Revision 1.1.4.1  2007/04/26 21:49:37  njain
CVS: Please enter a Bugzilla bug number on the next line.
BugID: 1100

CVS: Please enter the commit log message below.
License header modified in each file for MoteWorks_2_0_F release

Revision 1.1  2006/01/03 07:46:22  mturon
Initial install of MoteWorks tree

Revision 1.2  2005/03/02 22:45:01  jprabhu
Added Log CVS-Tag

*****************************************************************************/
interface SpiByteFifo
{
  async command result_t writeByte(uint8_t data);
  async command result_t isBufBusy();
  async command uint8_t readByte();
  async command result_t enableIntr();
  async command result_t disableIntr();
  async command result_t initMaster();
  async command result_t txMode();
  async command result_t rxMode();

  async event result_t dataReady(uint8_t data);
}
