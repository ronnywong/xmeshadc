/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: HPLClock.nc,v 1.1.4.1 2007/04/26 00:09:26 njain Exp $
 */
 
/*
 *
 * Authors:		Jason Hill, David Gay, Philip Levis
 * Date last modified:  6/25/02
 *
 */

// The Mica-specific parts of the hardware presentation layer.


/**
 * @author Jason Hill
 * @author David Gay
 * @author Philip Levis
 */

module HPLClock {
    provides interface Clock;
    provides interface StdControl;

}
implementation
{
    uint8_t set_flag;
    uint8_t mscale, nextScale, minterval ;

    command result_t StdControl.init() {
      atomic {
	mscale = DEFAULT_SCALE; 
	minterval = DEFAULT_INTERVAL;
      }
      return SUCCESS;
    }

    command result_t StdControl.start() {
      uint8_t mi, ms;
      atomic {
	mi = minterval;
	ms = mscale;
      }
      
      call Clock.setRate(mi, ms);
      return SUCCESS;
    }

    command result_t StdControl.stop() {
      uint8_t mi;
      atomic {
	mi = minterval;
      }

      call Clock.setRate(mi, 0);
      return SUCCESS;
    }


    async command void Clock.setInterval(uint8_t value) {
        outp(value, OCR0);
    } 
    async command void Clock.setNextInterval(uint8_t value) {
      atomic {
	minterval = value;
	set_flag = 1;
      }
    }

    async command uint8_t Clock.getInterval() {
        return inp(OCR0);
    }

    async command uint8_t Clock.getScale() {
      uint8_t ms;
      atomic {
	ms = mscale;
      }
      
      return ms;
    }

    async command void Clock.setNextScale(uint8_t scale) {
      atomic {
	nextScale= scale;
        set_flag=1;
      }
    }
       

    async command result_t Clock.setIntervalAndScale(uint8_t interval, uint8_t scale) {
        
        if (scale >7) return FAIL;
        scale|=0x8;
	atomic {
	  cbi(TIMSK, OCIE0);
	  outp(scale, TCCR0);
	  mscale = scale;
	  outp(0,TCNT0);
	  outp(interval, OCR0);
	  minterval = interval;
	  sbi(TIMSK, OCIE0);
	}
        return SUCCESS;
    }
        
    async command uint8_t Clock.readCounter() {
        return (inp(TCNT0));
    }

    async command void Clock.setCounter(uint8_t n) {
        outp(n, TCNT0);
    }

    async command void Clock.intDisable() {
        cbi(TIMSK, OCIE0);
    }
    async command void Clock.intEnable() {
        sbi(TIMSK, OCIE0);
    }

  async command result_t Clock.setRate(char interval, char scale) {
    scale &= 0x7;
    scale |= 0x8;
    atomic {
      cbi(TIMSK, TOIE0);
      cbi(TIMSK, OCIE0);     //Disable TC0 interrupt
      sbi(ASSR, AS0);        //set Timer/Counter0 to be asynchronous
      //from the CPU clock with a second external
      //clock(32,768kHz)driving it.
      outp(scale, TCCR0);    //prescale the timer to be clock/128 to make it
      outp(0, TCNT0);
      outp(interval, OCR0);
      sbi(TIMSK, OCIE0);
    }
    return SUCCESS;
  }

  default async event result_t Clock.fire() { return SUCCESS; }
  TOSH_INTERRUPT(SIG_OUTPUT_COMPARE0) {
    atomic {
      if (set_flag) {
	mscale = nextScale;
	nextScale|=0x8;
	outp(nextScale, TCCR0);
	
	outp(minterval, OCR0);
	set_flag=0;
      }
    }
    signal Clock.fire();
  }

}
