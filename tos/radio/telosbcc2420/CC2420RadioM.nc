/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: CC2420RadioM.nc,v 1.1.4.1 2007/04/27 05:04:19 njain Exp $
 */


/*  
 *  Authors: Joe Polastre
 *  Date last modified: $Revision: 1.1.4.1 $
 *
 * This module provides the layer2 functionality for the mica2 radio.
 * While the internal architecture of this module is not CC2420 specific,
 * It does make some CC2420 specific calls via CC2420Control.
 * 
 * $Id: CC2420RadioM.nc,v 1.1.4.1 2007/04/27 05:04:19 njain Exp $
 */

/**
 * @author Joe Polastre
 * @author Alan Broad, Crossbow
 */

includes byteorder;

module CC2420RadioM {
  provides {
    interface StdControl;
    interface SplitControl;
    interface BareSendMsg as Send;
    interface ReceiveMsg as Receive;
    interface RadioCoordinator as RadioSendCoordinator;
    interface RadioCoordinator as RadioReceiveCoordinator;
    interface MacControl;
    interface MacBackoff;
    interface RadioPower;
  }
  uses {
    interface SplitControl as CC2420SplitControl;
    interface CC2420Control;
    interface HPLCC2420 as HPLChipcon;
    interface HPLCC2420FIFO as HPLChipconFIFO; 
    interface HPLCC2420Interrupt as FIFOP;
    interface HPLCC2420Capture as SFD;
    interface StdControl as TimerControl;
    interface TimerJiffyAsync as BackoffTimerJiffy;
    interface Random;
    interface Leds;
  }
}

implementation {
  enum {
    DISABLED_STATE = 0,
    IDLE_STATE,
    TX_STATE,
    TX_WAIT,
    PRE_TX_STATE,
    POST_TX_STATE,
    POST_TX_ACK_STATE,
    RX_STATE,
    POWER_DOWN_STATE,
    WARMUP_STATE,

    TIMER_INITIAL = 0,
    TIMER_BACKOFF,
    TIMER_ACK
  };

#define MAX_SEND_TRIES 8

  norace uint8_t countRetry;
  uint8_t stateRadio;
  norace uint8_t stateTimer;
  norace uint8_t currentDSN;
  norace bool bAckEnable;
  bool bPacketReceiving;
  uint8_t txlength;
  norace TOS_MsgPtr txbufptr;  // pointer to transmit buffer
  norace TOS_MsgPtr rxbufptr;  // pointer to receive buffer
  TOS_Msg RxBuf;	// save received messages

  volatile uint16_t LocalAddr;

  ///**********************************************************
  //* local function definitions
  //**********************************************************/

   void sendFailed() {
     atomic stateRadio = IDLE_STATE;
     txbufptr->length = txbufptr->length - MSG_HEADER_SIZE - MSG_FOOTER_SIZE;
     signal Send.sendDone(txbufptr, FAIL);
   }

   void flushRXFIFO() {
     call FIFOP.disable();
     call HPLChipcon.read(CC2420_RXFIFO);          //flush Rx fifo
     call HPLChipcon.cmd(CC2420_SFLUSHRX);
     call HPLChipcon.cmd(CC2420_SFLUSHRX);
     atomic bPacketReceiving = FALSE;
     call FIFOP.startWait(FALSE);
   }

   inline result_t setInitialTimer( uint16_t jiffy ) {
     stateTimer = TIMER_INITIAL;
     return call BackoffTimerJiffy.setOneShot(jiffy);
   }

   inline result_t setBackoffTimer( uint16_t jiffy ) {
     stateTimer = TIMER_BACKOFF;
     return call BackoffTimerJiffy.setOneShot(jiffy);
   }

   inline result_t setAckTimer( uint16_t jiffy ) {
     stateTimer = TIMER_ACK;
     return call BackoffTimerJiffy.setOneShot(jiffy);
   }

  /***************************************************************************
   * PacketRcvd
   * - Radio packet rcvd, signal 
   ***************************************************************************/
   task void PacketRcvd() {
     TOS_MsgPtr pBuf;

     atomic {
       pBuf = rxbufptr;
     }
     pBuf = signal Receive.receive((TOS_MsgPtr)pBuf);
     atomic {
       if (pBuf) rxbufptr = pBuf;
       rxbufptr->length = 0;
       bPacketReceiving = FALSE;
     }
   }

  
  task void PacketSent() {
    TOS_MsgPtr pBuf; //store buf on stack 

    atomic {
      stateRadio = IDLE_STATE;
      pBuf = txbufptr;
      pBuf->length = pBuf->length - MSG_HEADER_SIZE - MSG_FOOTER_SIZE;
    }

    signal Send.sendDone(pBuf,SUCCESS);
  }

  //**********************************************************
  //* Exported interface functions for Std/SplitControl
  //* StdControl is deprecated, use SplitControl
  //**********************************************************/
  
  // This interface is depricated, please use SplitControl instead
  command result_t StdControl.init() {
    return call SplitControl.init();
  }

  // Split-phase initialization of the radio
  command result_t SplitControl.init() {

    atomic {
      stateRadio = DISABLED_STATE;
      currentDSN = 0;
      bAckEnable = FALSE;
      bPacketReceiving = FALSE;
      rxbufptr = &RxBuf;
      rxbufptr->length = 0;
    }

    call TimerControl.init();
    call Random.init();
    LocalAddr = TOS_LOCAL_ADDRESS;
    return call CC2420SplitControl.init();
  }

  event result_t CC2420SplitControl.initDone() {
    return signal SplitControl.initDone();
  }

  default event result_t SplitControl.initDone() {
    return SUCCESS;
  }
  
  // This interface is depricated, please use SplitControl instead
  command result_t StdControl.stop() {
    return call SplitControl.stop();
  }

  // split phase stop of the radio stack
  command result_t SplitControl.stop() {
    atomic stateRadio = DISABLED_STATE;

    call SFD.disable();
    call FIFOP.disable();
    call TimerControl.stop();
    return call CC2420SplitControl.stop();
  }

  event result_t CC2420SplitControl.stopDone() {
    return signal SplitControl.stopDone();
  }

  default event result_t SplitControl.stopDone() {
    return SUCCESS;
  }

  // This interface is depricated, please use SplitControl instead
  command result_t StdControl.start() {
    return call SplitControl.start();
  }

  // split phase start of the radio stack (wait for oscillator to start)
  command result_t SplitControl.start() {
    uint8_t chkstateRadio;

    atomic chkstateRadio = stateRadio;

    if (chkstateRadio == DISABLED_STATE) {
      atomic {
	stateRadio = WARMUP_STATE;
        countRetry = 0;
        rxbufptr->length = 0;
      }
      call TimerControl.start();
      return call CC2420SplitControl.start();
    }
    return FAIL;
  }

  event result_t CC2420SplitControl.startDone() {
    uint8_t chkstateRadio;

    atomic chkstateRadio = stateRadio;

    if (chkstateRadio == WARMUP_STATE) {
      call CC2420Control.RxMode();
      //enable interrupt when pkt rcvd
      call FIFOP.startWait(FALSE);
      // enable start of frame delimiter timer capture (timestamping)
      call SFD.enableCapture(TRUE);
      
      atomic stateRadio  = IDLE_STATE;
    }
    signal SplitControl.startDone();
    return SUCCESS;
  }

  default event result_t SplitControl.startDone() {
    return SUCCESS;
  }

  /************* END OF STDCONTROL/SPLITCONTROL INIT FUNCITONS **********/

  /**
   * Try to send a packet.  If unsuccessful, backoff again
   **/
  void sendPacket() {
    uint8_t status;

    call HPLChipcon.cmd(CC2420_STXONCCA);
    status = call HPLChipcon.cmd(CC2420_SNOP);
    if ((status >> CC2420_TX_ACTIVE) & 0x01) {
      // wait for the SFD to go high for the transmit SFD
      call SFD.enableCapture(TRUE);
    }
    else {
      // try again to send the packet
      atomic stateRadio = PRE_TX_STATE;
      if (!(setBackoffTimer(signal MacBackoff.congestionBackoff(txbufptr) * CC2420_SYMBOL_UNIT))) {
        sendFailed();
      }
    }
  }

  /**
   * Captured an edge transition on the SFD pin
   * Useful for time synchronization as well as determining
   * when a packet has finished transmission
   */
  async event result_t SFD.captured(uint16_t time) {
    switch (stateRadio) {
    case TX_STATE:
      // wait for SFD to fall--indicates end of packet
      call SFD.enableCapture(FALSE);
      // if the pin already fell, disable the capture and let the next
      // state enable the cpature (bug fix from Phil Buonadonna)
      if (!TOSH_READ_CC_SFD_PIN()) {
	call SFD.disable();
      }
      else {
	stateRadio = TX_WAIT;
      }
      // fire TX SFD event
      txbufptr->time = time;
      signal RadioSendCoordinator.startSymbol(8,0,txbufptr);
      // if the pin hasn't fallen, break out and wait for the interrupt
      // if it fell, continue on the to the TX_WAIT state
      if (stateRadio == TX_WAIT) {
	break;
      }
    case TX_WAIT:
      // end of packet reached
      stateRadio = POST_TX_STATE;
      call SFD.disable();
      // revert to receive SFD capture
      call SFD.enableCapture(TRUE);
      // if acks are enabled and it is a unicast packet, wait for the ack
      if ((bAckEnable) && (txbufptr->addr != TOS_BCAST_ADDR)) {
        if (!(setAckTimer(CC2420_ACK_DELAY)))
          sendFailed();
      }
      // if no acks or broadcast, post packet send done event
      else {
        if (!post PacketSent())
          sendFailed();
      }
      break;
    default:
      // fire RX SFD handler
      rxbufptr->time = time;
      signal RadioReceiveCoordinator.startSymbol(8,0,rxbufptr);
    }
    return SUCCESS;
  }

  /**
   * Start sending the packet data to the TXFIFO of the CC2420
   */
  task void startSend() {
    // flush the tx fifo of stale data
    if (!(call HPLChipcon.cmd(CC2420_SFLUSHTX))) {
      sendFailed();
      return;
    }
    // write the txbuf data to the TXFIFO
    if (!(call HPLChipconFIFO.writeTXFIFO(txlength+1,(uint8_t*)txbufptr))) {
      sendFailed();
      return;
    }
  }

  /**
   * Check for a clear channel and try to send the packet if a clear
   * channel exists using the sendPacket() function
   */
  void tryToSend() {
     uint8_t currentstate;
     atomic currentstate = stateRadio;

     // and the CCA check is good
     if (currentstate == PRE_TX_STATE) {

       // if a FIFO overflow occurs or if the data length is invalid, flush
       // the RXFIFO to get back to a normal state.
       if ((!TOSH_READ_CC_FIFO_PIN() && !TOSH_READ_CC_FIFOP_PIN())) {
         flushRXFIFO();
       }

       if (TOSH_READ_RADIO_CCA_PIN()) {
         atomic stateRadio = TX_STATE;
         sendPacket();
       }
       else {
	 // if we tried a bunch of times, the radio may be in a bad state
	 // flushing the RXFIFO returns the radio to a non-overflow state
	 // and it continue normal operation (and thus send our packet)
         if (countRetry-- <= 0) {
	   flushRXFIFO();
	   countRetry = MAX_SEND_TRIES;
	   if (!post startSend())
	     sendFailed();
           return;
         }
         if (!(setBackoffTimer(signal MacBackoff.congestionBackoff(txbufptr) * CC2420_SYMBOL_UNIT))) {
           sendFailed();
         }
       }
     }
  }

  /**
   * Multiplexed timer to control initial backoff, 
   * congestion backoff, and delay while waiting for an ACK
   */
  async event result_t BackoffTimerJiffy.fired() {
    uint8_t currentstate;
    atomic currentstate = stateRadio;

    switch (stateTimer) {
    case TIMER_INITIAL:
      if (!(post startSend())) {
        sendFailed();
      }
      break;
    case TIMER_BACKOFF:
      tryToSend();
      break;
    case TIMER_ACK:
      if (currentstate == POST_TX_STATE) {
        txbufptr->ack = 0;
        if (!post PacketSent())
	  sendFailed();
      }
      break;
    }
    return SUCCESS;
  }

 /**********************************************************
   * Send
   * - Xmit a packet
   *    USE SFD FALLING FOR END OF XMIT !!!!!!!!!!!!!!!!!! interrupt???
   * - If in power-down state start timer ? !!!!!!!!!!!!!!!!!!!!!!!!!s
   * - If !TxBusy then 
   *   a) Flush the tx fifo 
   *   b) Write Txfifo address
   *    
   **********************************************************/
  command result_t Send.send(TOS_MsgPtr pMsg) {
    uint8_t currentstate;
    atomic currentstate = stateRadio;

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
      pMsg->addr = toLSB16(pMsg->addr);
      // adjust the data length to now include the full packet length
      pMsg->length = pMsg->length + MSG_HEADER_SIZE + MSG_FOOTER_SIZE;
      // keep the DSN increasing for ACK recognition
      pMsg->dsn = ++currentDSN;
      // reset the time field
      pMsg->time = 0;
      // FCS bytes generated by CC2420
      txlength = pMsg->length - MSG_FOOTER_SIZE;  
      txbufptr = pMsg;
      countRetry = MAX_SEND_TRIES;

      if (setInitialTimer(signal MacBackoff.initialBackoff(txbufptr) * CC2420_SYMBOL_UNIT)) {
        atomic stateRadio = PRE_TX_STATE;
        return SUCCESS;
      }
    }
    return FAIL;

  }
  
  /**
   * Delayed RXFIFO is used to read the receive FIFO of the CC2420
   * in task context after the uC receives an interrupt that a packet
   * is in the RXFIFO.  Task context is necessary since reading from
   * the FIFO may take a while and we'd like to get other interrupts
   * during that time, or notifications of additional packets received
   * and stored in the CC2420 RXFIFO.
   */
  void delayedRXFIFO();

  task void delayedRXFIFOtask() {
    delayedRXFIFO();
  }

  void delayedRXFIFO() {
    uint8_t len = MSG_DATA_SIZE;  
    uint8_t _bPacketReceiving;

    if ((!TOSH_READ_CC_FIFO_PIN()) && (!TOSH_READ_CC_FIFOP_PIN())) {
        flushRXFIFO();
	return;
    }

    atomic {
      _bPacketReceiving = bPacketReceiving;
      
      if (_bPacketReceiving) {
	if (!post delayedRXFIFOtask())
	  flushRXFIFO();
      } else {
	bPacketReceiving = TRUE;
      }
    }
    
    // JP NOTE: TODO: move readRXFIFO out of atomic context to permit
    // high frequency sampling applications and remove delays on
    // interrupts being processed.  There is a race condition
    // that has not yet been diagnosed when RXFIFO may be interrupted.
    if (!_bPacketReceiving) {
      if (!call HPLChipconFIFO.readRXFIFO(len,(uint8_t*)rxbufptr)) {
	atomic bPacketReceiving = FALSE;
	if (!post delayedRXFIFOtask()) {
	  flushRXFIFO();
	}
	return;
      }      
    }
    flushRXFIFO();
  }
  

  /**********************************************************
   * FIFOP lo Interrupt: Rx data avail in CC2420 fifo
   * Radio must have been in Rx mode to get this interrupt
   * If FIFO pin =lo then fifo overflow=> flush fifo & exit
   * 
   *
   * Things ToDo:
   *
   * -Disable FIFOP interrupt until PacketRcvd task complete 
   * until send.done complete
   *
   * -Fix mixup: on return
   *  rxbufptr->rssi is CRC + Correlation value
   *  rxbufptr->strength is RSSI
   **********************************************************/
   async event result_t FIFOP.fired() {

     //     call Leds.yellowToggle();

     // if we're trying to send a message and a FIFOP interrupt occurs
     // and acks are enabled, we need to backoff longer so that we don't
     // interfere with the ACK
     if (bAckEnable && (stateRadio == PRE_TX_STATE)) {
       if (call BackoffTimerJiffy.isSet()) {
         call BackoffTimerJiffy.stop();
         call BackoffTimerJiffy.setOneShot((signal MacBackoff.congestionBackoff(txbufptr) * CC2420_SYMBOL_UNIT) + CC2420_ACK_DELAY);
       }
     }

     /** Check for RXFIFO overflow **/     
     if (!TOSH_READ_CC_FIFO_PIN()){
       flushRXFIFO();
       return SUCCESS;
     }

     atomic {
	 if (post delayedRXFIFOtask()) {
	   call FIFOP.disable();
	 }
	 else {
	   flushRXFIFO();
	 }
     }

     // return SUCCESS to keep FIFOP events occurring
     return SUCCESS;
  }

  /**
   * After the buffer is received from the RXFIFO,
   * process it, then post a task to signal it to the higher layers
   */
  async event result_t HPLChipconFIFO.RXFIFODone(uint8_t length, uint8_t *data) {
    // JP NOTE: rare known bug in high contention:
    // radio stack will receive a valid packet, but for some reason the
    // length field will be longer than normal.  The packet data will
    // be valid up to the correct length, and then will contain garbage
    // after the correct length.  There is no currently known fix.
    uint8_t currentstate;
    atomic { 
      currentstate = stateRadio;
    }

    // if a FIFO overflow occurs or if the data length is invalid, flush
    // the RXFIFO to get back to a normal state.
    if ((!TOSH_READ_CC_FIFO_PIN() && !TOSH_READ_CC_FIFOP_PIN()) 
        || (length == 0) || (length > MSG_DATA_SIZE)) {
      flushRXFIFO();
      atomic bPacketReceiving = FALSE;
      return SUCCESS;
    }

    rxbufptr = (TOS_MsgPtr)data;

    // check for an acknowledgement that passes the CRC check
    if (bAckEnable && (currentstate == POST_TX_STATE) &&
         ((rxbufptr->fcfhi & 0x07) == CC2420_DEF_FCF_TYPE_ACK) &&
         (rxbufptr->dsn == currentDSN) &&
         ((data[length-1] >> 7) == 1)) {
      atomic {
        txbufptr->ack = 1;
        txbufptr->strength = data[length-2];
        txbufptr->lqi = data[length-1] & 0x7F;
        currentstate = POST_TX_ACK_STATE;
        bPacketReceiving = FALSE;
      }
      if (!post PacketSent())
	sendFailed();
      return SUCCESS;
    }

    // check for invalid packets
    // an invalid packet is a non-data packet with the wrong
    // addressing mode (FCFLO byte)
    if (((rxbufptr->fcfhi & 0x07) != CC2420_DEF_FCF_TYPE_DATA) ||
         (rxbufptr->fcflo != CC2420_DEF_FCF_LO)) {
      flushRXFIFO();
      atomic bPacketReceiving = FALSE;
      return SUCCESS;
    }

    rxbufptr->length = rxbufptr->length - MSG_HEADER_SIZE - MSG_FOOTER_SIZE;

    if (rxbufptr->length > TOSH_DATA_LENGTH) {
      flushRXFIFO();
      atomic bPacketReceiving = FALSE;
      return SUCCESS;
    }

    // adjust destination to the right byte order
    rxbufptr->addr = fromLSB16(rxbufptr->addr);
 
    // if the length is shorter, we have to move the CRC bytes
    rxbufptr->crc = data[length-1] >> 7;
    // put in RSSI
    rxbufptr->strength = data[length-2];
    // put in LQI
    rxbufptr->lqi = data[length-1] & 0x7F;

    atomic {
      if (!post PacketRcvd()) {
	bPacketReceiving = FALSE;
      }
    }

    if ((!TOSH_READ_CC_FIFO_PIN()) && (!TOSH_READ_CC_FIFOP_PIN())) {
        flushRXFIFO();
	return SUCCESS;
    }

    if (!(TOSH_READ_CC_FIFOP_PIN())) {
      if (post delayedRXFIFOtask())
	return SUCCESS;
    }
    flushRXFIFO();
    //    call FIFOP.startWait(FALSE);

    return SUCCESS;
  }

  /**
   * Notification that the TXFIFO has been filled with the data from the packet
   * Next step is to try to send the packet
   */
  async event result_t HPLChipconFIFO.TXFIFODone(uint8_t length, uint8_t *data) { 
     tryToSend();

     return SUCCESS;
  }

  /** Enable link layer hardware acknowledgements **/
  async command void MacControl.enableAck() {
    atomic bAckEnable = TRUE;
    call CC2420Control.enableAddrDecode();
    call CC2420Control.enableAutoAck();
  }

  /** Disable link layer hardware acknowledgements **/
  async command void MacControl.disableAck() {
    atomic bAckEnable = FALSE;
    call CC2420Control.disableAddrDecode();
    call CC2420Control.disableAutoAck();
  }
  /**
   * Enable CC2420 Receiver Hardware Address Decode.
   *
   * @param void
   * @return void
   */
  async command void MacControl.enableAddrDecode () {
    call CC2420Control.enableAddrDecode ();
//    bAckManual = TRUE;
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
//    bAckManual = TRUE;		//enable promiscuous Ack
  }

  async event result_t HPLChipcon.FIFOPIntr() {
    return SUCCESS;
  }

  /*===Unimplemented Commands/Events===========================================*/
  
  command result_t RadioPower.SetTransmitMode (uint8_t power) {
    return SUCCESS;
  }

  command result_t RadioPower.SetListeningMode (uint8_t power) {
    return SUCCESS;
  }

  /**
   * How many basic time periods to back off.
   * Each basic time period consists of 20 symbols (16uS per symbol)
   */
  default async event int16_t MacBackoff.initialBackoff(TOS_MsgPtr m) {
    return (call Random.rand() & 0xF) + 1;
  }
  /**
   * How many symbols to back off when there is congestion 
   * (16uS per symbol * 20 symbols/block)
   */
  default async event int16_t MacBackoff.congestionBackoff(TOS_MsgPtr m) {
    return (call Random.rand() & 0x3F) + 1;
  }

// Default events for radio send/receive coordinators do nothing.
// Be very careful using these, you'll break the stack.
// The "byte()" event is never signalled because the CC2420 is a packet
// based radio.
default async event void RadioSendCoordinator.startSymbol(uint8_t bitsPerBlock, uint8_t offset, TOS_MsgPtr msgBuff) { }
default async event void RadioSendCoordinator.byte(TOS_MsgPtr msg, uint8_t byteCount) { }
default async event void RadioReceiveCoordinator.startSymbol(uint8_t bitsPerBlock, uint8_t offset, TOS_MsgPtr msgBuff) { }
default async event void RadioReceiveCoordinator.byte(TOS_MsgPtr msg, uint8_t byteCount) { }

}
