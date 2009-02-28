/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: ChannelMonC.nc,v 1.1.4.1 2007/04/26 00:23:24 njain Exp $
 */

module ChannelMonC {
  provides interface ChannelMon;
  uses {
    interface Random;
  }
}
implementation {
  enum {
    IDLE_STATE,
    START_SYMBOL_SEARCH,
    PACKET_START,
    DISABLED_STATE
  };

  enum {
    SAMPLE_RATE = 100/2*4
  };

  unsigned short CM_search[2];
  char CM_state;
  unsigned char CM_lastBit;
  unsigned char CM_startSymBits;
  short CM_waiting;

  async command result_t ChannelMon.init() {
    atomic {
      CM_waiting = -1;
    }
    return call ChannelMon.startSymbolSearch();
  }
  
  async command result_t ChannelMon.startSymbolSearch() {
    atomic {
      //Reset to idle state.
      CM_state = IDLE_STATE;
      //set the RFM pins.
      TOSH_SET_RFM_CTL0_PIN();
      TOSH_SET_RFM_CTL1_PIN();
      TOSH_CLR_RFM_TXD_PIN();
#ifdef CANBY
      // added these two lines to see if we can get arround the lack of wire
      // between the two pins-- Lakshman
      TOSH_MAKE_FLASH_SELECT_OUTPUT();
      TOSH_CLR_FLASH_SELECT_PIN();
#endif /* CANBY */
      cbi(TIMSK, OCIE2); //clear interrupts
      cbi(TIMSK, TOIE2);  //clear interrupts
      cbi(TIMSK, OCIE2); //clear interrupts
      outp(0x09, TCCR2); //scale the counter
      outp(SAMPLE_RATE, OCR2); // set upper byte of comp reg.
      sbi(TIMSK, OCIE2); // enable timer1 interupt
      outp(0x00, TCNT2); // clear current counter value
      sbi(DDRB, 6);
    }
    return SUCCESS;
  }



  TOSH_SIGNAL(SIG_OUTPUT_COMPARE2) {
    uint8_t bit = TOSH_READ_RFM_RXD_PIN();
    atomic { // Unnecessary, but nesC doesn't understand SIGNAL
      //fire the bit arrived event and send up the value.
      if (CM_state == IDLE_STATE) {
	CM_search[0] <<= 1;
	CM_search[0] = CM_search[0] | (bit & 0x1);
	if(CM_waiting != -1){
	  CM_waiting --;
	  if(CM_waiting == 1){
	    if ((CM_search[0] & 0xfff) == 0) {
	      CM_waiting = -1;
	      signal ChannelMon.idleDetect();
	    }else{
	      CM_waiting = (call Random.rand() & 0x1f) + 30;
	    } 
	  }
	}
	if ((CM_search[0] & 0x777) == 0x707){
	  CM_state = START_SYMBOL_SEARCH;
	  CM_search[0] = CM_search[1] = 0;
	  CM_startSymBits = 30;
	}
      }else if(CM_state == START_SYMBOL_SEARCH){
	unsigned int current = CM_search[CM_lastBit];
	CM_startSymBits--;
	if (CM_startSymBits == 0){
	  CM_state = IDLE_STATE;
	}
	if (CM_state != IDLE_STATE) {
	  current <<= 1;
	  current &=  0x1ff;  // start symbol is 9 bits
	  if(bit) current |=  0x1;  // start symbol is 9 bits
	  if (current == 0x135) {
	    cbi(TIMSK, OCIE2); 
	    CM_state = IDLE_STATE;
	    signal ChannelMon.startSymDetect();
	  }
	  if (CM_state != IDLE_STATE) {
	    CM_search[CM_lastBit] = current;
	    CM_lastBit ^= 1;
	  }
	}
      }
    }
    return;
  }

  async command result_t ChannelMon.stopMonitorChannel() {
    //disable timer
    atomic {
      cbi(TIMSK, OCIE2); 
      CM_state = DISABLED_STATE;
    }
    return SUCCESS;
  }

  async command result_t ChannelMon.macDelay() {
    atomic {
      CM_search[0] = 0xff;
      if(CM_waiting == -1) {
	CM_waiting = (call Random.rand() & 0x2f) + 80;
      }
    }

    return SUCCESS;
  }
}
