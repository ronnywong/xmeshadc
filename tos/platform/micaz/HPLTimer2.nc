/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: HPLTimer2.nc,v 1.2.4.1 2007/04/26 21:48:29 njain Exp $
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

/***************************************************************************** 
$Log: HPLTimer2.nc,v $
Revision 1.2.4.1  2007/04/26 21:48:29  njain
CVS: Please enter a Bugzilla bug number on the next line.
BugID: 1100

CVS: Please enter the commit log message below.
License header modified in each file for MoteWorks_2_0_F release

Revision 1.2  2006/01/06 03:07:40  xyang
Timer2 Fix, TimerM consolidated with LP timer, new Timer interface

Revision 1.2  2005/03/02 22:45:00  jprabhu
Added Log CVS-Tag

*****************************************************************************/
module HPLTimer2 {
    provides interface Clock as Timer2;
    provides interface StdControl;
	uses interface Leds;
}
implementation
{

#define  JIFFY_SCALE 0x4 //cpu clk/256 ~ 32uSec
#define  JIFFY_INTERVAL 2
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
      
      call Timer2.setRate(mi, ms);
      return SUCCESS;
    }

    command result_t StdControl.stop() {
      uint8_t mi;
      atomic {
	mi = minterval;
      }
      call Timer2.setRate(mi, 0);
      return SUCCESS;
    }


    async command void Timer2.setInterval(uint8_t value) {
        outp(value, OCR2);
    } 
    async command void Timer2.setNextInterval(uint8_t value) {
      atomic {
	minterval = value;
	set_flag = 1;
      }
    }

    async command uint8_t Timer2.getInterval() {
        return inp(OCR2);
    }

    async command uint8_t Timer2.getScale() {
      uint8_t ms;
		atomic {
		ms = mscale;
		}
      return ms;
    }

    async command void Timer2.setNextScale(uint8_t scale) {
      atomic {
	nextScale= scale;
        set_flag=1;
      }
    }
       

    async command result_t Timer2.setIntervalAndScale(uint8_t interval, uint8_t scale) {
        
        if (scale >7) return FAIL;
        scale|=0x8;
	atomic {
	  outp(0, TCCR2);	  //stop the timer
		cbi(TIMSK, OCIE2);
		cbi(TIMSK, TOIE2);  //clear interrupts
		mscale = scale;
		minterval = interval;
		outp(0,TCNT2);		  
		outp(interval, OCR2);
		sbi(TIFR,OCF2);	//clear Timer2 OCF flag by writing 1
		sbi(TIMSK, OCIE2);
		outp(scale, TCCR2);	 //start the timer
	}
    return SUCCESS;
    } //setIntervalandScale

  async command result_t Timer2.setRate(char interval, char scale) {
    scale &= 0x7;
    scale |= 0x8;
    atomic {
      cbi(TIMSK, TOIE2);
      cbi(TIMSK, OCIE2);     //Disable TC0 interrupt
	  outp(0, TCCR2);	  //stop the clock
      //outp(0, TCNT0);
      outp(0, TCNT2);
      outp(interval, OCR2);
      sbi(TIMSK, OCIE2);
      outp(scale, TCCR2);  //start the clock  
    }
    return SUCCESS;
  }

        
    async command uint8_t Timer2.readCounter() {
        return (inp(TCNT2));
    }

    async command void Timer2.setCounter(uint8_t n) {
        outp(n, TCNT2);
    }


    async command void Timer2.intEnable() {
	sbi(TIMSK, OCIE2); // enable timer1 interupt
}
    async command void Timer2.intDisable() {
	cbi(TIMSK, OCIE2); // disable timer1 interupt
}


  default async event result_t Timer2.fire() { return SUCCESS; }

  TOSH_INTERRUPT(SIG_OUTPUT_COMPARE2) {
    atomic {
	if (set_flag) {
		mscale = nextScale;
		nextScale|=0x8;
		outp(nextScale, TCCR2);
		outp(minterval, OCR2);
		set_flag=0;
		}
    }  //set
    signal Timer2.fire();
  }

}//HPLTimer2
