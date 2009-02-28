/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: MacControl.nc,v 1.1.4.1 2007/04/27 05:05:35 njain Exp $
 */

/*
 *
 * Authors:		Joe Polastre
 * Date last modified:  $Revision: 1.1.4.1 $
 *
 * Interface for CC1000 specific controls and signals
 */

/*
 *
 * $Log: MacControl.nc,v $
 * Revision 1.1.4.1  2007/04/27 05:05:35  njain
 * CVS: Please enter a Bugzilla bug number on the next line.
 * BugID: 1100
 *
 * CVS: Please enter the commit log message below.
 * License header modified in each file for MoteWorks_2_0_F release
 *
 * Revision 1.1  2006/03/15 10:19:19  pipeng
 * Add cc2420 support for telosb.
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
 * Mac Control Interface
 */
interface MacControl
{
  async command void enableAck();
  async command void disableAck();
  /**
  Enable CC2420 Receiver Hardware Address Decode.
  ************************************************************/
  async command void enableAddrDecode();
  /**
  Disable CC2420 Receiver Hardware Address Decode.
  ************************************************************/
  async command void disableAddrDecode();


}
