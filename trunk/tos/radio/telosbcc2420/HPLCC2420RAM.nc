/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: HPLCC2420RAM.nc,v 1.1.4.1 2007/04/27 05:05:18 njain Exp $
 */

/*
 * Authors:		Joe Polastre
 */

/**
 * @author Joe Polastre
 */

/*
 *
 * $Log: HPLCC2420RAM.nc,v $
 * Revision 1.1.4.1  2007/04/27 05:05:18  njain
 * CVS: Please enter a Bugzilla bug number on the next line.
 * BugID: 1100
 *
 * CVS: Please enter the commit log message below.
 * License header modified in each file for MoteWorks_2_0_F release
 *
 * Revision 1.1  2006/03/15 10:19:18  pipeng
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


interface HPLCC2420RAM {

  /**
   * Transmit data to RAM
   *
   * @return SUCCESS if the request was accepted
   */
  async command result_t write(uint16_t addr, uint8_t length, uint8_t* buffer);

  async event result_t writeDone(uint16_t addr, uint8_t length, uint8_t* buffer);

  /**
   * Read data from RAM
   *
   * @return SUCCESS if the request was accepted
   */
  async command result_t read(uint16_t addr, uint8_t length, uint8_t* buffer);

  async event result_t readDone(uint16_t addr, uint8_t length, uint8_t* buffer);
  

}
