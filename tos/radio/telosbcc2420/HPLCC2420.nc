/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: HPLCC2420.nc,v 1.1.4.1 2007/04/27 05:04:28 njain Exp $
 */

/*
 * Authors:		Joe Polastre
 */

/**
 * @author Joe Polastre
 */

/*
 *
 * $Log: HPLCC2420.nc,v $
 * Revision 1.1.4.1  2007/04/27 05:04:28  njain
 * CVS: Please enter a Bugzilla bug number on the next line.
 * BugID: 1100
 *
 * CVS: Please enter the commit log message below.
 * License header modified in each file for MoteWorks_2_0_F release
 *
 * Revision 1.1  2006/03/15 10:19:16  pipeng
 * Add cc2420 support for telosb.
 *
 * Revision 1.1  2006/01/03 07:45:03  mturon
 * Initial install of MoteWorks tree
 *
 * Revision 1.2  2005/03/02 22:34:16  jprabhu
 * Added Log-tag for capturing changes in files.
 *
 *
 */


interface HPLCC2420 {

  async command result_t enableFIFOP();
  async command result_t disableFIFOP();

  async event result_t FIFOPIntr();

  /**
   * Send a command strobe
   * 
   * @return status byte from the chipcon
   */
  async command uint8_t cmd(uint8_t addr);

  /**
   * Transmit 16-bit data
   *
   * @return status byte from the chipcon.  0xff is return of command failed.
   */
  async command uint8_t write(uint8_t addr, uint16_t data);

  /**
   * Read 16-bit data
   *
   * @return 16-bit register value
   */
  async command uint16_t read(uint8_t addr);

  

}
