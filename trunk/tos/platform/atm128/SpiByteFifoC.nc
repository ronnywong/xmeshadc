/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: SpiByteFifoC.nc,v 1.1.4.1 2007/04/26 00:11:40 njain Exp $
 */
 
/*
 *
 */
module SpiByteFifoC
{
  provides interface SpiByteFifo;
  uses interface SlavePin;
}
implementation
{
  uint8_t nextByte;
  uint8_t state;

  enum {
    IDLE,
    FULL,
    OPEN,
    READING
  };

  enum {
    BIT_RATE = 20 * 4 / 2 * 5/4
  };


  TOSH_SIGNAL(SIG_SPI) {
    uint8_t temp = inp(SPDR);
    // Assume state == FULL (we've missed a deadline and are dead if it
    // isn't...)
    outp(nextByte, SPDR);
    state = OPEN;
#ifdef CANBY
    // added these two lines to see if we can get arround the lack of wire
    // between the two pins-- Lakshman
    TOSH_MAKE_FLASH_SELECT_OUTPUT();
    TOSH_CLR_FLASH_SELECT_PIN();
#endif /* CANBY */
    signal SpiByteFifo.dataReady(temp);
  }

  async command result_t SpiByteFifo.send(uint8_t data) {
    result_t rval = FAIL;
    atomic {
      if(state == OPEN){
	nextByte = data;	
	state = FULL;
	rval = SUCCESS;
      }
      else if(state == IDLE){
	state = OPEN;
	signal SpiByteFifo.dataReady(0);
	call SlavePin.low();
	cbi(PORTB, 7);
	sbi(DDRB, 7);
	outp(0xc0, SPCR);
	outp(data, SPDR);
	//set the radio to TX.
	TOSH_CLR_RFM_CTL0_PIN();
	TOSH_SET_RFM_CTL1_PIN();
	//start the timer.
	cbi(TIMSK, TOIE2);
	cbi(TIMSK, OCIE2);
	outp(0, TCNT2);
	outp(BIT_RATE, OCR2);
	outp(0x19, TCCR2);
	rval = SUCCESS;
      }
    }
    return rval;
  }

  async command result_t SpiByteFifo.idle() {
    atomic {
      outp(0x00, SPCR);
      outp(0x00, SPDR);
      outp(0x00, TCCR2);
      nextByte = 0;
      call SlavePin.high(FALSE);
      TOSH_MAKE_RFM_TXD_OUTPUT();
      TOSH_CLR_RFM_TXD_PIN();
      TOSH_CLR_RFM_CTL0_PIN();
      TOSH_CLR_RFM_CTL1_PIN();
      state = IDLE;
      nextByte = 0;
    }
    return SUCCESS;
  }

  async command result_t SpiByteFifo.startReadBytes(uint16_t timing) {
    uint8_t oldState;
    // This state transition is sufficient because no other
    // function can execute when in the READING state. That is,
    // except txMode() and idle(), but they only modify the RFM control
    // pins, which this function doesn't deal with. - pal
    atomic { 
      oldState = state;
      if (state == IDLE) {
	state = READING;
      }
    }
    if(oldState == IDLE){
      //		MAKE_ONE_WIRE_OUTPUT();
      //		CLR_ONE_WIRE_PIN();
      call SlavePin.low();
      outp(0x00, SPCR);
      cbi(PORTB, 7);
      sbi(DDRB, 7);
      outp(0x0, TCCR2);
      outp(0x1, TCNT2);
      outp(BIT_RATE, OCR2);
      //don't change the radio state.
      timing += (400-19);
      if(timing > 0xfff0) timing = 0xfff0;
      //set the phase of the clock line
      outp(0x19, TCCR2);
      outp(BIT_RATE - 20, TCNT2);
      while(inp(PINB) & 0x80){;}
      while(__inw(TCNT1L) < timing){outp(0x0,TCNT2);}
      outp(0xc0, SPCR);
#ifdef CANBY
      // added these two lines to see if we can get arround the lack of wire
      // between the two pins-- Lakshman
      TOSH_MAKE_FLASH_SELECT_OUTPUT();
      TOSH_CLR_FLASH_SELECT_PIN();
#endif /* CANBY */
      outp(0x00, SPDR);
      sbi(PORTB, 6);
      cbi(PORTB, 6);
      return SUCCESS;
    }
    return FAIL;
  }

  async command result_t SpiByteFifo.txMode() {
    atomic {
      TOSH_CLR_RFM_CTL0_PIN();
      TOSH_SET_RFM_CTL1_PIN();
    }
    return SUCCESS;
  }

  async command result_t SpiByteFifo.rxMode() {
    atomic {
      TOSH_CLR_RFM_TXD_PIN();
      TOSH_MAKE_RFM_TXD_INPUT();
      TOSH_SET_RFM_CTL0_PIN();
      TOSH_SET_RFM_CTL1_PIN();
#ifdef CANBY
      // added these two lines to see if we can get arround the lack of wire
      // between the two pins-- Lakshman
      TOSH_MAKE_FLASH_SELECT_OUTPUT();
      TOSH_CLR_FLASH_SELECT_PIN();
#endif
    }
    return SUCCESS;
  }
  
  async command result_t SpiByteFifo.phaseShift() {
    unsigned char f;
    atomic {
      f = inp(TCNT2);
      if(f > 20) f -= 20;
      outp(f, TCNT2);
    }
    return SUCCESS;
  }

  event result_t SlavePin.notifyHigh() {
    return SUCCESS;
  }
}
