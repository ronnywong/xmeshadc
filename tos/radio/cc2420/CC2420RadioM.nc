/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: CC2420RadioM.nc,v 1.7.2.1 2007/04/27 04:57:04 njain Exp $
 */

/*
 * Author: Xin Yang (xyang@xbow.com)
 * Date:   11/05/05
 */

/**
 * CC2420RadioM.nc - Main radio module for both lp & hp micaz stack
 *
 * CC2420RadioM (Ack Version)
 * Provides standard CC2420 Radio stack for IEEE 802.15.4 with "manual" software
 * message acknowledgement. Permits promiscuous listening in reliable-route 
 * applications plus message acknowledgement. Functional equivalent to MICA2 
 * CC1000RadioAck services.
 *
 * <pre>
 *	$Id: CC2420RadioM.nc,v 1.7.2.1 2007/04/27 04:57:04 njain Exp $
 * </pre>
 * 
 * @author Joe Polastre
 * @author Matt Miller
 * @author Alan Broad
 * @author Xin Yang
 * @author Satoru 
 * @date November 13 2005
 */

includes byteorder;

module CC2420RadioM {
  provides {
    interface StdControl;
    interface BareSendMsg as Send;
    interface ReceiveMsg as Receive;
    interface RadioCoordinator as RadioSendCoordinator;
    interface RadioCoordinator as RadioReceiveCoordinator;
    interface MacControl;
    interface MacBackoff;
    interface RadioPower;

    //XIN:
    command result_t checkCCA (uint32_t t);
    command result_t setImmediateSendMode (result_t option);
    command result_t isImmediateSendMode ();
    async command result_t stopCCA ();
    
    async command result_t asyncSend (uint8_t * bufferPtr);
    command result_t checkSFD (uint32_t t);
  }
  
  uses {
    interface StdControl as CC2420StdControl;
    interface CC2420Control;
    interface HPLCC2420 as HPLChipcon;
    interface HPLCC2420FIFO as HPLChipconFIFO;
    interface StdControl as TimerControl;

    interface TimerJiffyAsync as BackoffTimerJiffy;
    interface Random;
    interface Leds;
    command uint8_t EnableLowPower ();	//change to define

    //XIN:
    async event TOS_MsgPtr asyncReceive (TOS_MsgPtr pBuf);
    async event void shortReceived();
  }
}

implementation {

#include "pinMacros.h"

  /*===Preprocessor Definitions ===============================================*/

  // XIN:
  // RSSI Threshold after front end gain.
  
//#define LP_RSSI 0xE280		//-30dbm
#define LP_RSSI 0xE080		//-32dbm
//#define LP_RSSI 0xDC80		//-36dbm
//#define LP_RSSI 0xD880		//-40dbm
//#define LP_RSSI 0xD8C8		//-40dbm
//#define LP_RSSI 0xCE80		//-50dbm
//#define LP_RSSI 0xC480		//-60dbm
//#define LP_RSSI 0xBA80		//-70dbm
//#define LP_RSSI 0xB080		//-80dbm
//#define LP_RSSI 0xA680		//-90dbm
//#define LP_RSSI 0xA080		//-96dbm

  //rssi free sniff
#define LP_MDMCTRL0 \
	((CC2420_ADDRDECODE << CC2420_MDMCTRL0_ADRDECODE) | \
    (2 << CC2420_MDMCTRL0_CCAHIST) | (2 << CC2420_MDMCTRL0_CCAMODE)  | \
    (1 << CC2420_MDMCTRL0_AUTOCRC) | (2 << CC2420_MDMCTRL0_PREAMBL))

  //number of backoffs during send for a clear channel before giving up
#define SEND_RETRY_COUNT 8


  //UART DEBUGGING
  //#define DBG_UART_SENDDONE
  
  #ifdef DBG_UART_SENDDONE
  #define DBG_PKT 1
  #define SO_DEBUG 1
  #include "SOdebug.h"
  #endif

  /*===Componenet State =======================================================*/

  enum {
    DISABLED_STATE = 0,
    IDLE_STATE,
    PRE_TX_STATE,
    TX_STATE,
    POST_TX_STATE,
    RAW_TX_STATE,
 //   RX_STATE,	//unused
 //   RX_ACK_STATE,	//unused
 //   POWER_DOWN_STATE,	//unused
    TIMER_IDLE = 0,
    TIMER_INITIAL,
    TIMER_BACKOFF,
    TIMER_ACK,
    TIMER_SNIFF
  };

  /*===Norace variables =======================================================*/
  
  norace uint8_t stateTimer;
  norace bool bAckEnable;	//not changed when running
  norace bool bAckManual;	//not changed when running
  
  //send set this in sync context, tryToSend() sets this in async context
  //send can not happen while tryToSend is occuring.
  norace uint8_t cnttryToSend;  
  
  /*===Component variables ====================================================*/
  
  uint8_t RadioState;
  uint8_t bRxBufLocked;
  uint8_t currentDSN;
  uint16_t txlength;
  uint16_t rxlength;
  TOS_MsgPtr txbufptr;		// pointer to transmit buffer
  TOS_MsgPtr rxbufptr;		// pointer to receive buffer
  TOS_Msg RxBuf;		// save received messages
  

  //XIN:
  result_t gImmedSendDone;
  volatile result_t gStopCCA;	// check
  volatile result_t gSniffDone;	// check

  // XXX-PB:
  // Here's the deal, the mica (RFM) radio stacks used TOS_LOCAL_ADDRESS
  // to determine if an L2 ack was reqd.  This stack doesn't do L2 acks
  // and, thus doesn't need it.  HOWEVER, some set-mote-id versions
  // break if this symbol is missing from the binary.
  // Thus, I put this LocalAddr here and set it to TOS_LOCAL_ADDRESS
  // to keep things happy for now.
  volatile uint16_t LocalAddr;

  /*===Local Function Parameters ==============================================*/

  inline void immedPacketSent ();
  inline void immedPacketRcvd ();
  void fSendAborted ();
  result_t sendPacket ();
  void tryToSend ();
  uint8_t fTXPacket (uint8_t len, uint8_t * pMsg);

  /*===Tasks =================================================================*/
  
  task void PacketRcvd ();
  task void PacketSent ();
  
  /*===Jiffy Timer Functions ==================================================*/

  /* XIN:
   * added feature: If 0 signal immediately, IF 0xffff fail 
   *
   *    .fired is usually the second phase after send.send returns.  
   * However we can not wait for this split, we have to signal 
   * jiffer.fired() in the first phase.  Since anything jiffy.fired() 
   * returns is not a return value for the first phase, the caller 
   * who called send.send must ignore this.
   *
   * Another effect of making split phase into single phase is that.  
   * Before, Send.send returns before send.sendDone.  Now send.Send
   * returns after Send.sendDone. This must be understood and dealt with.
   *
   */

  inline result_t setInitialTimer (uint16_t jiffy) {
    stateTimer = TIMER_INITIAL;
    if (jiffy == NOBACKOFF) {
      // Discard return value from .fired, not realted to this phase
      signal BackoffTimerJiffy.fired ();
      return SUCCESS;
    } else {
      //assume never fail on initial timer
      return call BackoffTimerJiffy.setOneShot (jiffy);
    }
  }

  inline result_t setBackoffTimer (uint16_t jiffy) {
    stateTimer = TIMER_BACKOFF;

    if (jiffy == FAILONBACKOFF) {
      return FAIL;
    } else {
      return call BackoffTimerJiffy.setOneShot (jiffy);
    }
  }

  inline result_t setSniffTimer (uint16_t jiffy) {
    stateTimer = TIMER_SNIFF;
    return call BackoffTimerJiffy.setOneShot (jiffy);
  }

  inline result_t setAckTimer (uint16_t jiffy) {
    stateTimer = TIMER_ACK;
    return call BackoffTimerJiffy.setOneShot (jiffy);
  }

  /*===Send Handlers ==========================================================*/
  
  /**
   * Flush the CC2420 radio buffer. Load TXFIFO with 15.4 MACPDU. 
   * Call and return sendPacket(). Assumes CC2420 RXInterrupt disabled. 
   * 
   * @param len		length of buffer to be pushed into tx fifo
   * @param pMsg	pointer to the packet
   *
   * @return result_t what ever sendPacket() returns
   */
  result_t fTXPacket (uint8_t len, uint8_t * pMsg) {
	  
	uint8_t lenToWrite;
	  
    //Flush CC2420 radio TX buffer
    if (!(call HPLChipcon.cmd (CC2420_SFLUSHTX))) return (FAIL);
    
    //Load buffer 
    //if (!(len = call HPLChipconFIFO.writeTXFIFO (len, (uint8_t *) pMsg))) return (FAIL);
        
	// Only load the header into the txfifo first. 
	lenToWrite = offsetof(TOS_Msg,data);
	if( !(lenToWrite = call HPLChipconFIFO.writeTXFIFO(lenToWrite,(uint8_t*)pMsg)) )
		return(FAIL); 
    
    //return (sendPacket());	
    //XIN:
    // This is incorrect on backoff timer retries.  The retry if this returns
    // fail from this lvl then the upper lvl should signal send done fail.  
    // If the failure is from the lower layer then, the upper lvl should not 
    // signal send done fail b/c send done fail will have been signaled already.
    
    //FIX:
    return SUCCESS;
      
  }	//fTXPacket
  
  
  /**
   * CC2420 buffer is filled.  Try to send the packet out via radio
   *
   * First attempt to transmit on CCA.  If channel isn't clear, set the
   * backoff timer return.  If transmit successful and link lvl ack is
   * requested, return and wait for the ack packet.  Otherwise if sendone
   * needed immediately handle send done immediately, other wise post task.
   *
   * @param void
   * @return void
   */
  result_t sendPacket() {
    uint8_t status;
    uint16_t fail_count = 0;
    uint8_t currentstate;
    int16_t backoffValue;
    uint8_t offset;

    call HPLChipcon.cmd (CC2420_STXONCCA);
    
    
IO_DEBUG_SET (TIMING_TEST);

    status = call HPLChipcon.cmd (CC2420_SNOP);
    if ((status >> CC2420_TX_ACTIVE) & 0x01) {
      //tx started
      while (!TOSH_READ_CC_SFD_PIN ()) {
		fail_count++;
		TOSH_uwait(5);
		if (fail_count > 1000) {
		  fSendAborted();
		  
IO_DEBUG_CLR (TIMING_TEST);

		  return (FAIL);
		}
      }; // wait until SFD pin goes high
      
      // Signal start of packet transmission
      signal RadioSendCoordinator.startSymbol(8,0,txbufptr);
      offset = offsetof(TOS_Msg,data);
      
      // push the rest of the packet into fifo (error check)
      call HPLChipconFIFO.writeTXFIFO(txlength+1-offset,(uint8_t*)txbufptr+offset);
      
      atomic currentstate = RadioState;	//exit based different states
      switch (currentstate) {
	  case PRE_TX_STATE:
	  case TX_STATE:
	    atomic RadioState = POST_TX_STATE;
	    call HPLChipcon.enableFIFOP();	//receive interrupt back on                             
	    txbufptr->ack = 1;	//implicit acknowledge

	    // if bAckMode
	    if ((bAckEnable || bAckManual) && (txbufptr->addr != TOS_BCAST_ADDR)) {
	      txbufptr->ack = 0;	//no ack yet
	      while (TOSH_READ_CC_SFD_PIN()) {};		// wait until TX finished
	      if ((setAckTimer (2 * CC2420_ACK_DELAY)))	//slower than autoack
			return (SUCCESS);	//now wait for an ack                                   
	    } //end if bAckMode

	    // XIN:
	    // Reach here if no Ack is needed or AckTimer start failed.
	    // If AckTimer start failed, this will return immeidately.  If not packet
	    // is sent again and if a ack comes in, another send done will be posted

	    if (gImmedSendDone) {
	      immedPacketSent();
	    } else {
	      if (!post PacketSent()) {
			fSendAborted();
			return (FAIL);
	      }	//post FAIL
	    }
	    break; //ok

	  default: //unexpected state ??? 
	    atomic RadioState = IDLE_STATE;
	    call HPLChipcon.enableFIFOP();	//just in case turn interrupt back on
	    return (FAIL);	//send FAIL
	    break;
      }	//end switch
      
      return (SUCCESS);		
           
    } else { 
	    // CC2420 Not in TX Mode, try send again
	    backoffValue = signal MacBackoff.congestionBackoff(txbufptr) * CC2420_SYMBOL_UNIT;
	    if (!setBackoffTimer(backoffValue)) fSendAborted();
    }
    
    return (SUCCESS); //function completed - tx done or retry started/aborted
    
  }	//sendPacket()

  
  /**
   * Try to send again after a congestion backoff
   *
   * @param void
   * @return void
   */
  void tryToSend() {
    uint8_t currentstate;
    int16_t backoffValue;
    atomic currentstate = RadioState;

    // state machine check
    if (currentstate == PRE_TX_STATE || currentstate == TX_STATE) {
	  // claer channel check
      if (TOSH_READ_RADIO_CCA_PIN()) {
		atomic RadioState = TX_STATE;	//new state to inhibit duplicate SendPackets
		call HPLChipcon.disableFIFOP();
		sendPacket();
      } else {
	    //channel busy
		if (cnttryToSend-- <= 0) {
		  	fSendAborted();
		  	return;
		}

		backoffValue = signal MacBackoff.congestionBackoff(txbufptr) * CC2420_SYMBOL_UNIT;
		if (!setBackoffTimer(backoffValue)) fSendAborted();
	  }
    }
  } // tryToSend()


  /*===Send/Recv/Fail Handlers ==============================================*/

  /**
   * Send is aborted.  
   *
   * The RX Buffer is flushed for good measure.  If the state machine is in a
   * TX sequence, adjust state and send done fail (potentially) ASYNCHRONOUSLY.
   * Also renables fifop int
   *  
   * @ param void
   * @ return void
   */
  void fSendAborted () {
    TOS_MsgPtr pBuf;		//store buf on stack 
    uint8_t currentstate;

    //CLEANUP the CC2420
    call HPLChipcon.read (CC2420_RXFIFO);	//flush Rx fifo
    call HPLChipcon.cmd (CC2420_SFLUSHRX);
    call HPLChipcon.read (CC2420_RXFIFO);	//flush Rx fifo
    call HPLChipcon.cmd (CC2420_SFLUSHRX);

    //route to correct caller
    atomic currentstate = RadioState;
    if ((currentstate >= PRE_TX_STATE) && (currentstate <= POST_TX_STATE)) {	//in a TX sequence
      atomic {
		txbufptr->time = 0;
		pBuf = txbufptr;
		//restore Payload length field as provided by caller
		pBuf->length = pBuf->length - MSG_HEADER_SIZE - MSG_FOOTER_SIZE;
		RadioState = IDLE_STATE;
      }
      signal Send.sendDone (pBuf, FAIL); //this could hang things up
      // XIN:
      // This should not be sent asynchronously, this should only be done so 
      // as a last resort, ie if no task can be posted.
      
      #ifdef DBG_UART_SENDDONE
      if (TOS_LOCAL_ADDRESS != 0) SODbg(DBG_PKT, "SF");
      #endif
    }
    //check if this is required ????
    call HPLChipcon.enableFIFOP ();
    return;
  }
  
  /**
   * Successfully terminate the send procedure.  
   *
   * Adjust buffer sizes.  Wait till send is complete.  Signal send done 
   * success
   *
   * @ param void
   * @ return void
   */
  inline void immedPacketSent () {

    TOS_MsgPtr pBuf;		//store buf on stack 
    uint8_t currentstate;
    atomic currentstate = RadioState;
    
    if ((currentstate == POST_TX_STATE)) {
      atomic {
		RadioState = IDLE_STATE;
		txbufptr->time = 0;
		pBuf = txbufptr;
		//restore Payload length field as provided by caller
		pBuf->length = pBuf->length - MSG_HEADER_SIZE - MSG_FOOTER_SIZE;
      }
      
      #ifdef DBG_UART_SENDDONE
      if (TOS_LOCAL_ADDRESS != 0) SODbg(DBG_PKT, "SD:%d\n",currentDSN);
      #endif
    
      while (TOSH_READ_CC_SFD_PIN ()) {}; // wait until tx done
      
IO_DEBUG_CLR (TIMING_TEST);
      
      signal Send.sendDone (pBuf, SUCCESS);	//cnttryToSend==0 if timedout
    } //if POST_TX_STATE
    
    #ifdef DBG_UART_SENDDONE
    else if (TOS_LOCAL_ADDRESS != 0) SODbg(DBG_PKT, "SDF");
    #endif

    //else this task invocation is a duplicate, ignore
    return;
  }

  /**
   * Signal a receive procedure.  
   *
   * Get the rx buff ptr.  Mux on whether to call receive synchronously or 
   * asyncly.  Swap buffer ptrs with the ptr retruned from upper lvl.  Release
   * buffer lock.  Enable interrupt.
   *
   * @param  void
   * @return void
   */
  inline void immedPacketRcvd () {
    TOS_MsgPtr pBuf;
    //could get here while a TX msg is being processed

    atomic {
      rxbufptr->time = 0;
      pBuf = rxbufptr;

//XIN: State no longer around
//       if (RadioState == RX_ACK_STATE) {
// 		while (TOSH_READ_CC_SFD_PIN ()) {}; // wait until rx actually finished
// 		RadioState = IDLE_STATE;
//       }
      
    }

    // signals correct event depending on context
    if (gImmedSendDone) {
    	pBuf = signal asyncReceive((TOS_MsgPtr) pBuf);
    } else {
    	pBuf = signal Receive.receive((TOS_MsgPtr)pBuf);
    }
    
    atomic {
	  // XIN:
	  // This check does nothing, system is screwed if a null pointer is returned
	  // even if we know about it.
      if (pBuf) rxbufptr = pBuf;
      rxbufptr->length = 0;
      bRxBufLocked = FALSE;	//now available for use
    }
    
    #ifdef DBG_UART_SENDDONE
    if (TOS_LOCAL_ADDRESS != 0) SODbg(DBG_PKT, "R\n");
    #endif
    
    //debug - reenable FIFOP interrupts now we have a valid rxbuf   
    call HPLChipcon.enableFIFOP ();

IO_DEBUG_CLR (TIMING_RX);
  }

  /*===Send/Recv Tasks ========================================================*/

  task void PacketRcvd () {
    immedPacketRcvd ();
  }


  task void PacketSent () {
    immedPacketSent ();
  }

  /*===StdControl =============================================================*/

  command result_t StdControl.init () {

    atomic {
      RadioState = DISABLED_STATE;
      currentDSN = 0;
      bAckEnable = FALSE;
      bAckManual = TRUE;
      rxbufptr = &RxBuf;
      rxbufptr->length = 0;
      rxlength = MSG_DATA_SIZE - 2;	//includes length byte, not FCS
      //XIN:
      gImmedSendDone = FAIL;
    }

    call CC2420StdControl.init ();
    call TimerControl.init ();
    call Random.init ();
    LocalAddr = TOS_LOCAL_ADDRESS;

    call MacControl.disableAck ();	//disables address decode also
    call MacControl.disableAddrDecode ();	//and enables Manual Ack

    //XIN:
	//Do not set RSSI_THERSHOLD here
    
    #ifdef USE_ADC_PINS
		setDebugPinDirection();
	#endif

    return SUCCESS;
  }


  command result_t StdControl.stop () {
	#ifdef DBG_UART_SENDDONE
    if (TOS_LOCAL_ADDRESS != 0) SODbg(DBG_PKT, "R_STP\n");
    #endif
    
    atomic RadioState = DISABLED_STATE;
    if (TOS_LOCAL_ADDRESS != 0)
      call EnableLowPower ();

    call CC2420StdControl.stop ();

IO_DEBUG_CLR (START_STOP);



    return SUCCESS;
  }


  command result_t StdControl.start () {
    uint8_t chkRadioState;

    atomic chkRadioState = RadioState;

    if (chkRadioState == DISABLED_STATE) {
	  #ifdef DBG_UART_SENDDONE
      if (TOS_LOCAL_ADDRESS != 0) SODbg(DBG_PKT, "R_GO\n");
      #endif
    
      atomic {
		rxbufptr->length = 0;
		RadioState = IDLE_STATE;

		call CC2420StdControl.start ();	// PRESENT STRATEGY WILL WAIT ~2 msec
		
		if (gImmedSendDone) {
			//Increase rssi sensetivity
			call HPLChipcon.write(CC2420_RSSI, LP_RSSI);
		}
		
		call CC2420Control.RxMode ();
      }	//atomic
    } //DISABLED

IO_DEBUG_SET (START_STOP);

    return SUCCESS;
  }

  /*===Jiffy Timer Fire =======================================================*/
  
  /**
   * Backoff Timer just fired.  Switch on stateTimer
   *
   * TIMER_INITIAL: disable fifop, transfer into buffer & change state, else
   * abort and reenable fifop.
   *
   * TIMER_BACKOFF: tryToSend() again.
   *
   * TIMER_ACK: no ack came.  Goto Post tx state, post packet send or 
   * fsendAbort()
   *
   * TIMER_SNIFF: set bool to sniff done
   *
   * @param void
   * @return result_t (SUCCESS)
   */

  async event result_t BackoffTimerJiffy.fired () {
    uint8_t cret;
    uint8_t currentstate;
    atomic currentstate = RadioState;
    
    switch (stateTimer) {
	    
	case TIMER_INITIAL:
	  stateTimer = TIMER_IDLE;
	  
	  //Disable RX Interrupts
	  call HPLChipcon.disableFIFOP();

	  //push packet into buffer
	  cret = fTXPacket(txlength + 1, (uint8_t *) txbufptr);
	  
	  //if push not successful, abort send
	  if (!cret) {		
	    atomic RadioState = IDLE_STATE;
	    fSendAborted();
		//XIN:
		//Previously ftxPacket called sendpacket.  There is error handling
		// in sendpacket, and there is error handling on this cret.  Seperated
		//now b/c previous case might cause 2 error handlings to occur
	  } else {
		sendPacket(); //has error handling
	  }
	  	  
	  //Enable RX Interrupts
	  call HPLChipcon.enableFIFOP ();
	  break;
	  
	case TIMER_BACKOFF:
	  stateTimer = TIMER_IDLE;
	  tryToSend();
	  break;
	  
	case TIMER_ACK:
	  stateTimer = TIMER_IDLE;
	  if (currentstate == POST_TX_STATE) {
	    txbufptr->ack = 0;	    
	    if (!post PacketSent ()) {	//XIN:  make sure this is packet sent done not rx	      
	      fSendAborted ();	//abort
	    }
	  }
	  break;
	  
	  //XIN:
	case TIMER_SNIFF:
	  stateTimer = TIMER_IDLE;
	  atomic gSniffDone = SUCCESS;	  
	  break;
	  
    }
    return SUCCESS;
  }


   /**
    * Entry point for sending packets.
    *
    * Send only if state == IDLE.  Fill in 15.4 header, modify length,
    * incrument DSN.  Save msg ptr.  Start initial back off.  Else
    * restore state and return fail.
    *
    * @param pMsg		Pointer to the msg to be sent
    * @return result_t  SUCC/FAIL according to above
    *
    */
  command result_t Send.send (TOS_MsgPtr pMsg) {
    //uint8_t cntRetry;
    //uint8_t cret;
    uint8_t currentstate;
    int16_t backoffValue;

	TOSH_uwait2(30); //adjust this value according to preamble size
	
    atomic {
	    currentstate = RadioState;
	    if (currentstate == IDLE_STATE) RadioState = PRE_TX_STATE;	
    }
    
    if (currentstate == IDLE_STATE) {   
      // put default FCF values in to get address checking to pass
      pMsg->fcflo = CC2420_DEF_FCF_LO;
      if (bAckEnable)
		pMsg->fcfhi = CC2420_DEF_FCF_HI_ACK;
      else
		pMsg->fcfhi = CC2420_DEF_FCF_HI;
		
      // destination PAN is broadcast
      pMsg->destpan = TOS_BCAST_ADDR;
      
      // adjust the destination address to be in the right byte order
      pMsg->addr = toLSB16 (pMsg->addr);
      
      // adjust the  length (for TXFIFO MPDU) to the full packet length+space for FCS(footer)
      // MSG_HEADER_SIZE is MHR - does NOT include length byte. Nominally 7bytes
      pMsg->length = pMsg->length + MSG_HEADER_SIZE + MSG_FOOTER_SIZE;	//with 2 xtra FSC bytes
      
     
      atomic {
		// keep the DSN increasing for ACK recognition
		pMsg->dsn = ++currentDSN;

		// FCS bytes generated by CC2420
		// this is the actual CC2420 PAYLOAD( MHR+MPDU)length (w/o FCS)
		txlength = pMsg->length - MSG_FOOTER_SIZE;

		txbufptr = pMsg;
		//RadioState = PRE_TX_STATE;	//race moved to beginning
      }
      
      //Start the initial backoff timer
      backoffValue = signal MacBackoff.initialBackoff (txbufptr) * CC2420_SYMBOL_UNIT;
      if (setInitialTimer(backoffValue)) {
      	cnttryToSend = SEND_RETRY_COUNT;
      	
      #ifdef DBG_UART_SENDDONE
      if (TOS_LOCAL_ADDRESS != 0) SODbg(DBG_PKT, "S:%d\n",currentDSN);
      #endif
      
		return SUCCESS;
      }
      
      //back off timer failed restore RadioState
      atomic RadioState = IDLE_STATE;	//race
      call HPLChipcon.enableFIFOP ();

    } //if idle
    
    return (FAIL); //not idle or backofftimer failed
    
  }	//.send
  
  

  /**
   * Send out a raw message over the 15.4 phy.  Assume first byte of the 
   * buffer ptr is the length of the payload not including the length byte.
   *
   * @param bufferPtr	ptr to phy payload
   * @return result_t	succes of the send
   */
   
  async command result_t asyncSend (uint8_t * bufferPtr) {
	uint8_t currentstate;
	uint8_t bytesWritten;
	uint16_t fail_count=0;
	uint8_t status;
	
    atomic {
	    currentstate = RadioState;
	    if (currentstate == IDLE_STATE) {
		    RadioState = RAW_TX_STATE;	
		    call HPLChipcon.disableFIFOP();
	    }
    }
    
    if (currentstate == IDLE_STATE) {
	    
	    //no packet length corruption check is done here
	    bytesWritten = bufferPtr[0];

	    //increase the length to accomodate FCS bytes
	    bufferPtr[0] = bytesWritten + MSG_FOOTER_SIZE;

	    //Flush CC2420 radio TX buffer
    	if (!(call HPLChipcon.cmd (CC2420_SFLUSHTX))) {
	    	goto ABORT_ASYNC_SEND;
    	}
    	
    	//XIN:
    	//Does this call to write return status or does it return the number 
    	//of bytes written? 1
    	
    	//Load bytes into radio buffer 
    	if (!call HPLChipconFIFO.writeTXFIFO (bytesWritten+1, bufferPtr)) {
    		goto ABORT_ASYNC_SEND;
    	}
    	
    	//Start the send
    	//call HPLChipcon.cmd (CC2420_STXONCCA);
    	call HPLChipcon.cmd (CC2420_STXON);
    
IO_DEBUG_SET (TIMING_TEST);

    	status = call HPLChipcon.cmd (CC2420_SNOP);
    	if ((status >> CC2420_TX_ACTIVE) & 0x01) {
	    	
	      	//tx started - 20 sybmol delay before sfd is transmitted ~320us
	      	while (!TOSH_READ_CC_SFD_PIN ()) {
				fail_count++;
				TOSH_uwait(5);
				if (fail_count > 1000) {
					goto ABORT_ASYNC_SEND;
				}
	      	} //while
	      	
	      	//wait till PSDU is sent completely
	      	while (TOSH_READ_CC_SFD_PIN()) {};
	      	
IO_DEBUG_CLR (TIMING_TEST);

			bufferPtr[0] = bytesWritten;
	      	atomic RadioState = IDLE_STATE;
	      	call HPLChipcon.enableFIFOP();
	      	return SUCCESS;	      	
      	} //if tx_active

IO_DEBUG_CLR (TIMING_TEST);
      	
    //terminate raw send
	ABORT_ASYNC_SEND:
		bufferPtr[0] = bytesWritten;
		atomic RadioState = IDLE_STATE;
		call HPLChipcon.enableFIFOP();
		return FAIL;	
		
    } //end if idle
	    
    //current radio state not idle
	return FAIL;
	
  } //asyncSend

   /**
    * FifoP interrupt just occured.  Service the pending packet
    *
    * If a packet is coming in while we are backing off, backoff more.
    * If buffer overflow or rxbuffer lock, flush the rxfifo.
    * Read first byte to get length of buffer, discard if exceed our buffer
    * length.  Read in remainder of packet.  Check crc. 
    * 
    * If Ack & we are expecting, stop jiffy timer and post packet sent
    *
    * Throw out non-data & ack packet types.  Lock rx buffer.  Adjust size 
    * field.  Adjust byte order of dest addr.  Set the crc field correctly.
    * Set the RSSI field.  Acked is false.
    *
    * If acks are requested, send an ack back.  Wait until ack completes.
    * 
    * If finish up the receive asyncly or syncly as desired.
    *
    * @param void
    * @return result_t (SUCCESS)
    */
    
  async event result_t HPLChipcon.FIFOPIntr () {

    //result_t cret;
    uint8_t *pData;
    uint8_t length = MSG_DATA_SIZE;	//total size of available buffer -including length byte
    uint8_t currentstate;
    int16_t backoffValue;
    
    atomic currentstate = RadioState;

IO_DEBUG_SET (TIMING_RX);

    //THIS SECTION SHOULD NOT HAPPEN W/INT DISABLED DURING PRE_TX
    //if we're trying to send a message and a FIFOP interrupt occurs
    // and acks are enabled, we need to backoff longer so that we don't
    // interfere with the AUTOMATIC  ACK

    if ((bAckEnable) && (currentstate == PRE_TX_STATE)) {
      if (call BackoffTimerJiffy.isSet()) {
		call BackoffTimerJiffy.stop();
		backoffValue = ((signal MacBackoff.congestionBackoff(txbufptr) 
						* CC2420_SYMBOL_UNIT) + CC2420_ACK_DELAY);
		call BackoffTimerJiffy.setOneShot(backoffValue);
      }
    }
    
    // FLush FIFO if overflowed
    if (!TOSH_READ_CC_FIFO_PIN () || bRxBufLocked) {      
      call HPLChipcon.read (CC2420_RXFIFO);	//flush Rx fifo
      call HPLChipcon.cmd (CC2420_SFLUSHRX);      
      call HPLChipcon.cmd (CC2420_SFLUSHRX);
      return FAIL;
    }
    
    // Read first byte and header bytes of FIFO - the packet length byte
    pData = (uint8_t *) rxbufptr;
    length = call HPLChipconFIFO.readRXFIFO (1, pData);
    
    // ignore msb, length is size of MPDU
    rxbufptr->length &= CC2420_LENGTH_MASK;

    //number of bytes in packet - excluding length byte
    length = rxbufptr->length;

    //Test - is length reasonable?
    if ((length > MSG_DATA_SIZE - 1)) {
      call HPLChipcon.read (CC2420_RXFIFO);	//flush Rx fifo
      call HPLChipcon.cmd (CC2420_SFLUSHRX);      
      call HPLChipcon.cmd (CC2420_SFLUSHRX);
      atomic bRxBufLocked = FALSE;	//rxbuffer is now free
      return FAIL;
    }

    // Read remainder of packet into rxbuffer following the length byte
    pData = (uint8_t *) rxbufptr + 1;	
    length = call HPLChipconFIFO.readRXFIFO (length, pData);
    
    //NOTE: 
    //pData is 1 byte into rxbufptr and length is 1 byte smaller 'cause it 
    //does not include length byte
    
    //Check CRC, reject if bad 
    if (!(pData[length - 1] & 0x80)) {
      atomic bRxBufLocked = FALSE;
      return SUCCESS;
    }
    
    //Check length, reject if bad 
    if (rxbufptr->length < 5) {
      atomic bRxBufLocked = FALSE;
      signal shortReceived();
      return SUCCESS;
    }
    
    //Process Ack Message related to a Transmission
    if (((rxbufptr->fcfhi & 0x03) == CC2420_DEF_FCF_TYPE_ACK) &&
		(rxbufptr->dsn == currentDSN) &&
		(bAckEnable || bAckManual) && 
		(currentstate == POST_TX_STATE) ) {	//only if expecting an ack  
		
       txbufptr->ack = 1;
	
IO_DEBUG_TOGGLE (TRACE);	//ack receieved       
 
		//XIN:
		//Potential Race condition, could cause 2 senddone
		if (post PacketSent ()) call BackoffTimerJiffy.stop();

IO_DEBUG_CLR (TIMING_RX);

		return SUCCESS;		//all done
	} // done process ack
      
      
    //Throw out anything other than Data Packets
    if ((rxbufptr->fcfhi & 0x03) != CC2420_DEF_FCF_TYPE_DATA) {
      atomic bRxBufLocked = FALSE;
      return SUCCESS;
    }

    atomic bRxBufLocked = TRUE;	//rxbuffer is now busy
    //adjust length to reflect TOS PAYLOAD length, MSG_HEADER_SIZE=MHR+TOSHeader=12
    rxbufptr->length = rxbufptr->length - MSG_HEADER_SIZE - MSG_FOOTER_SIZE;

    // adjust destination to the right byte order
    rxbufptr->addr = fromLSB16 (rxbufptr->addr);

    // FCS/MFR last 2 bytes:FCS[0]=RSSI, FCS[1]=CRCWeighted,MSB=CRCOK
    rxbufptr->crc = pData[length - 1] >> 7;	//MSBit is CRCOK
    
    // just put in RSSI for now, calculate LQI later
    rxbufptr->strength = pData[length - 2];
    rxbufptr->ack = FALSE;	//default is not acknowledged

    //Send an Acknowledge  iff appropriate      
    //what if we are in middle of a TX send sequence? -throw out ack for now
    if (bAckManual) {
      if ((rxbufptr->addr == TOS_LOCAL_ADDRESS) &&
	  	 (rxbufptr->group == TOS_AM_GROUP)) {
		  	  
		call HPLChipcon.cmd (CC2420_SACK);
		while (!TOSH_READ_CC_SFD_PIN ()) {}; // wait unitl ack tx starts
		
IO_DEBUG_TOGGLE (TRACE);	//ack sent

      }	//addr   
    } //backmanual

    /* XIN:
     * This delay is only useful for sending the ack.  You want to make sure 
     * the ack is sent out before you relinquish the radio.  However if you 
     * are only sending packets without acks, you might miss the down edge and 
     * get delayed for one whole packet period. 
     */

    while (TOSH_READ_CC_SFD_PIN ()) {};	// wait tx actually finishes


    //packet received and done
    if (gImmedSendDone) {
      immedPacketRcvd ();
      //atomic bRxBufLocked = FALSE;
    } else if (!post PacketRcvd ())
      atomic bRxBufLocked = FALSE;	//XIN:

    return SUCCESS;
  }	//FIFOPIntr

  
 /*===CC2420 Configuration commands ==========================================*/ 

 //NOTE:
 // Be extremely careful when changing radio configurations.  Most of these
 // values if changed while the stack is running will have potential race
 // or fatal conditions.  Also upper layers will only function correctly with 
 // certain configurations.
 
 
  /**
   * Enable CC2420 Receiver Hardware Address Decode.
   *
   * @param void
   * @return void
   */
  async command void MacControl.enableAddrDecode () {
    call CC2420Control.enableAddrDecode ();
    bAckManual = TRUE;
  }

  /**
   * Disable CC2420 Receiver Hardware Address Decode.
   * Also disables AutoAck - no ack without Address decode
   *
   * @param void
   * @return void
   */
  async command void MacControl.disableAddrDecode () {
    call CC2420Control.disableAddrDecode ();
    call CC2420Control.disableAutoAck ();	//AutoAck not valid w/o Address decode
    bAckManual = TRUE;		//enable promiscuous Ack
  }

  /**
   * Enable CC2420 Hardware auto ack.  
   *
   * Be very careful when calling this.  Only guarenteed safe when stack stopped.
   *
   * @param void
   * @return void
   */
  async command void MacControl.enableAck () {
    bAckEnable = TRUE;
    bAckManual = FALSE;
    call CC2420Control.enableAutoAck ();
  }

  /**
   * Disable CC2420 Hardware auto ack.
   *
   * Be very careful when calling this.  Only guarenteed safe when stack stopped.
   *
   * @param void
   * @return void
   */
  async command void MacControl.disableAck () {
    bAckEnable = FALSE;
    call CC2420Control.disableAutoAck ();
  }


  command result_t setImmediateSendMode (result_t option) {
    atomic gImmedSendDone = option;
    return SUCCESS;
  }

  command result_t isImmediateSendMode () {
    return gImmedSendDone;
  }

  
  /*===CC2420 Clear Channel Assessment ========================================*/ 
  
  /**
   * Stops CCA check
   *
   * @param void
   * @return void
   */
  async command result_t stopCCA () {
    atomic gStopCCA = SUCCESS;
    return SUCCESS;
  }


  /**
   * Spin checks CCA for t u_sec.  This will terminate on sniff timer
   * fire gSniffDone, temp==0, manually stopped gStopCCA.  
   *
   * @param void
   * @return result_t	FAIL indicates channel activity
   */
  command result_t checkCCA (uint32_t t) {
    /*
     *  t is in u_sec
     */
    result_t lStopCCA;
    result_t lSniffDone;
    uint8_t temp = 250;

IO_DEBUG_SET (CCA);

    atomic {
      gStopCCA = FAIL;
      gSniffDone = FAIL;
    }

    TOSH_uwait2 (128);	// wait 128us for valid CCA

IO_DEBUG_CLR (CCA);

    if (!setSniffTimer (t >> 5)) {	
      return SUCCESS;
    }

IO_DEBUG_SET (CCA);

    while (temp--) {
	    
#ifdef RSSI2PINS 
	RSSI2PINS;
#endif
      if (!TOSH_READ_RADIO_CCA_PIN ()) {
	      
IO_DEBUG_CLR (CCA);

		call BackoffTimerJiffy.stop ();
		return FAIL;
      }

      atomic {
		lStopCCA = gStopCCA;
		lSniffDone = gSniffDone;
      }

      if (lStopCCA) {

IO_DEBUG_CLR (CCA);

		call BackoffTimerJiffy.stop ();
		return FAIL;
      }

      if (lSniffDone)
		break;
    }  //end while

IO_DEBUG_CLR (CCA);

    return SUCCESS;

  } //checkCCA()

  /**
   * Spin checks SFD for t u_sec.  This will terminate on sniff timer
   * fire gSniffDone, temp==0, manually stopped gStopCCA.  
   *
   * @param void
   * @return result_t	FAIL indicates channel activity
   */
  command result_t checkSFD (uint32_t t) {
    /*
     *  t is in u_sec
     */
    result_t lStopCCA;
    result_t lSniffDone;
    uint8_t temp = 250;

IO_DEBUG_SET (CCA);

    atomic {
      gStopCCA = FAIL;
      gSniffDone = FAIL;
    }

IO_DEBUG_CLR (CCA);

    if (!setSniffTimer (t >> 5)) {	
      return SUCCESS;
    }

IO_DEBUG_SET (CCA);

    while (temp--) {
	    
      if (TOSH_READ_CC_SFD_PIN ()) {
	      
IO_DEBUG_CLR (CCA);

		call BackoffTimerJiffy.stop ();
		return FAIL;
      }

      atomic {
		lStopCCA = gStopCCA;
		lSniffDone = gSniffDone;
      }

      if (lStopCCA) {

IO_DEBUG_CLR (CCA);

		call BackoffTimerJiffy.stop ();
		return FAIL;
      }

      if (lSniffDone)
		break;
    }  //end while

IO_DEBUG_CLR (CCA);

    return SUCCESS;

  } //checkCCA()
  
  /*===Unimplemented Commands/Events===========================================*/
  
  command result_t RadioPower.SetTransmitMode (uint8_t power) {
    return SUCCESS;
  }

  command result_t RadioPower.SetListeningMode (uint8_t power) {
    return SUCCESS;
  }

  async event result_t HPLChipconFIFO.RXFIFODone (uint8_t length,
						  uint8_t * data) {
    //stub - do nothing
    return (SUCCESS);
  }

  async event result_t HPLChipconFIFO.TXFIFODone (uint8_t length,
						  uint8_t * data) {
    //do nothing - replaced by a function
    return (SUCCESS);
  }
  
  /*===Default Events =========================================================*/
  
  /**
   * return pBuf ptr and do nothing
   */
  default async event TOS_MsgPtr asyncReceive (TOS_MsgPtr pBuf){
	  return pBuf;
  }
  
  /**
   * do nothing
   */
  default async event void shortReceived(){
	  return;
  }
  
  /**
   * How many basic time periods to back off.
   * Each basic time period consists of 20 symbols (16uS per symbol)
   */
  default async event int16_t MacBackoff.initialBackoff (TOS_MsgPtr m) {
    return ((call Random.rand () & 0xF) + 1);
  }
  
  /**
   * How many symbols to back off when there is congestion (16uS per symbol)
   */
   
  default async event int16_t MacBackoff.congestionBackoff (TOS_MsgPtr m) {
    return ((call Random.rand () & 0xF) + 1);
  }
  
  default async event void RadioSendCoordinator.
      startSymbol (uint8_t bitsPerBlock, uint8_t offset, TOS_MsgPtr msgBuff) {
  }
  
  default async event void RadioSendCoordinator.byte (TOS_MsgPtr msg,
						      uint8_t byteCount) {
  }
  
  default async event void RadioReceiveCoordinator.
      startSymbol (uint8_t bitsPerBlock, uint8_t offset, TOS_MsgPtr msgBuff) {
  }
  
  default async event void RadioReceiveCoordinator.byte (TOS_MsgPtr msg,
							 uint8_t byteCount) {
  }



}
