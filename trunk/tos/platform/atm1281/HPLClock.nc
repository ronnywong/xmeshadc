/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: HPLClock.nc,v 1.1.2.2 2007/04/26 00:05:02 njain Exp $
 */

/**
 * HPLClock.nc - Hardeware presentation layer of the asyncrhonous clock.
 *
 * This module is Atmega1281 specific.  It uses only output compare register
 * OCR2A.  It operates in CTC mode and is setup to interrupt only on compare.
 *
 * <pre>
 *	$Id: HPLClock.nc,v 1.1.2.2 2007/04/26 00:05:02 njain Exp $
 * </pre>
 *
 * @author Jason Hill
 * @author David Gay
 * @author Philip Levis
 * @author Hu Siquan
 * @author Xin Yang
 * @date March 21 2006
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
        outp(value, OCR2A);  //1281
    } 
    async command void Clock.setNextInterval(uint8_t value) {
      atomic {
		minterval = value;
		set_flag = 1;
      }
    }

    async command uint8_t Clock.getInterval() {
        return inp(OCR2A);  //1281
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
       

    /**
     *  No longer used in the way that it was origionally intended.  This command
     *  Should be the lower lvl implementation.  The setRate command should translate
     *  platform or rate independent setting to raw settings and then call this.  Call
     *  this command if you know the precise interval and scale.  Call setRate if you
     *  don't.
     */
    async command result_t Clock.setIntervalAndScale(uint8_t interval, uint8_t scale) {
	    //TCCR2A - NormalA, NormalB, CTC
		//TCCR2B - Prescale
		
		if (scale>7) return FAIL;		//3 bits wide
		
	    atomic {
	      cbi(TIMSK2, TOIE2);			//Disable overflow, never reenable
	      cbi(TIMSK2, OCIE2A);	        //Disable output compare interrupt
	      
	      //set Timer/Counter2 to be asynchronous
	      //from the CPU clock with a second external
	      //clock(32,768kHz)driving it.
	      sbi(ASSR, AS2);

	      mscale = scale;				//save scale
		  minterval = interval;			//save interval
			
	      outp( (2 << WGM20) , TCCR2A);	//CTC Mode
	      outp(scale, TCCR2B);    		//prescale the timer (start)

	      outp(0, TCNT2);				//reset counter
	      outp(interval, OCR2A);		//set output compare value
	      sbi(TIMSK2, OCIE2A);			//reenable compare interrupts
	    }
	    return SUCCESS;
	}
        
    async command uint8_t Clock.readCounter() {
        return (inp(TCNT2));
    }

    async command void Clock.setCounter(uint8_t n) {
        outp(n, TCNT2);
    }

    async command void Clock.intDisable() {
        cbi(TIMSK2, OCIE2A);
    }
    async command void Clock.intEnable() {
        sbi(TIMSK2, OCIE2A);
    }

    /**
     *  This command should only accpet predefined chars so that it may
     *  translate the preset values to actual raw values which gets the 
     *  correct result.  Right now it is just a straight pass through.
     *
     */
    async command result_t Clock.setRate(char interval, char scale) {
		return call Clock.setIntervalAndScale(interval, scale);
    }

  	default async event result_t Clock.fire() { return SUCCESS; }

  //1281
  TOSH_INTERRUPT(SIG_OUTPUT_COMPARE2A) {
    atomic {
      if (set_flag) {
		mscale = nextScale;
		outp(nextScale, TCCR2B);  //1281
		outp(minterval, OCR2A);   //1281
		set_flag=0;
      }
    }
    signal Clock.fire();
  }

}
