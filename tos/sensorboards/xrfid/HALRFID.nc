/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: HALRFID.nc,v 1.1.4.1 2007/04/27 05:56:31 njain Exp $
 */
 
/*
 *
 * Systemic Realtime Design, LLC.
 * http://www.sysrtime.com
 *
 * Authors:  Qingwei Ma
 *           Michael Li
 *
 * Date last modified:  9/30/04
 *
 */
/****************************************************************************
* MODULE     : HALRFID.nc
* -PURPOSE   :RFID Hardware Abstraction Layer Interface
* -DETAILS   :
*
* 
* -PLATFORM  :MICA Series  
* -OS        :TinyOS-1.x
* -See Also  :
===========================================================================
REVISION HISTORY (c)2005 Crossbow Technology, Inc
$Id: HALRFID.nc,v 1.1.4.1 2007/04/27 05:56:31 njain Exp $
$Log: HALRFID.nc,v $
Revision 1.1.4.1  2007/04/27 05:56:31  njain
CVS: Please enter a Bugzilla bug number on the next line.
BugID: 1100

CVS: Please enter the commit log message below.
License header modified in each file for MoteWorks_2_0_F release

Revision 1.1  2006/01/03 07:48:22  mturon
Initial install of MoteWorks tree

Revision 1.1  2005/03/17 01:53:39  jprabhu
Initial Check of Test app - sources from MMiller 03142005

***************************************************************************/

interface HALRFID 
{

/************************************************/
/**** SEARCH TAG INTERFACE **********************/
/************************************************/

  /* 
   *  Request Mini to find a tag.
   *  If Mini doesn't find a tag by "timeout" seconds,
   *  then Mini gives up and miniDone is signalled with a TIMEOUT result.
   *  If another searchTag command is issued while a 
   *  previous command timeout has not fired, searchTag 
   *  will return FAIL. 
   *  Also returns FAIL if a previous command is still being processed.
   *
   *  "0" seconds is a valid timeout. If no tag 
   *  is found immediately, then tagSearchTimeout is 
   *  signalled.
   *
   *  Result will be returned by event tagFound 
   */
  command result_t searchTag (uint8_t Tagtype);

  /*
   *  Event handler as a tag is found. 
   *  tagInfo is the tag type and TID of the tag found.
   *  tagInfoSize is the size of tagInfo.
   *  blockSize is the size in bytes of 1 block of memory on the tag.
   *  numBlocks is the number of blocks of memory.
   */
//  event result_t tagFound(uint8_t *tagInfo, uint8_t tagInfoSize, 
//                          uint8_t blockSize, uint8_t numBlocks);
  event result_t doneTagSearch(uint8_t *tagInfo, uint8_t tagInfoSize, 
                          uint8_t blockSize, uint8_t numBlocks, result_t Result);


/************************************************/
/**** WRITE TAG INTERFACE ***********************/
/************************************************/

  /* 
   *  Write a data block to a specified tag.
   *  Result will be returned by event tagWriteDone.
   *  TagInfo includes tag type and TID which are get by calling searchTag;
   *  blockIndex is the index of data block to be written;
   *  data is the data to write to the block.
   *  dataSize is the number of data bytes writing to tag.
   *  Return FAIL if a previous command is still being processed.
   */
  command result_t writeTag (uint8_t* tagInfo, uint8_t tagInfoSize,
                             uint8_t blockIndex,uint8_t* data, uint8_t dataSize);

  /*  Event handler as writing to a tag is done. */
//  event result_t tagWriteDone();
  event result_t doneTagWrite(result_t Result);

/************************************************/
/**** READ TAG INTERFACE ************************/
/************************************************/
  
  /*  
   *  Read a data block from a specified tag.
   *  Result will be returned by event tagDataReady. 
   *  tagInfo includes tag type and TID which are get by calling searchTag;
   *  blockIndex is the index of data block to be written.
   *  Return FAIL if a previous command is still being processed.
   */
  command result_t readTag (uint8_t* tagInfo, uint8_t tagInfoSize,
                            uint8_t blockIndex);  

  /*  Event handler as tag block data is ready to read. */
  event result_t doneTagRead(uint8_t *data, uint8_t size, result_t Result); 
command result_t setSleep();
event result_t doneSleep(result_t Result);

command result_t setWakeup();
event result_t doneWakeup(result_t Result);
command uint8_t getPowerState();
/****************************************************************************
* .enableRFID
* - enables (allows comm) reader unit. Used when sharing comm bus with other
*	devices
* - Releases RESET line on skyetek RFIDReader
* - returns
***************************************************************************/
command result_t enableRFID();
/****************************************************************************
* .disableRFID
* - disables (tri-states comm) reader unit. Used when sharing comm bus with other
*	devices
* - Asserts RESET line on skyetek RFIDReader
* - returns
***************************************************************************/
command result_t disableRFID();


/************************************************/
/**** BUTTON INTERFACE **************************/
/************************************************/

command result_t greenOn ();
command result_t greenOff ();
command result_t redOn ();
command result_t redOff ();
command result_t greenToggle();
command result_t redToggle();

command result_t enableSW1();
command result_t disableSW1();

  /*  Event handler as SW1 is clicked. */
event result_t SW1Asserted();

/************************************************/
/**** MISCELLANEOUS INTERFACE *******************/
/************************************************/

  /*  
   *  Send a raw command to the Mini
   *  Return FAIL if a previous command is still being processed.
   */
  command result_t sendRaw (uint8_t *cmd, uint8_t len); 

  /* Event handler when Mini replies to raw command */ 
  event result_t doneRaw (uint8_t *reply, uint8_t len,result_t result); 

  
}

