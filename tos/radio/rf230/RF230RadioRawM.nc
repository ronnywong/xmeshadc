/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: RF230RadioRawM.nc,v 1.1.2.2 2007/04/27 05:02:30 njain Exp $
 */

 
includes byteorder;

//#define RESET_AFTER_LONG_WAKEUP

module RF230RadioRawM {
	
	provides {
		//control
		interface SplitControl as RadioSplitControl;

		//timing on each packet
		interface RadioCoordinator as sendCoordinator;
		interface RadioCoordinator as recvCoordinator;
		
		//sending tinyos packets
		interface BareSendMsg as Send;
		
		//receiving tinyos packets
		interface ReceiveMsg as Receive;
		
		//send,recv,wait for wakeup packets
		interface WakeSequence;

		//interface for controlling back off value on the baresend
		interface MacBackoff;
	}
	
	uses {
		//rf230 control
		interface SplitControl as RF230ControlSplitControl;
		interface RF230Control;
		
		//frame & ram access
		interface HPLRF230;
		
		//interrupt handling
		//interface StdControl as InterruptControl;  //controlM starts and stops this
		interface RF230Interrupts;

		//fast timer for back off
		interface TimerJiffyAsync;
    	interface Random;
    	interface Leds;
	}
}

implementation {

/* === Debug =============================================================== */

	#include "pinMacros.h"
	
/* === Timer State ========================================================= */

	enum {
		RF230_TIMER_IDLE,
    	RF230_TIMER_BACKOFF,
    	RF230_TIMER_ACK,
    	RF230_TIMER_SEND,
    	RF230_TIMER_SNIFF
	};
	
	uint8_t timerState = RF230_TIMER_IDLE;	//timer state 	//atomic
		
/* === Radio State ========================================================= */

	enum {
		//off & not initialized
		RF230_RADIO_DISABLED,
		
		//initialization
		//RF230_RADIO_INIT,
		//RF230_RADIO_INIT_DONE,
		RF230_RADIO_START,		//START_DONE == IDLE (split phase)
		RF230_RADIO_STOP,		//STOP_DONE == OFF (split phase)
				
		//idle (rx_on)
		RF230_RADIO_IDLE,
		
		//off (sleep)
		//RF230_RADIO_OFF,	//not implemented
		
		//send
		RF230_RADIO_SEND_SETUP,		//before the timer is set, 
		RF230_RADIO_SEND_BACKOFF,	//send queued, back off initial & repeat
		RF230_RADIO_SEND_TX,		//ready to send, no more back off
		RF230_RADIO_WAIT_ACK,		//wait for ack
		RF230_RADIO_SEND_DONE,		//waiting for post to finish
		RF230_RADIO_SEND_FAIL,		//send failed

		//preamble send
		RF230_RADIO_SEND_WAKEUP,	//sending wake up packet.
		
		//recv
		//RF230_RADIO_SEND_ACK,  //can't blow the tx-state
		
	};  
	
	uint8_t radioState; //radio state machine 	//atomic
	

/* === Module Variables ==================================================== */

	bool bAckEnabled;

	bool bRxBufLocked;	//atomic
	bool bTxBufLocked;	//atomic
	bool bSniffTimerLocked;
	
	uint8_t sendRetries;
	uint8_t currentDSN;
	
	uint16_t wakePacketCount;
	
	//number of bytes the spi needs to transmit.  Different from the 15.4 
	//frame length and the length in the TOS_Msg.
	uint8_t txlength;		

	TOS_MsgPtr txbufptr;	// pointer to transmit buffer
	TOS_MsgPtr rxbufptr;	// pointer to receive buffer
	TOS_Msg RxBuf;			// save received messages
	
	//some set-mote-id scripts will break without this
	volatile uint16_t LocalAddr;
	
/* === Function prototypes ================================================= */
	
	inline void initLocalState();
	
	inline void fillDataPacket(TOS_MsgPtr pMsg);
	inline void tryToSend();
	inline void doCongestionBackOff();
	inline void completeSend();
	
	inline result_t setBackoffTimer (uint16_t jiffy);
	inline result_t setAckTimer (uint16_t jiffy);
	inline result_t setSniffTimer (uint16_t jiffy);
	inline result_t setSendTimer (uint16_t jiffy);
	
	
	inline void	stopAllTimers();
	
	inline void handleRxInt();
	inline void handleTxInt(result_t status);
	inline void handleSendAck(uint8_t dsn);
	inline void handleWakeInt();
	
/* === Tasks =============================================================== */

	// INIT
	task void sigInitDone() {
		//DO NOT USE
	}
	
	task void sigStartDone() {
		//NOT USED NOW
		//If the long call stack is a issue, can be used in the future
	}
	
	task void sigStopDone() {
		//NOT USED NOW
		//atomic radioState = RF230_RADIO_OFF;
		//signal RadioSplitControl.stopDone();
	}
		
	// SEND / RECV
	task void handleSendDone() {
		completeSend();
		
		//NOTE:
		//Don't forget about power management
		
		//NOTE:
		//Don't forget to unlock
	}
	
	task void handleRecv() {
		TOS_MsgPtr ptr;

		ptr = signal Receive.receive(rxbufptr); 
		atomic {
			rxbufptr = ptr;
			bRxBufLocked = FALSE;
		}
		
IO_DEBUG_CLR(TIMING_RX);

		//NOTE:
		//Don't forget about power management
		
		//NOTE:
		//Don't forget to unlock
	}
	
	task void sigJiffyTimer() {
		signal TimerJiffyAsync.fired();
	}
		
/* === Split Control Init ================================================== */

	/**
	 * Initialize the component and its subcomponents.
	 *
	 * @return Whether initialization was successful.
	 */
	command result_t RadioSplitControl.init() {
		result_t ok1, ok2;
		
		ok1 = call RF230ControlSplitControl.init();	//not a split phase call
		ok2 = call Random.init();
		initLocalState();
		
		return rcombine(ok1, ok2);
		
		//NOTE:
		//No protection on init calls
		
		//NOTE:
		//No split phase.  Does not signal InitDone().
	}
	
	/**
	 *
	 */
	inline void initLocalState() {
		atomic {
			timerState = RF230_TIMER_IDLE;
			radioState = RF230_RADIO_DISABLED;
			bAckEnabled = TRUE;
			
			bRxBufLocked = FALSE;
			bTxBufLocked = FALSE;
			
			sendRetries = 0;
			currentDSN = 0;
			
			rxbufptr = &RxBuf;
		}
	}
	
	/** 
	 * Notify components that the component has been init
	 *
	 */
	event result_t RF230ControlSplitControl.initDone() {
		//NOT USED - NEVER SIGNALED
		return SUCCESS;
	}

/* === Split Control Start ================================================= */

	/**
	 * Start the component and its subcomponents.
	 *
	 * @return Whether starting was successful.
	 */
	command result_t RadioSplitControl.start() {
		result_t result;
		
		//Quick state check & transition
		atomic { //atomic over kill
			if (radioState == RF230_RADIO_START) {
				//This protects from repeat calls before the frist start
				//call returns.  By returning false we say that we will not
				//signal a start done on this start call.
				result = FAIL;	
			} else {
				result = SUCCESS;
				radioState = RF230_RADIO_START;
			}
		}
		
		if (result == FAIL) return FAIL;
		
		//Begin start routine
		result = call RF230ControlSplitControl.start();
		
		return result;
	
		//NOTE:
		//Power Management Done in controlM.  Depends on if EdgeEvents are
		//enabled.
	}
	
	/** 
	 * Notify components that the component has been started and is ready to
	 * receive other commands
	 *
	 */
	event result_t RF230ControlSplitControl.startDone() {
		
		//RX_ON
		
		//NOTE:
		//We put enable in atomic block so that radio reaches idle state
		//before interrupt fires.
		atomic {
			call RF230Interrupts.enable();
			radioState = RF230_RADIO_IDLE;
		}
		
		signal RadioSplitControl.startDone();
		
		return SUCCESS;
	}

/* === Split Control Stop ================================================== */

	/**
	 * Stop the component and pertinent subcomponents (not all
	 * subcomponents may be turned off due to wakeup timers, etc.).
	 *
	 * @return Whether stopping was successful.
	 */
	command result_t RadioSplitControl.stop() {
		result_t result;
		
		atomic {
			if (radioState == RF230_RADIO_STOP ||
				radioState == RF230_RADIO_START) {
				result = FAIL;
			} else {
				result = SUCCESS;
				radioState = RF230_RADIO_STOP;
			}
		}
		
		if (result == FAIL) return FAIL;
		
		//NOTE:
		//Once the stack switches to radio stop above, all new receieves will
		//be rejected.  If the stack is in the progress of transmitting a packet
		//It doesn't care about interrupts since send does not use them.  However 
		//if the send is in progress and we power down the radio stack 2 issues.
		//1. It will access the radio when it is power down which could throw 
		//		into a bad state
		//2. On send done, the state will be set to radio_idle not power_off
		
		//NOTE:
		//Not doing split phase on stop not a good idea for future.  IE HALT.
		
		
		call RF230Interrupts.disable();
		call RF230ControlSplitControl.stop();
		//return (post sigStopDone());	//all radio posts must be posted before this post
		
		return SUCCESS;
		
	}

	/**
	 * Notify components that the component has been stopped. 
	 */
	event result_t RF230ControlSplitControl.stopDone() {
		//NOT USED - NEVER SIGNALED
		return SUCCESS;
	}
	
/* === Send ================================================================ */

	/**
	 *
	 */
	command result_t Send.send (TOS_MsgPtr pMsg) {
		uint8_t currentState;
		int16_t backoffValue;
		result_t result;
		
		//Valid Packet Length Check - FCS in the payload
		if (pMsg->length > TOSH_DATA_LENGTH ) return FAIL;
		
		
		//State Check + Transition
		atomic {
			currentState = radioState;
			if (currentState == RF230_RADIO_IDLE) radioState = RF230_RADIO_SEND_SETUP;
			//bTxBufLocked = TRUE;	//IS this a good idea? - only if tx has the lock on the radio
		}
		
		if (currentState != RF230_RADIO_IDLE) return FAIL;
		
IO_DEBUG_SET(TIMING_TX);

		//RF230_RADIO_SEND_SETUP
		fillDataPacket(pMsg);	//incruments dsn
		
		//get the initial back off value
		//backoffValue = signal MacBackoff.initialBackoff(pMsg) * IEEE15_4_SYMBOL_TIME;
		backoffValue = signal MacBackoff.initialBackoff(pMsg);
		result = setBackoffTimer(backoffValue);
		
		//Continue TX State transition or abort
		atomic {

			//save the tx buffer ptr
			txbufptr = pMsg;	//p
		
			if (result == SUCCESS) {
				//backofftimer set successfully
		
				sendRetries = 0;
				radioState = RF230_RADIO_SEND_BACKOFF;
			} else {
				//failed to set backoff
				
IO_DEBUG_CLR(TIMING_TX);

				radioState = RF230_RADIO_IDLE;
				//bTxBufLocked = FALSE; - only if tx has the lock on the radio
			}
		}
		
		return result;
	}
	
	/**
	 *
	 */
	inline void fillDataPacket(TOS_MsgPtr pMsg) {
		
		atomic {
	      	// PHR Length field.  Size of PSDU == MPDU.  Doesn't include Length
	      	// byte itself since length is part of the PHR not PSDU.
			pMsg->length = pMsg->length + MSG_HEADER_SIZE + MSG_FOOTER_SIZE;	//+2 FCS
			
			// put default FCF high
			if (bAckEnabled && pMsg->addr != TOS_BCAST_ADDR) {
				pMsg->fcfhi = IEEE15_4_DEF_FCF_HI_ACKREQ;
			} else {
				pMsg->fcfhi = IEEE15_4_DEF_FCF_HI;
			}
			
			// put in default FCF low
			pMsg->fcflo = IEEE15_4_DEF_FCF_LO;
			
			//DSN
			pMsg->dsn = ++currentDSN;
			
			//NOTE:
			// dsn always starts with 1 unless wrapped back.  If the send fails, 
			// the dsn is still incrumeted.  Also acks use this.
			
			// destination PAN is broadcast
			pMsg->destpan = IEEE15_4_DEF_BCAST_PAN;
			
			// adjust the destination address to be in the right byte order
			pMsg->addr = toLSB16 (pMsg->addr);
			
			// reset ack bit
			pMsg->ack = 0;  //p
			
			// number of bytes to be sent over the spi - we calculate the CRC
			txlength = pMsg->length;
		}
		
	}
	
	/**
	 *
	 */
	inline void tryToSend() {
		//back off timer just fired		
		bool bNoSend;
		bool bRadioStopped = FALSE;
		uint8_t transitTime;
		
IO_DEBUG_TOGGLE(TRYTOSEND);

		//State check + Lock state
		atomic {
			
			//RADIO Active Check
			if (radioState == RF230_RADIO_STOP ) bRadioStopped = TRUE;
				
			//RX Lock Check
			if (bRxBufLocked) {
				//RX already locked the radio
				bNoSend = TRUE;
			} else {
				//free to send, lock up the radio
				bTxBufLocked = TRUE;
				bNoSend = FALSE;
			}
		}
		
		//radio off - stop send
		if (bRadioStopped) {
			if (post handleSendDone() == FAIL) completeSend();
			return;	
		}
		
		//Try to back off - no lock
		if (bNoSend) {
			doCongestionBackOff();
			return;
		}
		
		//CCA
		if (!(call RF230Control.CCA())) {
IO_DEBUG_TOGGLE(CONGESTION);
			atomic bTxBufLocked = FALSE;
			doCongestionBackOff();
			return;
		}
		
		//Active send
		atomic radioState = RF230_RADIO_SEND_TX;
		call RF230Control.set_PLL_ON();
		
		//signal start symbol
		signal sendCoordinator.startSymbol(8,0,txbufptr);	//p
		
		call HPLRF230.addCRC((uint8_t *) txbufptr);		//add crc	//p
		call HPLRF230.writeFrame(txlength, ((uint8_t *) (txbufptr) +1) );	//length byte added in lower  //p
		
		//Send the packet
		TOSH_SET_RF230_SLP_TR_PIN();
		TOSH_uwait2(1);
		TOSH_CLR_RF230_SLP_TR_PIN();
		
		//NOTE:
		// After a send starts, it takes 16us to initiate the send.
		// The number of bytes is the frame length + lenght byte + sfd + preamble
		// duration = (txlength + 1 + 5) * 32us
		// 1 jiffy is 32us = 1 byte, we add an extra jiffy to cover the
		// setup time
		
IO_DEBUG_SET(SEND_TIMER);

		//set the timer or spin wait
		transitTime = (txlength + 1 + 5) + 1;	
		if (setSendTimer(transitTime) == FAIL) {
			TOSH_uwait2(transitTime << 	5);
			handleTxInt(SUCCESS);
		}
		
		return;
	}
	
	/**
	 *
	 */
	inline void doCongestionBackOff() {
		int16_t backoffValue;
		result_t result;
		
		//back of again
		//backoffValue = signal MacBackoff.congestionBackoff(txbufptr) * IEEE15_4_SYMBOL_TIME;  //p
		backoffValue = signal MacBackoff.congestionBackoff(txbufptr);
		result = setBackoffTimer(backoffValue);
		
		//abort send if backoff fails
		if (result == FAIL) {
			atomic radioState = RF230_RADIO_SEND_FAIL;
			if (post handleSendDone() == FAIL) completeSend();
		} else {
			atomic sendRetries++;	//incrument retries	
		}
		
		//NOTE:
		//Perhaps we should consider a radio reset if the retry exceeds a certain number?
		
	}
	
	/**
	 *
	 */
	inline void completeSend() {
		TOS_MsgPtr oldPtr;
		result_t result;

IO_DEBUG_CLR(TIMING_TX);
		
		atomic {
			//state check
			if (radioState == RF230_RADIO_SEND_DONE) {		//!!! IS THIS ASSUMPTIONS CORRECT???
				result = SUCCESS;
			} else {
				result = FAIL;
			}
			
			//restore states
			bTxBufLocked = FALSE;
			if (radioState != RF230_RADIO_STOP) radioState = RF230_RADIO_IDLE;
			oldPtr = txbufptr;  //p
			
			//restore packet length for retransmissions
			txbufptr->length = txbufptr->length - MSG_HEADER_SIZE - MSG_FOOTER_SIZE;
		}

		//can be called asynchronously!!!
		signal Send.sendDone(oldPtr, result);
	}
	
	
	
/* === Interrupt Handling ================================================== */

	/**
	 *
	 */
	async void event RF230Interrupts.INT_RX_Start() {
		bool bSniffExpired = FALSE;
		
		atomic {
			if (timerState == RF230_TIMER_SNIFF) {
				stopAllTimers();
				bSniffExpired = TRUE;
			}
		}
		
		if (bSniffExpired) signal WakeSequence.sniffExpired(FALSE);
		else signal WakeSequence.IncomingPacket();
		
		//NOTE:
		//ACK PACKETS ALSO TRIGGERS THIS
		
		//NOTE:
		//More accurate if recv coordinator is signaled here.
		//However if this was an incoming wakeup packet then the recv time.
		//stamp is wasted and could back up packet reception.  It could be
		//possible to just start a capture.
		
	}
	
	/**
	 *
	 */	
	async void event RF230Interrupts.INT_TRX_UnderRun() {
		bool bWakeDone;
		
		atomic {
			if (radioState == RF230_RADIO_SEND_WAKEUP) bWakeDone = TRUE;
			else bWakeDone = FALSE;
		}
		
		if (bWakeDone)	handleWakeInt();
		
//		return;  //do nothing
		
// 		uint8_t lRadioState;
// 		atomic lRadioState = radioState;
// 		
// 		switch (lRadioState) {
// 			//TX
// 			case RF230_RADIO_SEND_TX:
// 				handleTxInt(FAIL);
// 				break;

// 			//WAKEUP TX
// 			case RF230_RADIO_SEND_WAKEUP:
// 				//NOTHING TODO???
// 				break;	
// 			
// 			//RX
// 			default:	
// 				//NOTHING TODO???
// 				break;
// 			
// 		}
	}
	
	/**
	 *
	 */
	async void event RF230Interrupts.INT_PLL_Locked() {
		//Not Enabled Ignore!!
	}
	
	/**
	 *
	 */
	async void event RF230Interrupts.INT_TRX_Done() {
		bool txLocked;
		bool bWakeDone;

		atomic {
			txLocked = bTxBufLocked;
			if (radioState == RF230_RADIO_SEND_WAKEUP) bWakeDone = TRUE;
			else bWakeDone = FALSE;
		}
		
		if (!txLocked) handleRxInt();
		else if (bWakeDone)	handleWakeInt();
		
// 		uint8_t lRadioState;
// 		atomic lRadioState = radioState;
// 		
// 		switch (lRadioState) {
// 			
// 			//TX
// 			case RF230_RADIO_SEND_TX:
// 				handleTxInt(SUCCESS);
// 				break;

// 			//WAKEUP TX
// 			case RF230_RADIO_SEND_WAKEUP:
// 				break;	

// 			//FINISHED SEND ACK
// 			//case RF230_RADIO_SEND_ACK:	//never happens
// 			//	break;
// 							
// 			//RX
// 			default:	
// 				handleRxInt();	//send ack done occurs here as well
// 				break;
// 		}
			
		//HANDLE TRX_DONE FOR PREAMBLE SENDS DIFFERENTLY!!!

	}
	
	/**
	 *
	 */
	inline void handleTxInt(result_t status) {
		
		//RX_ON
		call RF230Control.set_RX_ON();
		
		//SEND FAILED
		if (status == FAIL) {
			atomic radioState = RF230_RADIO_SEND_FAIL;
			if (post handleSendDone() == FAIL) completeSend();
			return;
		}
		
		//ACKS
		if (bAckEnabled && (txbufptr->addr != TOS_BCAST_ADDR)) {	//p
			
			//switch to rx_on, wait for e2e ack
			atomic {
				radioState = RF230_RADIO_WAIT_ACK;
				bTxBufLocked = FALSE;  //Release TX lock on radio
			}
			
			if (setAckTimer(2 * RF_230_ACK_DELAY) == FAIL) { // ~1.2ms wait
				//can't start timer terminate now
				atomic radioState = RF230_RADIO_SEND_DONE;
				if (post handleSendDone() == FAIL) completeSend();
			}
			
		} else {
			//NO ACKS
			atomic radioState = RF230_RADIO_SEND_DONE;
			if (post handleSendDone() == FAIL) completeSend();
		}
	}
	
	/**
	 *
	 */
	inline void handleRxInt() {
		bool bBuffLocked = FALSE;
		bool bFinishSend = FALSE;
		bool crcValid;	//throw away
		uint8_t len;

		//State Check
		atomic {
			if (bTxBufLocked || bRxBufLocked || 
				radioState == RF230_RADIO_STOP) 
			bBuffLocked = TRUE;
			else bRxBufLocked = TRUE;
		}
		
		if (bBuffLocked) return;

IO_DEBUG_SET(TIMING_RX);

		//NOTE:
		//This will need to be re-examined.  I signal this before the packet
		//is read in so that i can remove the uncertainty of the read time 
		//caused by the uncertain length of this packet.  However this means
		//i get no access to the content of this packet when it is signaled.
		
		// !! DO NOT READ PACKET !! - not yet read
		signal recvCoordinator.startSymbol (8,0,rxbufptr);
		
		//NOTE:
		//Packet length is FRAME_LENGTH + 1
		//len == Msg->length == FRAME_LENGTH + 1
		
		//Read in the packet
		len = call HPLRF230.readFrameCRC((uint8_t *) rxbufptr);
		
		//crc eror (len == 0) + wake up packets rejected
		if (len == 0 || len < 6) {
			atomic bRxBufLocked = FALSE;
			
IO_DEBUG_CLR(TIMING_RX);

			return;
		}
		
IO_DEBUG_SET(TIMING_RX);
IO_DEBUG_TOGGLE(RX_INT);
		
		//Process ACK MSG - (Races with the ACK Timer fire)
		if ((rxbufptr->fcfhi & 0x07) == IEEE15_4_FCF_TYPE_ACK) {
			
			//NOTE:
			// if timer fired before atomic, the rx can come in between before the radio
			// state was changed.  Then both jiffy timer and this rx int would cause 
			// 2 send done.  If the timer fired after this, thats okay
			
			atomic {
				if ((radioState == RF230_RADIO_WAIT_ACK) &&
					(rxbufptr->dsn == currentDSN)) 
				{
					radioState = RF230_RADIO_SEND_DONE;
					txbufptr->ack = 1;	//p
					stopAllTimers();  //timer could still fire
					bFinishSend = TRUE;
					bRxBufLocked = FALSE;
				}
			}
		}
		
		//Send done waiting for the ack
		if (bFinishSend) {
			if (post handleSendDone() == FAIL) completeSend();
			
IO_DEBUG_CLR(TIMING_RX);

			return;
		}
		
		//NOTE:
		//Type Check below also discards late acks and acks not for me
		
		//Type check - discard all expcept data packets
		if ((rxbufptr->fcfhi & 0x07) != IEEE15_4_FCF_TYPE_DATA) {
			atomic bRxBufLocked = FALSE;
			
IO_DEBUG_CLR(TIMING_RX);

			return;
		}
		
		// - Recv Real Packet - //
		
		//NOTE: Test Only!
		//If a non multihop message just happens to have 0's in
		//this field.  It will also be dropped !!!
		#ifdef IGNORE_NODE0
		if (((TOS_MHopMsg *)rxbufptr->data)->sourceaddr == 0) {
			atomic bRxBufLocked = FALSE;
			return;	
		}
		#endif
		
		//Grab RSSI First
		call RF230Control.getRSSIandCRC(&crcValid, &(rxbufptr->strength));
		
		//ACK
		if ((rxbufptr->addr == TOS_LOCAL_ADDRESS) && 
			(rxbufptr->group == TOS_AM_GROUP)) {
			//send ack
			handleSendAck(rxbufptr->dsn);
	  	}
	  	
	  	//NOTE:
	  	//This generates interrupts you should worry about when the trx-done 
	  	//interrupt fires nothing bad happens and accounted for!
	  
		  	 
		//addr translation
		rxbufptr->addr = fromLSB16 (rxbufptr->addr);
		
		//crc
		rxbufptr->crc = TRUE;	//already passed
		
		//lqi
		rxbufptr->lqi = ((uint8_t *) rxbufptr)[len-1];
		
		//decrement length
		//Length = FRAME + 1
		rxbufptr->length = rxbufptr->length - 1 - MSG_HEADER_SIZE - MSG_FOOTER_SIZE;
		
		post handleRecv();
		
	}

	/**
	 *
	 */
	inline void handleSendAck(uint8_t dsn) {
		Ack_Msg msg;	//declared on the stack
		
		//force radio into pll_on
		call RF230Control.force_TRX_OFF();
		call RF230Control.set_PLL_ON();
		TOSH_uwait2(RF_230_PLL_ON_FAST_SETTLE_TIME_US);	//100us
		
		//Create an ack packet
		msg.length = IEEE15_4_ACK_LENGTH;
		msg.fcfhi = IEEE15_4_DEF_FCF_HI_ACK;
		msg.fcflo = IEEE15_4_DEF_FCF_LO_ACK;
		msg.dsn = dsn;
		
		//Add crc & stuff into fifo
		call HPLRF230.addCRC((uint8_t *) &msg);
		
		call HPLRF230.writeFrame(IEEE15_4_ACK_LENGTH, ((uint8_t *) (&msg)) + 1);
		
		//Send the packet
		TOSH_SET_RF230_SLP_TR_PIN();
		TOSH_uwait2(1);
		TOSH_CLR_RF230_SLP_TR_PIN();
		
IO_DEBUG_SET(ACK_TIMER);

		//wait for packet to finish
		TOSH_uwait2(RF_230_ACK_TRANSMIT_TIME_US);	//400us
		
IO_DEBUG_CLR(ACK_TIMER);
		
		//go back to rx_on
		call RF230Control.set_RX_ON();

		return;
	}
	
/* === Async Jiffy Firing ================================================== */

	//NOTE:
	//NEED to be careful about race condition when it comes to setting timers

		
	/**
	 *
	 */
	inline result_t setBackoffTimer (uint16_t jiffy) {
		result_t result;
		
		if (jiffy == FAILONBACKOFF) return FAIL;
		
		//State check
		atomic {
			if (timerState == RF230_TIMER_IDLE) {
				
				timerState = RF230_TIMER_BACKOFF;
				
				//If no back off, post signal imediately
				if (jiffy == NOBACKOFF) {
					result = post sigJiffyTimer();
				} else {
					call TimerJiffyAsync.setOneShot(jiffy * IEEE15_4_SYMBOL_TIME);
					result = SUCCESS;
				}
			} else {
				result = FAIL;	
			}
		}
		
		return result;
	}
	
	/**
	 *
	 */
	inline result_t setAckTimer (uint16_t jiffy) {
		result_t result;
		
		//State check
		atomic {
			if (timerState == RF230_TIMER_IDLE) {
				result = SUCCESS;
				timerState = RF230_TIMER_ACK;
				call TimerJiffyAsync.setOneShot(jiffy);
			} else {
				result = FAIL;	
			}
		}
		
		return result;
	}
	
	/**
	 *
	 */
	inline result_t setSniffTimer (uint16_t jiffy) {
		result_t result;
		
		//State check
		atomic {
			if (timerState == RF230_TIMER_IDLE) {
				result = SUCCESS;
				timerState = RF230_TIMER_SNIFF;
				call TimerJiffyAsync.setOneShot(jiffy);
			} else {
				result = FAIL;	
			}
		}
		
		return result;
		
	}
	
	/**
	 *
	 */
	inline result_t setSendTimer (uint16_t jiffy) {
		result_t result;
		
		//State check
		atomic {
			if (timerState == RF230_TIMER_IDLE) {
				result = SUCCESS;
				timerState = RF230_TIMER_SEND;
				call TimerJiffyAsync.setOneShot(jiffy);
			} else {
				result = FAIL;	
			}
		}
		
		return result;
	}
	
	/**
	 *
	 */
	inline void	stopAllTimers() {
		atomic timerState = RF230_TIMER_IDLE;
		call TimerJiffyAsync.stop();		
	}

	/**
	 *
	 */	
	async event result_t TimerJiffyAsync.fired() {
		
		uint8_t lTimerState;
		bool bFinishSend;
		
		//Reset Timer State
		atomic {
			lTimerState = timerState;
			timerState = RF230_TIMER_IDLE;
		}

		switch (lTimerState) {
			
			//BACK OFF Timer Fired
			case RF230_TIMER_BACKOFF:
IO_DEBUG_TOGGLE(TRACE);
				tryToSend();
				break;
				
			//ACK TIMED OUT
			case RF230_TIMER_ACK:

				//Try to grab the state
				atomic {
					if (radioState == RF230_RADIO_WAIT_ACK) {
						radioState = RF230_RADIO_SEND_DONE;
						bFinishSend = TRUE;
					} else if (radioState == RF230_RADIO_STOP) {
						radioState = RF230_RADIO_SEND_FAIL;
						bFinishSend = TRUE;
					} else {
						bFinishSend = FALSE;	
					}
				}
				
				//If state grabbed post send done
				if (bFinishSend) {

IO_DEBUG_TOGGLE(ACK_TIMED_OUT);

					if (post handleSendDone() == FAIL) completeSend();
				}
				break;
				
			case RF230_TIMER_SEND:

IO_DEBUG_CLR(SEND_TIMER);

				handleTxInt(SUCCESS);
				break;
				
			case RF230_TIMER_SNIFF:
				//sniff expired and found no activity
				signal WakeSequence.sniffExpired(TRUE);
				break;
				
			default:
				break;
			
		}
		
		return SUCCESS;
	}

/* === Wakeup Sequence Handling ============================================ */
	
	/**
	 *  @brief send a single wake up packet
	 *
	 *	This procedure sends duration number of packets.  For duration 
	 *	parameter, please use the predefined macros pretuned for this purpose.  
	 *	This procesure is split phase.  When complete, sendWakeDone will be 
	 *	signaled.
	 *
	 *  @param duration		how long a wake sequence to send
	 *  @return result_t 	was the send successful
	 */
	async command result_t WakeSequence.sendWake(uint16_t duration) {
		result_t result;
		uint8_t buffer;
		
		atomic {
			//state check & LOCK
			if (radioState != RF230_RADIO_IDLE ||
				bRxBufLocked || bTxBufLocked ) 
			{
				result = FAIL;
			} else {
				radioState = RF230_RADIO_SEND_WAKEUP;
				bTxBufLocked = TRUE;
				wakePacketCount = duration;
				result = SUCCESS;
			}
		}
		
		if (result == FAIL) return result;
		
		//goto tx state

		call RF230Control.set_PLL_ON();
		
		// construct wake packet		
		buffer = RF230_WAKE_FCF_HI;
		call HPLRF230.writeFrame(1, &buffer);
				
		// send out the first wake sequence
		TOSH_SET_RF230_SLP_TR_PIN();
		TOSH_uwait(1);
		TOSH_CLR_RF230_SLP_TR_PIN();
		
// 		// send out the wake sequence
// 		for (i=0;i<duration;i++) {
// 			TOSH_SET_RF230_SLP_TR_PIN();
// 			TOSH_uwait(1);
// 			TOSH_CLR_RF230_SLP_TR_PIN();
// 			TOSH_uwait2(RF230_WAKE_PACKET_DELAY);
// 		}
// 		
// 		//reset radio
// 		#ifdef RESET_AFTER_LONG_WAKEUP
// 			call RF230Control.resetRadio();
// 			call RF230Control.set_RX_ON();
// 			TOSH_uwait2(RF_230_RX_ON_SETTLE_TIME_US);

// 		#endif
// 		
// 		atomic {
// 			radioState = RF230_RADIO_IDLE;
// 			bTxBufLocked = FALSE;
// 		}
// 		
// 		//go backto tx state
// 		call RF230Control.set_RX_ON();
		
		return SUCCESS;
	}
	
	
	/**
	 *
	 */
	inline void handleWakeInt() {
		bool bDone;
		
		//NOTE:
		//We assume wake sequence duration is >= 1
		//we incrument first since packet count was first set without decrement
		
		atomic {
			if (--wakePacketCount == 0) {
				bDone = TRUE;
				radioState = RF230_RADIO_IDLE;
				bTxBufLocked = FALSE;
			} else {
				bDone = FALSE;
			}
		}
		
		if (bDone) {

			//clean up the state
			call RF230Control.set_RX_ON();
			signal WakeSequence.sendWakeDone(SUCCESS);
			
		} else {
			//not done send more
			TOSH_SET_RF230_SLP_TR_PIN();
			TOSH_uwait(1);
			TOSH_CLR_RF230_SLP_TR_PIN();
		}
	}

	
		
	/**
	 *  @brief monitor for incoming traffic for jiifies(32us) units of time.
	 *
	 *  @param jiffies		32us * jiffes before expiring
	 *  @return result_t	was the set correct
	 */
	async command result_t WakeSequence.startSniff(uint16_t us) {
		return setSniffTimer( (us>>5) + 1);
	}
	
/* === Default Events ====================================================== */

	default event TOS_MsgPtr Receive.receive(TOS_MsgPtr msg) {
		return msg;
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
		return ((call Random.rand () & 0xF) + 1); //xin change 2.27.06
	}

	default async event void sendCoordinator.
		startSymbol (uint8_t bitsPerBlock, uint8_t offset, TOS_MsgPtr msgBuff) {
	}

	default async event void sendCoordinator.byte (TOS_MsgPtr msg,
															uint8_t byteCount) {
	}
	
	default async event void sendCoordinator.blockTimer() { }

	default async event void recvCoordinator.
		startSymbol (uint8_t bitsPerBlock, uint8_t offset, TOS_MsgPtr msgBuff) {
	}

	default async event void recvCoordinator.byte (TOS_MsgPtr msg,
															uint8_t byteCount) {
	}
	
	default async event void recvCoordinator.blockTimer() { }
	
	default async event void WakeSequence.IncomingPacket() { }
	
	default async event void WakeSequence.sniffExpired(bool channelClear) { }
}
