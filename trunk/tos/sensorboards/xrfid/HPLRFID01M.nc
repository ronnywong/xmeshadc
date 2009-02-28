/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * Copyright © 2003, University of Washington, Department of Computer Science and Engineering. 
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: HPLRFID01M.nc,v 1.1.4.1 2007/04/27 05:57:21 njain Exp $
 */

/*
 *
 * Authors:		Jason Hill, Alec Woo, David Gay, Philip Levis
 * Date last modified:  6/25/02
 *
 */
/************************************************

Modified By: Waylon Brunette

*************************************************/
/****************************************************************************
* MODULE     : HLPRFID01M
* -PURPOSE   :Hardware Presentation Layer for Mini-M RFID tag reader
* -DETAILS   : Module implementation
*
* 
* -PLATFORM  :MICA Series  
* -OS        :TinyOS-1.x
* -See Also  :
===========================================================================
REVISION HISTORY 
2005.01.05	mm	created
$Log: HPLRFID01M.nc,v $
Revision 1.1.4.1  2007/04/27 05:57:21  njain
CVS: Please enter a Bugzilla bug number on the next line.
BugID: 1100

CVS: Please enter the commit log message below.
License header modified in each file for MoteWorks_2_0_F release

Revision 1.1  2006/01/03 07:48:24  mturon
Initial install of MoteWorks tree

Revision 1.1  2005/03/17 01:53:39  jprabhu
Initial Check of Test app - sources from MMiller 03142005

***************************************************************************/

includes AM;


// needed by skyetek mini protocol as start/stop bytes
#define CR 0x0d  // carriage return
#define LF 0x0a  // line feed

#define MAX_RCV_SIZE 29 // receive buffer limited to 29 bytes  (1 TOS packet data size)

/* This component handles the packet abstraction on the network stack 
*/
module HPLRFID01M {
  provides {
    interface StdControl as Control;
	interface HPLRFID01 as HPLRFID;
//    interface ReceiveVarLenPacket as Receive;
//    interface SendVarLenPacket;

  }
  uses {
    interface ByteComm;
    interface StdControl as ByteControl;
    interface StdControl as UARTControl;
    interface Leds;
  }
}
implementation
{

//#define  INT_DISABLE()    {cli(); outp(0x0, EIMSK);}
//#define  INT_ENABLE()     sei();
//#define  TSW_READ_INT()  {cli();outp(0x80,EIFR);sei();}
#define  TSW_INT_ENABLE() sbi(EIMSK, 7)  // added for rfid if card
#define  TSW_INT_DISABLE() cbi(EIMSK, 7)  // added for rfid if card
#define  RISING_EDGE_INTERRUPT() outp(( (1<<ISC71) | (1<<ISC70) ), EICRB)
#define  LEVEL_INTERRUPT() outp(( (0<<ISC71) | (0<<ISC70) ), EICRB)
#define  TSW_INT_CLEAR() sbi(EIFR, 7) // added for rfid if card

  enum {
    WAITING = 1,
    PACKET_RECEIVE = 2,
    END = 3
  };
  // makes MINI_RESET alias for the mini reset pin
  TOSH_ALIAS_PIN(MINI_RESET, UART_XCK0);


  norace uint8_t rxCount;
  norace uint8_t txCount;
  uint8_t rxLength;
  norace uint8_t txLength;
  uint8_t buffer[MAX_RCV_SIZE];
  norace uint8_t *recPtr;
  norace uint8_t *sendPtr;
  norace uint8_t RXstate;
  norace result_t TXstate;


  /* Initialization of this component */
  command result_t Control.init() {
    recPtr = (uint8_t *)&buffer;
    RXstate = WAITING;
    TXstate = SUCCESS;
    txCount = rxCount = 0;
    // make sure we always read up to the type (which determines length)
    rxLength = offsetof(TOS_Msg, type) + 1;
    dbg(DBG_BOOT, "Packet handler initialized.\n");

    return call ByteControl.init();
  }

  /* Command to control the power of the network stack */
  command result_t Control.start() {
    // apply your power management algorithm
    return call ByteControl.start();
  }

    /* Command to control the power of the network stack */
  command result_t Control.stop() {
    // apply your power management algorithm
    return call ByteControl.stop();
  }
/****************************************************************************
* .resetOn
* -Assert Reset RFID unit
* - 
* - returns	SUCCESS
***************************************************************************/
command result_t HPLRFID.resetOn(){
    TOSH_MAKE_MINI_RESET_OUTPUT();
    TOSH_CLR_MINI_RESET_PIN();
 return SUCCESS;
}
/****************************************************************************
* .resetOff
* -Release Reset RFID unit
* - 
* - returns	SUCCESS
***************************************************************************/
command result_t HPLRFID.resetOff(){
    TOSH_MAKE_MINI_RESET_OUTPUT();
    TOSH_SET_MINI_RESET_PIN();
 return SUCCESS;
}

/****************************************************************************
* .reset
* -Reset RFID unit
* - 
* - returns	SUCCESS
***************************************************************************/
command result_t HPLRFID.reset(){
  {
    uint16_t i;
//---------TSW specific
    TSW_INT_DISABLE();
//--------- 
    TOSH_MAKE_MINI_RESET_OUTPUT();
    TOSH_CLR_MINI_RESET_PIN();
    TOSH_uwait (100);      // hold reset for ~200 us 
    TOSH_SET_MINI_RESET_PIN();
//application must wait - usually call via HAL layer where timer is used       
//    for (i=0;i<100;i++)
//      TOSH_uwait(600);  // mini needs 100 mS to wake up
  }
	return SUCCESS;
}//.reset

  /* Command to transfer a variable length packet */
  command result_t HPLRFID.send(uint8_t* packet, uint8_t numBytes) {
      if (txCount == 0)
      {
        txCount = 1;
	txLength = numBytes + 1;
	sendPtr = packet;
	/* send the first byte */
	if (call ByteComm.txByte(CR))
	  return SUCCESS;
	else
	  txCount = 0;
      }
    return FAIL;
  }

  
  
  task void sendComplete() {
    signal HPLRFID.sendDone((uint8_t*)sendPtr, TXstate);
    txCount = 0;
  }


  task void PacketRcvd()
   {
     uint8_t* tmp;

     dbg(DBG_PACKET, "got packet\n");  

     tmp = signal HPLRFID.receive(recPtr, rxCount);
     if (tmp)
       recPtr = (uint8_t *)tmp;

     RXstate = WAITING;
     rxCount = 0;
   }


  
  /* Byte level component signals it is ready to accept the next byte.
     Send the next byte if there are data pending to be sent */
  async event result_t ByteComm.txByteReady(bool success) {
    if (txCount > 0)
      {
	if (!success)
	  {
	    dbg(DBG_ERROR, "TX_packet failed, TX_byte_failed");
	    TXstate = FAIL;
	    post sendComplete();
	  }
	else if (txCount < txLength)
	  {
	    dbg(DBG_PACKET, "PACKET: byte sent: %x, COUNT: %d\n",
		sendPtr[txCount-1], txCount);

            // txCount is one ahead because it sent a CR as its first message 
	    if (!call ByteComm.txByte(sendPtr[txCount-1]))
	      {  
	        TXstate = FAIL;
	        post sendComplete();
	      } 
	    else
	      txCount++;
	  }
        else if(txCount == txLength)
          {
	    if (!call ByteComm.txByte(CR))
              {
                TXstate = FAIL;
	        post sendComplete();
	      } 
	    else
	      txCount++;
          }
      }
    return SUCCESS;
  }

  async event result_t ByteComm.txDone() {
    if (txCount == txLength + 1)
    {
      TXstate = SUCCESS;
      post sendComplete();
    }
    return SUCCESS;
  }


  
  /* The handles the latest decoded byte propagated by the Byte Level
     component*/
  async event result_t ByteComm.rxByteReady(uint8_t data, bool error,
				      uint16_t strength) {
    dbg(DBG_PACKET, "PACKET: byte arrived: %x, COUNT: %d\n", data, rxCount);
    
    // look for the sync symbol, adjust state and discard symbol
    if (data == LF && RXstate == WAITING)
	  {
	    rxCount = 0;
	    RXstate = PACKET_RECEIVE;
	  }
    else if(RXstate == PACKET_RECEIVE)
      {
	// check to see if ending packet has arrived
	if(data == CR)
	  {
	    RXstate = END;
	    return SUCCESS;
	  }
	
	// Check to ensure you don't overflow the buffer
	if(rxCount < MAX_RCV_SIZE)
	  {
	    recPtr[rxCount++] = data;
	  }
	else
	  {
	    // there has been a problem
	    RXstate = WAITING;
	    rxCount = 0;
	  }
      }
    else if(RXstate == END && data == LF)
      {
        post PacketRcvd();
      }
	
    
    return SUCCESS;
  }
} //HPLRFID01M.nc





