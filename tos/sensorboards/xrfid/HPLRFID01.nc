/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: HPLRFID01.nc,v 1.1.4.1 2007/04/27 05:57:04 njain Exp $
 */
 
/****************************************************************************
* MODULE     : HPLRFID01.nc
* -PURPOSE   :HPLRFID01 Interface
* -DETAILS   :
*
* 
* -PLATFORM  :MICA Series  
* -OS        :TinyOS-1.x
* -See Also  :
===========================================================================
REVISION HISTORY 
$Id: HPLRFID01.nc,v 1.1.4.1 2007/04/27 05:57:04 njain Exp $
$Log: HPLRFID01.nc,v $
Revision 1.1.4.1  2007/04/27 05:57:04  njain
CVS: Please enter a Bugzilla bug number on the next line.
BugID: 1100

CVS: Please enter the commit log message below.
License header modified in each file for MoteWorks_2_0_F release

Revision 1.1  2006/01/03 07:48:23  mturon
Initial install of MoteWorks tree

Revision 1.1  2005/03/17 01:53:39  jprabhu
Initial Check of Test app - sources from MMiller 03142005

***************************************************************************/
interface HPLRFID01
{
  /**
   * Send <code>numBytes</code> of the buffer <code>data</code>.
   *
   * @return SUCCESS if send request accepted, FAIL otherwise. SUCCCES
   * means that a sendDone should be expected, FAIL means it should
   * not.
   */
  command result_t send(uint8_t* packet, uint8_t numBytes);

  /**
   * Send request completed. The buffer sent and whether the send was
   * successful are passed.
   *
   * @return SUCCESS always.
   */
  event result_t sendDone(uint8_t* packet, result_t success);

  event uint8_t* receive(uint8_t* receivedBuffer, uint8_t bufferLength);
/****************************************************************************
* .reset
* -Reset RFID unit
* - 
* - returns	SUCCESS
***************************************************************************/
command result_t reset();
command result_t resetOn();
command result_t resetOff();

}
