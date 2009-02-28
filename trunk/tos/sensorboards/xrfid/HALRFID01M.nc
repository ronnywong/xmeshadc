/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: HALRFID01M.nc,v 1.1.4.1 2007/04/27 05:56:56 njain Exp $
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
* MODULE     : HALRFID01M.nc
* -PURPOSE   :RFID Hardware Abstraction Layer implementation
* -DETAILS   :
*
* 
* -PLATFORM  :MICA Series  
* -OS        :TinyOS-1.x
* -See Also  :
===========================================================================
REVISION HISTORY (c)2005 Crossbow Technology, Inc
$Id: HALRFID01M.nc,v 1.1.4.1 2007/04/27 05:56:56 njain Exp $
$Log: HALRFID01M.nc,v $
Revision 1.1.4.1  2007/04/27 05:56:56  njain
CVS: Please enter a Bugzilla bug number on the next line.
BugID: 1100

CVS: Please enter the commit log message below.
License header modified in each file for MoteWorks_2_0_F release

Revision 1.1  2006/01/03 07:48:23  mturon
Initial install of MoteWorks tree

Revision 1.3  2005/10/04 21:18:20  mmiller
HALRFIDControl.stop asserts RFIDReader RESET to keep off shared UART1 bus

Revision 1.2  2005/05/26 21:15:09  jprabhu
Updates from Matt to support 2 revs of boards

Revision 1.1  2005/03/17 01:53:39  jprabhu
Initial Check of Test app - sources from MMiller 03142005

03mar05	mm	corrected for power management
			todo - change .start & .stop
***************************************************************************/
includes Timer;
includes sensorboard;

//#define SIMULATE 1
#define SIM_SLEEP 1
#define SIM_TAGSEARCH 2
#define SIM_TAGREAD 3


#define  WDT_SEARCH_TIMEOUT  500	//SearchTag response timeout(>300mSec)
#define  WDT_READ_TIMEOUT 500
#define  WDT_WRITE_TIMEOUT 500
#define  WDT_RAW_TIMEOUT 500
#define  WDT_RESET_TIMEOUT 257   //Reader needs 100 mSec after RESET released
#define WDT_TSW_TIMEOUT	300
//-- Hardware macros - belong in sensorboard.h...
#define  TSW_INT_ENABLE() sbi(EIMSK, 7)  // added for rfid if card
#define  TSW_INT_DISABLE() cbi(EIMSK, 7)  // added for rfid if card
#define  RISING_EDGE_INTERRUPT() outp(( (1<<ISC71) | (1<<ISC70) ), EICRB)
#define  LEVEL_INTERRUPT() outp(( (0<<ISC71) | (0<<ISC70) ), EICRB)		//low level
//#define  LEVEL_INTERRUPT() outp(( (0<<ISC71) | (1<<ISC70) ), EICRB)	 //edge
#define  TSW_INT_CLEAR() sbi(EIFR, 7) // added for rfid if card

#ifndef ELP
#define TSW_IGNORE_COUNT 0
#else
#define TSW_IGNORE_COUNT 1	 //entering ELP triggers touch sensor...so skip first interrupt
#endif

#define THERM_PWR_BIT 0x80 //bit 7	of PORTA
#define AC_NEG_BIT 0x08	//bit 3 of PORTE
//--------

#define SLEEP_CMD_SIZE 14

module HALRFID01M {
  provides {
    interface HALRFID;
    interface StdControl;
    interface SplitControl;
  }
  uses {
	interface HPLRFID01 as HPLRFID;
	interface StdControl as HPLRFIDControl;
    interface StdControl as TimerControl;
	interface Timer as WDT;
  }
}

implementation {

  uint8_t gsState;
  uint8_t gbCommBusy;

  struct TagCommand *commandPtr;
  uint8_t commandBuffer[MAX_CMD_SIZE]; 
  uint8_t *cmdPtr;
  uint8_t msgSize;
  bool rawCmd, sleeping;
  uint8_t gTSWCount;
 /*  To put RFIDReader into sleep mode, send this write command to mini
  *  Reference: SkyeRead M1 Reference Guide Section 8.4 (page 28)
  */
  uint8_t RFIDReaderSleepCommand[SLEEP_CMD_SIZE] =
  {'2', '0', '4', '2', '0', '4', '0', '1', '0', '0', '3', '5', 'E', '9'};

/************************************************/
/**** LOCAL FUNCTIONS **************************/
  result_t sleepRFIDReader();

/************************************************/
/****************************************************************************
* wakeupRFIDReader
* - Issues reset to Reader
* - Prefer to just issue a commnand to activate but RESET is safest
* - Does NOT affect gsState
* - returns
***************************************************************************/

  result_t wakeupRFIDReader()
  {
//----------TSW Specific
    TSW_INT_DISABLE();
//-----------
    return(call HPLRFID.reset());
  }
/****************************************************************************
* sleepRFIDReader
* - Issue command to put Reader to sleep
* - Does NOT affect gsState
* - returns status of command send
* - Note: caller can enable monitoring for response or not by setting
*			gsState to SLEEP_PENDING and gbCommBusy=TRUE
***************************************************************************/

result_t sleepRFIDReader()
  {
// Reset RFIDReader
    call HPLRFID.reset(); 
    return(call HPLRFID.send(RFIDReaderSleepCommand, SLEEP_CMD_SIZE) );
  }


/************************************************/
  char getDigit( char c )
  {
    if ( (c >= '0') && (c <= '9') )
      return( c - '0' );
    if ( (c >= 'a') && (c <= 'f') )
      return( c - 'a' + 10 );
    if ( (c >= 'A') && (c <= 'F') )
      return( c - 'A' + 10 );
    return( -1 );
  }

/****************************************************
* Use tagInfo to get index into tag specs
* lookup table (RFID_tags.h)
* return idx pointer to tag type
****************************************************/

  uint8_t getTagSpecs (uint8_t *tagInfo)
  {
    uint8_t i, type, typeExt1, typeExt2, typeExt3; 
    tagType_t *tag = (tagType_t *) tagInfo;

// convert ascii tag types into hex digits
    type   = getDigit (tag->type[0]);
    type <<= 4;
    type  |= getDigit (tag->type[1]); 
    typeExt1   = getDigit (tag->typeExt1[0]);
    typeExt1 <<= 4;
    typeExt1  |= getDigit (tag->typeExt1[1]);
    typeExt2   = getDigit (tag->typeExt2[0]);
    typeExt2 <<= 4;
    typeExt2  |= getDigit (tag->typeExt2[1]);
    typeExt3   = getDigit (tag->typeExt3[0]);
    typeExt3 <<= 4;
    typeExt3  |= getDigit (tag->typeExt3[1]);

// use taginfo in lookup table for tag specs
    for (i=0; i < NUM_TAG_SPEC_TYPES; i++)
    {
      if ((type     == RFIDtags[i].type) && 
          (typeExt1 == RFIDtags[i].typeExt1) &&
          (typeExt2 == RFIDtags[i].typeExt2) &&
          (typeExt3 == RFIDtags[i].typeExt3))
        break;		   
    }
// tag type not found in database
    if (i==NUM_TAG_SPEC_TYPES)
      i=0;

    return(i); 
  }

/******************************************************/
/****************************************************************************
* fSearchTag
* - Build SEARCHTAG command and issue it
* - Does NOT set gbCommBusy flag
* - returns
***************************************************************************/

  result_t fsearchTag (uint8_t cType)
  {
// 0014 is the command to search for a tag (Skyetek Protocol V.2 Section 2.2 and 2.3)
    commandPtr->flag[0]    = '0';
    commandPtr->flag[1]    = '0';
    commandPtr->request[0] = '1';
    commandPtr->request[1] = '4';
// defines the type of tag we are searching for
// 00 = any tag type that can be recognized by mini (Skyetek Protocol V.2 Section 2.4)
    commandPtr->type[0] = '0';
    commandPtr->type[1] = '0'+cType; //convert to ASCII
    cmdPtr = (uint8_t *) commandPtr;
    msgSize = 6;  // the search tag command size = flag + request + type
    return(call HPLRFID.send(cmdPtr, msgSize)); 
  }
/******************************************************/


/************************************************/
/**** CONTROL FUNCTIONS *************************/
/************************************************/
  /****************************************************************************
  * .init
  * -DEPRECATED - please use SplitControl.init 
  * - 
  * - returns
  ***************************************************************************/
  command result_t StdControl.init(){
    return call SplitControl.init();
  }
/************************************************/
task void initDoneTask() {
	signal SplitControl.initDone();
	return;
	}
/****************************************************************************
* default .initDone
* - handle completion of split phase done if client doesnt handle
* - 
* - returns
***************************************************************************/

  default event result_t SplitControl.initDone() {
    return SUCCESS;
  }

  command result_t SplitControl.init()
  {
	gsState = IDLE;
    cmdPtr = commandBuffer;
    commandPtr = (struct TagCommand *)commandBuffer;
    msgSize = 0;
	call HALRFID.disableSW1();
	call TimerControl.init();
	call HPLRFIDControl.init();   //init RFID Uart and low level stuff
	post initDoneTask();
    return SUCCESS;
  }
 
  /****************************************************************************
  * .start
  * -DEPRECATED - please use SplitControl.start 
  * - 
  * - returns
  ***************************************************************************/
  command result_t StdControl.start(){
    return call SplitControl.start();
  }
/************************************************/
task void startDoneTask() {
	signal SplitControl.startDone();
	return;
	}
/****************************************************************************
* default .startDone
* - handle completion of split phase done if client doesnt handle
* - 
* - returns
***************************************************************************/

  default event result_t SplitControl.startDone() {
    return SUCCESS;
  }

/****************************************************************************
* .start
* - Start UART and comm with RFIDReader, Reset reader
* - Reader is awake ready to accept commands
* - returns
***************************************************************************/

  command result_t SplitControl.start()
  {	uint8_t cret;
    cmdPtr = commandBuffer;
    commandPtr = (struct TagCommand *)commandBuffer;
    msgSize = 0;
	call HPLRFIDControl.start();   //init RFID Uart and low level stuff

// Reset RFIDReader
	gbCommBusy = FALSE;	//ignore any spurious comm output due to reset  
	call HPLRFID.reset();
	//start a timer...
//	gsState = WAKEUP_PENDING;
	gsState = START_PENDING;
	if( call WDT.start(TIMER_ONE_SHOT,WDT_RESET_TIMEOUT) != SUCCESS )
		return(FAIL);

    return SUCCESS;
  }

  /****************************************************************************
  * .stop
  * -DEPRECATED - please use SplitControl.stop 
  * - 
  * - returns
  ***************************************************************************/
  command result_t StdControl.stop(){
    return call SplitControl.stop();
  }
/************************************************/
task void stopDoneTask() {
	call HPLRFIDControl.stop();   //stop RFID Uart and low level stuff
	gbCommBusy = FALSE;
	call HPLRFID.resetOn();			//assert RFID reset to keep it off the Shared bus
	signal SplitControl.stopDone();
	return;
	}
/************************************************/
/****************************************************************************
* .stopFailTask
* -  stop (putting RFIDReader to sleep FAILED
* - 
* - returns
***************************************************************************/

task void stopFailTask() {
	gbCommBusy = FALSE;
	signal SplitControl.stopDone();
	return;
	}


/****************************************************************************
* default .stopDone
* - handle completion of split phase done if client doesnt handle
* - 
* - returns
***************************************************************************/

  default event result_t SplitControl.stopDone() {
    return SUCCESS;
  }
/****************************************************************************
* .stop
* - INit RFID Comm, 
* Put RFIDReader in sleep (power down) mode
* and stop RFID UART/Communications
* - 
* - returns
***************************************************************************/

  command result_t SplitControl.stop()
  {
	uint8_t cret;
	gbCommBusy = FALSE;	//ignore any spurious comm output due to reset  
	call HPLRFIDControl.start();   //init RFID Uart and low level stuff-so we can talk to the RFIDReader
	call HPLRFID.reset();
	//wait for reset to end - WDT will post taskSleep to command unit to sleep
//	gsState = SLEEP_RESET;
	gsState = STOP_RESET;
	if( call WDT.start(TIMER_ONE_SHOT,WDT_RESET_TIMEOUT) != SUCCESS )
		return FAIL;

    return SUCCESS;
  }

/****************************************************************************
* .enableRFID
* - enables (allows comm) reader unit. Used when sharing comm bus with other
*	devices
* - Releases RESET line on skyetek RFIDReader
* - returns
***************************************************************************/
command result_t HALRFID.enableRFID(){
    TOSH_SET_MINI_RESET_PIN();
  return SUCCESS;
}//enable
/****************************************************************************
* .disableRFID
* - disables (tri-states comm) reader unit. Used when sharing comm bus with other
*	devices
* - Asserts RESET line on skyetek RFIDReader
* - NOTE: Asserting RESET puts RFIDReader in IDLE (5mA) mode!
* - returns
***************************************************************************/
command result_t HALRFID.disableRFID(){
    TOSH_CLR_MINI_RESET_PIN();
  return SUCCESS;
}

command result_t HALRFID.setSleep(){
	uint8_t cret;
	if(gsState > IDLE)
		return(FAIL);

	call HPLRFIDControl.start();   //start RFID Uart so we can talk to the reader
	gbCommBusy = FALSE;	//ignore any spurious comm output due to reset  
	cret = call WDT.stop();	//abort any timer in-progress
	call HPLRFID.reset();
	//wait for reset process to end - WDT will post taskSleep to put unit to sleep
//debug
  call HALRFID.redOn();
	gsState = SLEEP_RESET;
	cret = call WDT.start(TIMER_ONE_SHOT,WDT_RESET_TIMEOUT);
	return(cret);

}//setSleep

/****************************************************************************
* .sleepDoneTask
* - Finished .setSleep operation
* - RFIDreader is now in SLEEP state
* - Stop Comm port associated with Reader
* - Signal caller
* - returns
***************************************************************************/
task void sleepDoneTask() {
	gbCommBusy = FALSE;
	call HPLRFIDControl.stop();   //stop RFID Uart and low level stuff
	signal HALRFID.doneSleep(SUCCESS);
}
/****************************************************************************
* .sleepFailTask
* - faild .setSleep operation
* - RFIDreader is not in SLEEP state
* - Stop Comm port associated with Reader
* - Signal caller
* - returns
***************************************************************************/
task void sleepFailTask() {
	gbCommBusy = FALSE;
	signal HALRFID.doneSleep(FALSE);
}
/****************************************************************************
* task taskSleep / .stop operation
* - Issue SLEEP command to Reader
*- Caller sets gsState to route split phase response to correct handler
* - 
* - returns
***************************************************************************/
task void taskSleep(){
//  gsState is inherited by caller
	gbCommBusy = TRUE;	  //monitor response
	call HPLRFID.send(RFIDReaderSleepCommand, SLEEP_CMD_SIZE);
	call WDT.start(TIMER_ONE_SHOT,WDT_RAW_TIMEOUT);
	return;
}
/****************************************************************************
* setWakeup* - 
* - 
* - returns
***************************************************************************/

command result_t HALRFID.setWakeup(){
	uint8_t cTemp='A';
	if(gsState > IDLE)
		return(FAIL);
	call HPLRFIDControl.start();   //turnon RFID Uart and low level stuff

	gbCommBusy = FALSE;	//ignore any spurious comm output due to reset  
	call HPLRFID.reset();
	//start timer...
	gsState = WAKEUP_PENDING;
	gbCommBusy = FALSE;	//ignore garbage from RFID
	return(call WDT.start(TIMER_ONE_SHOT,WDT_RESET_TIMEOUT));
}//setPoweron

command uint8_t  HALRFID.getPowerState(){
	switch( gsState )
	{
	case SLEEP:
		return(PWRSTATE_SLEEP);
		break;
	case IDLE:
	case SLEEP_PENDING:
		return(PWRSTATE_IDLE);
		break;
	default:
		return(PWRSTATE_ACTIVE);
	}//gsState
}//getPowerState



/****************************************************************************
* .searchTag
* - Search for in-range tag. Filters for specifed tag type or automatically
*	identifies the tag type	. 
* - Split phase operation - see .doneSearch
* - Auotmatically wakesup Reader if in sleep state
* - returns SUCCESS with Taginofo
*			FAIL (busy,timeout, comm failure)
***************************************************************************/
  command result_t HALRFID.searchTag (uint8_t cTagType)
  { 
	if( gsState != IDLE )
		return FAIL;
	//Issue searchTag command
	if( !fsearchTag(cTagType) )
		return(FAIL);
	gbCommBusy = TRUE;
	//Start WDT
	gsState = TAG_SEARCH;
	return(call WDT.start(TIMER_ONE_SHOT,WDT_SEARCH_TIMEOUT));
	}//.searchTag

/****************************************************************************
* .readTag
* - Read a block of memory from tag.
* - tagInfo specifies the tagtype to read. This was found with searchTag
* - returns
***************************************************************************/
  command result_t HALRFID.readTag( uint8_t* tagInfo, uint8_t tagInfoSize,
                                uint8_t blockIndex)
  {
	if( gsState != IDLE )   //busy doing something else or asleep
		return FAIL;
// 4024 is the command to read from the memory of a tag 
// (Skyetek Protocol V.2 Section 2.2 and 2.3)
    commandPtr->flag[0]    = '4';
    commandPtr->flag[1]    = '0';
    commandPtr->request[0] = '2';
    commandPtr->request[1] = '4';
// tagInfo specifies which tag to read from 
    memcpy (commandPtr->type, tagInfo, tagInfoSize);
// the index of the block of memory to read from
    commandPtr->start[0] = '0' + blockIndex / 16;
    commandPtr->start[1] = '0' + blockIndex % 16;
// always read only 1 block at a time
    commandPtr->length[0] = '0';
    commandPtr->length[1] = '1';
    cmdPtr = (uint8_t *) commandPtr;
    msgSize = tagInfoSize + 8;  // 8 = flag + request + start + length

    if( call HPLRFID.send(cmdPtr, msgSize)) {  
		//Start WDT
		gbCommBusy = TRUE;
		gsState = TAG_READ;
		return(call WDT.start(TIMER_ONE_SHOT,WDT_READ_TIMEOUT));
	} else return(FAIL);
  }

/******************************************************/
  
  command result_t HALRFID.writeTag(uint8_t* tagInfo, uint8_t tagInfoSize, 
                                 uint8_t blockIndex,uint8_t* data, uint8_t dataSize)
  {
	if( gsState != IDLE )   //busy doing something else
		return FAIL;

// 4044 is the command to write to a tag (Skyetek Protocol V.2 Section 2.2 and 2.3)
    commandPtr->flag[0]    = '4';
    commandPtr->flag[1]    = '0';
    commandPtr->request[0] = '4';
    commandPtr->request[1] = '4';
// tagInfo specifies which tag to write to
    memcpy (commandPtr->type, tagInfo, tagInfoSize);
// the index of the block of memory to write to
    commandPtr->start[0]  = '0' + blockIndex / 16;
    commandPtr->start[1]  = '0' + blockIndex % 16;
// always write 1 block at a time 
    commandPtr->length[0]  = '0';
    commandPtr->length[1]  = '1';
// the actual data to write to tag
    memcpy (commandPtr->data, data, dataSize);
    cmdPtr = (uint8_t *) commandPtr;
    msgSize = tagInfoSize + dataSize + 8;  // 8 = flag + request + start + length 
    if( call HPLRFID.send(cmdPtr, msgSize)) {  
		//Start WDT
		gbCommBusy = TRUE;
		gsState = TAG_WRITE;
		return(call WDT.start(TIMER_ONE_SHOT,WDT_WRITE_TIMEOUT));
	} else return(FAIL);

  }

/******************************************************/

  command result_t HALRFID.sendRaw (uint8_t* cmd, uint8_t len)
  {
	if( gsState != IDLE )   //busy doing something else
		return FAIL;
	// copy the command into the global command buffer 
	memcpy (commandPtr, cmd, len); 
	msgSize = len;
	cmdPtr = (uint8_t *) commandPtr;
	if( call HPLRFID.send(cmdPtr, msgSize)) {  
		//Start WDT
		gbCommBusy = TRUE;
		gsState = TAG_RAWCMD;
		return(call WDT.start(TIMER_ONE_SHOT,WDT_RAW_TIMEOUT));
	} else return(FAIL);
}//rawcommand


/****************************************************************************
* fParseResponse
* -Parse the Reader's response and classify message type 
* - 
* - returns Response Type
***************************************************************************/
uint8_t fParseResponse( uint8_t* msg, uint8_t size) {
// response code from sleep command. received before
// going to sleep and just after waking up
    if((msg[0] == '4') && 
       (msg[1] == '2') &&
       (msg[2] == '6') &&
       (msg[3] == '1') &&
       (msg[4] == '1') &&
       (msg[5] == '6')) return(RESP_SLEEPWAKEUP); 
// "14" is response code for a tag found
    if(msg[0] == '1' && msg[1] == '4') return(RESP_TAGSEARCH_OK);
// "24" is response code for successful read from tag
    if(msg[0] == '2' && msg[1] == '4') return(RESP_TAGREAD_OK);
// "44" is response code for successful write to tag
    if(msg[0] == '4' && msg[1] == '4') return(RESP_TAGWRITE_OK);
// "94" is response code for search tag failure
    if(msg[0] == '9' && msg[1] == '4') return(RESP_TAGSEARCH_FAIL);

// here if unclassified response
	return(RESP_UNKNOWN);
}//fParseResponse

/************************************************/
/**** UART1 FUNCTIONS TO MINI *******************/
/****************************************************************************
* .receive
* -Handle received packet from Reader via comm channel 
* - 
* - returns
***************************************************************************/
  event uint8_t* HPLRFID.receive (uint8_t* msg, uint8_t size)
  {
    uint16_t i;
	uint8_t j;
	uint8_t sCurrent;
	uint8_t ResponseType;
	
	if( !gbCommBusy )
		return(msg);	//nothing going on...

// Abort WDT timer - we got a response.  RACE condition?
	call WDT.stop();
	gbCommBusy = FALSE;

	atomic sCurrent = gsState;
// if in RAW Command handling mode, signal client
    if (sCurrent == TAG_RAWCMD)
    {
      gsState = IDLE;
      signal HALRFID.doneRaw (msg, size, SUCCESS); 
	  return(SUCCESS);
    }
//Get the response type
	ResponseType = fParseResponse( msg, size );

	switch(sCurrent) {
	case SLEEP_PENDING:
		if(ResponseType==RESP_SLEEPWAKEUP) {
 	      	gsState = SLEEP; 
			post sleepDoneTask();
			}//RESP_SLEEPWAKEUP
			else  //wrong response...
				{
				gsState = IDLE;
				post sleepFailTask();	//try again??
				}
		break;

	case STOP_PENDING:
		if(ResponseType==RESP_SLEEPWAKEUP) {
 	      	gsState = SLEEP; 
			post stopDoneTask();
			}//RESP_SLEEPWAKEUP
		else {
			gsState = IDLE;
			post stopFailTask();
			}
		break;

	case START_PENDING:
		atomic gsState = IDLE;
	//RFIDReader is now awake and ready for a command (e.g. searchtag, gotosleep
	    post startDoneTask();	
		break;

	case WAKEUP_PENDING: //any kind of response indicates we are awake?
		atomic gsState = IDLE;
	    signal HALRFID.doneWakeup(SUCCESS);
	//RFIDReader is now awake and ready for a command (e.g. searchtag, gotosleep	
		break;

	case TAG_SEARCH:	//scearching for a tag
		switch( ResponseType ) {
		case RESP_TAGSEARCH_OK:
	        j = getTagSpecs (msg+2);  //parse the message based on tag type
			atomic gsState = IDLE;
			// send back data plus tag memory info, offet/remove response code (14)
	        signal HALRFID.doneTagSearch(msg+2, size-2, 
	                 RFIDtags[j].blockSize,
	                 RFIDtags[j].numBlocks, SUCCESS);
		   break;

		case RESP_TAGSEARCH_FAIL:
		default:
			atomic gsState = IDLE;
			signal HALRFID.doneTagSearch(0,0,0,0, FAIL); //null message => failed
			break;
		}//responsetype
		break; //SEARCH_PENDING

	case TAG_READ:	//reading a block of data from tag
		if( ResponseType==RESP_TAGREAD_OK)
      		signal HALRFID.doneTagRead(msg+2, size-2, SUCCESS);
		else
      		signal HALRFID.doneTagRead(0, 0, FAIL);	 //null message -> failed
		atomic gsState = IDLE;
 		break;

	case TAG_WRITE:	//write a block of data to tag
		if( ResponseType==RESP_TAGWRITE_OK)
       		signal HALRFID.doneTagWrite(SUCCESS);
		else
       		signal HALRFID.doneTagWrite(FAIL);	//some error indication
		atomic gsState = IDLE;
 		break;

	case IDLE:	  // IDLE state...bogus message condition
		break;
	default:		
		break;
	}//sCurrent
return(msg); //pass back the buffer

}//.receive
/****************************************************************************
* .sendDone
* - Sent RFID Reader command over comm channel
* - if failed the WDT will time out and notify client
* - returns
***************************************************************************/
  event result_t HPLRFID.sendDone (uint8_t* packet, result_t success)
  {
    return SUCCESS;
  }

/************************************************/
/**** SKYEREAD MINI BUTTON INTERRUPTS ***********/
/************************************************/
/****************************************************************************
* enableSW1
* - 
* - 
* - returns
***************************************************************************/
command result_t HALRFID.enableSW1() {
//--------TSW Specific	- Do NOT enable interrupt
	TSW_INT_DISABLE();
//    RISING_EDGE_INTERRUPT();
    LEVEL_INTERRUPT(); 
	TOSH_uwait(600);
	gTSWCount = TSW_IGNORE_COUNT;
	TSW_INT_CLEAR();
	TSW_INT_ENABLE();  //re-enable the touchsensor activation switch
	return(SUCCESS);
}//enableSW1

/****************************************************************************
* disableSW1
* - 
* - 
* - returns
***************************************************************************/
command result_t HALRFID.disableSW1() {
	TSW_INT_DISABLE();  //disable the touchsensor activation switch
	return(SUCCESS);
	}//disableSW1

task void SW1Asserted()  {
    signal HALRFID.SW1Asserted();
  }

/****************************************************************************
* task SW1Handler
* - Handle level interrupt 
* - wait for level to go away (>100mSec) then process
* - 
* - returns
***************************************************************************/
task void SW1Handler() {
	gsState = TSW_TIMEOUT;
	call WDT.start(TIMER_ONE_SHOT,WDT_TSW_TIMEOUT);
}

TOSH_SIGNAL(SIG_INTERRUPT7) {
//  TOSH_INTERRUPT(SIG_INTERRUPT7)
  	//make it a synchronous event
	TSW_INT_CLEAR(); //clear the interrupt flag
 	TSW_INT_DISABLE();  //disable interrupt - level so continuously interrupting
	post SW1Handler();	 //handle it synchronously
	return;
  }//interrupt
/******************************************************/

  command result_t HALRFID.greenOn ()
  {
    TOSH_CLR_THERM_PWR_PIN();
    return SUCCESS;
  }
/******************************************************/

  command result_t HALRFID.greenOff ()
  {
    TOSH_SET_THERM_PWR_PIN();
    return SUCCESS;
  }

  command result_t HALRFID.greenToggle ()
  {	uint8_t cPort;
    cPort = inp(PORTA);
	if( cPort & THERM_PWR_BIT )
	    TOSH_CLR_THERM_PWR_PIN();
	      else
	    TOSH_SET_THERM_PWR_PIN();
    return SUCCESS;
  }

/******************************************************/

  command result_t HALRFID.redOn ()
  {
    TOSH_CLR_AC_NEG_PIN();
    return SUCCESS;
  }

/******************************************************/

  command result_t HALRFID.redOff ()
  {
    TOSH_SET_AC_NEG_PIN();
    return SUCCESS;
  }

  command result_t HALRFID.redToggle ()
  {	uint8_t cPort;
    cPort=inp(PORTE);
	if( cPort & AC_NEG_BIT )
	    TOSH_CLR_AC_NEG_PIN();
	      else
	    TOSH_SET_AC_NEG_PIN();
    return SUCCESS;
  }

/****************************************************************************
* WDT.fired
* - Watch Dog timed out - RFID reader did not respond. Handle Error condition
* - 
* - returns
***************************************************************************/

event result_t WDT.fired(){
	uint8_t sCurrent;
	result_t cRet = SUCCESS;

	atomic sCurrent = gsState;
//debug
  call HALRFID.redOff ();

	switch( sCurrent ) {

	case STOP_RESET:
		atomic gsState = STOP_PENDING;
		cRet = post taskSleep();
		return(cRet);
		break;

	case STOP_PENDING:
		return(post stopDoneTask());	
		break;

	case SLEEP_RESET: //Finished RESETing reader, now issue SLEEP cmnd
		atomic gsState = SLEEP_PENDING;
		if( post taskSleep() == SUCCESS)
			return SUCCESS;
		//here if can't post task
		signal HALRFID.doneSleep(FAIL);
		break;

	case START_PENDING:	 //timeout - reset doesnot gen response
	//RFIDReader is now awake and IDLE ready for a command (e.g. searchtag, gotosleep	
		post startDoneTask();
		break;
	case WAKEUP_PENDING:
		atomic gsState = IDLE;
	    signal HALRFID.doneWakeup(SUCCESS);  //reset has finished
	//RFIDReader is now awake and IDLE ready for a command (e.g. searchtag, gotosleep	
		break;
//------------ FOLLOWING ARE FAIL/ERROR CONDITIONS - gsState enters IDLE
	case SLEEP_PENDING:
		post sleepFailTask();
		break;

	case TAG_SEARCH:
		signal HALRFID.doneTagSearch(0,0,0,0,FAIL); //null message => failed
		break;

	case TAG_READ:
      	signal HALRFID.doneTagRead(0, 0, FAIL);	 //null message -> failed
		break;

	case TAG_WRITE:	//write a block of data to tag
       	signal HALRFID.doneTagWrite(FAIL);	//some error indication
		break;

	case TAG_RAWCMD:
		signal HALRFID.doneRaw(0,0,FAIL);

	case TSW_TIMEOUT:
		if( gTSWCount-- > 0) {
			TSW_INT_CLEAR();
			TSW_INT_ENABLE();  //re-enable the touchsensor activation switch
			return SUCCESS;			//ignore 1st interrupts after power down....
			}
		post SW1Asserted();	  //still asserted low
		gsState = SLEEP;
		return SUCCESS;
		break;

	default:
		break;

	}//switch
// force state to IDLE
 	gsState = IDLE;	
return cRet;
}//event

default  event result_t HALRFID.doneTagSearch(uint8_t *tagInfo, uint8_t tagInfoSize, 
                          uint8_t blockSize, uint8_t numBlocks, result_t Result){return SUCCESS;}
default event result_t HALRFID.doneTagRead (uint8_t *data, uint8_t size, result_t Result){return SUCCESS;}
default  event result_t HALRFID.doneTagWrite(result_t Result) { return SUCCESS; }
default  event result_t HALRFID.doneRaw (uint8_t *reply, uint8_t len, result_t Result)	{return SUCCESS; }
default  event result_t HALRFID.SW1Asserted (){}
default event result_t HALRFID.doneSleep(result_t Result){return SUCCESS;}
default event result_t HALRFID.doneWakeup(result_t Result){return SUCCESS;}

} //HALRFID01M.nc


