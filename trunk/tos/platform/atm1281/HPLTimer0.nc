/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: HPLTimer0.nc,v 1.2.2.2 2007/04/26 00:05:52 njain Exp $
 */

/**
 * HPLClock.nc - Hardeware presentation layer of Timer0.
 *
 * This module is Atmega1281 specific.  It uses only output compare register
 * OCR0A.  It operates in Normal mode and is setup to interrupt only on compare.
 *
 * <pre>
 *	$Id: HPLTimer0.nc,v 1.2.2.2 2007/04/26 00:05:52 njain Exp $
 * </pre>
 *
 * @author Jason Hill
 * @author David Gay
 * @author Philip Levis
 * @author Hu Siquan
 * @author Xin Yang
 * @date March 21 2006
 */

/***************************************************************************** 
$Log: HPLTimer0.nc,v $
Revision 1.2.2.2  2007/04/26 00:05:52  njain
CVS: Please enter a Bugzilla bug number on the next line.
BugID: 1100

CVS: Please enter the commit log message below.
License header modified in each file for MoteWorks_2_0_F release

Revision 1.2.2.1  2007/01/12 10:46:01  lwei
CVS: Please enter a Bugzilla bug number on the next line.
BugID:
CVS: Please enter the commit log message below.
1.  Commit the 2.0.E RC1 version for new M2110 M2100 M9100 M4100 Platform, it need to use the new toolchain for 1281 and RF230.
CVS: ----------------------------------------------------------------------
CVS: Enter Log. Lines beginning with `CVS:' are removed automatically
CVS:
CVS: Committing in <DIRECTORY NAME>
CVS:
CVS: Modified Files:
CVS: Tag: MoteWorks_2_0_RELEASE_BRANCH
CVS: <FILE1> <FILE2> ... <FILEn>
CVS: ----------------------------------------------------------------------

Revision 1.2  2006/07/10 22:08:53  rkapur
Updating MAIN to 2.1 tree

Revision 1.1.2.1  2006/06/06 21:53:10  xyang
RCB230 Initial Check in

Revision 1.1  2006/03/23 04:25:13  husq
Update micazb drivers adapt to MoteWorks tree

Revision 1.2  2006/01/06 03:07:40  xyang
Timer0 Fix, TimerM consolidated with LP timer, new Timer interface

Revision 1.2  2005/03/02 22:45:00  jprabhu
Added Log CVS-Tag

*****************************************************************************/

module HPLTimer0 {
    provides interface Clock as Timer0;
    provides interface StdControl;
	uses interface Leds;
}

implementation {

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
      
      call Timer0.setRate(mi, ms);
      return SUCCESS;
    }

    command result_t StdControl.stop() {
      uint8_t mi;
      atomic {
		mi = minterval;
      }
      call Timer0.setRate(mi, 0);
      return SUCCESS;
    }


    async command void Timer0.setInterval(uint8_t value) {
        outp(value, OCR0A);
    }
    
    async command void Timer0.setNextInterval(uint8_t value) {
      atomic {
		minterval = value;
		set_flag = 1;
      }
    }

    async command uint8_t Timer0.getInterval() {
        return inp(OCR0A);
    }

    async command uint8_t Timer0.getScale() {
      uint8_t ms;
		atomic {
			ms = mscale;
		}
      return ms;
    }

    async command void Timer0.setNextScale(uint8_t scale) {
      atomic {
		nextScale= scale;
        set_flag=1;
      }
    }
       

    /**
     *  No longer used in the way that interface was origionally intended.  This command
     *  Should be the lower lvl implementation.  The setRate command should translate
     *  platform or rate independent setting to raw settings and then call this.  Call
     *  this command if you know the precise interval and scale.  Call setRate if you
     *  don't.
     */
    async command result_t Timer0.setIntervalAndScale(uint8_t interval, uint8_t scale) {
	   	//TCCR0A - NormalA, NormalB, WGM NORMAL
		//TCCR0B - Prescale
        
        if (scale>7) return FAIL;	//3 bits wide

		atomic {
	  		outp(0, TCCR0B);	  	//stop the timer
	  		
	  		cbi(TIMSK0, TOIE0);  	//Disable overflow int, never reenable
			cbi(TIMSK0, OCIE0A);	//Disable output compare int
			
			mscale = scale;			//save scale
			minterval = interval;	//save interval
			
			outp(0,TCNT0);		  	//reset counter
			outp(interval, OCR0A);  //set output compare value
			
			sbi(TIFR0, OCF0A);		//clear Timer0 OCF flag by writing 1
			sbi(TIMSK0, OCIE0A);	//reenable compare interrupts
			
	      	outp(0, TCCR0A);    	//Normal, don't want ctc
	      	outp(scale, TCCR0B);    //set prescale, (start timer)
		}
	
    	return SUCCESS;
    } //setIntervalandScale

    /**
     *  This command should only accpet predefined chars so that it may
     *  translate the preset values to actual raw values.  After this
     *  translation is should call setIntervalAndScale.  This way it 
     *  abstracts the different oscillators options nicely.  Right now
     *  it is just a straight pass through.
     *
     */
  	async command result_t Timer0.setRate(char interval, char scale) {
   		return call Timer0.setIntervalAndScale(interval, scale);
  	}

        
    async command uint8_t Timer0.readCounter() {
        return (inp(TCNT0));
    }

    async command void Timer0.setCounter(uint8_t n) {
        outp(n, TCNT0);
    }


    async command void Timer0.intEnable() {
		sbi(TIMSK0, OCIE0A); // enable timer0 interupt
	}
	
    async command void Timer0.intDisable() {
		cbi(TIMSK0, OCIE0A); // disable timer0 interupt
	}


  default async event result_t Timer0.fire() { return SUCCESS; }

  TOSH_INTERRUPT(SIG_OUTPUT_COMPARE0A) {
    atomic {
		if (set_flag) {
			mscale = nextScale;
			outp(nextScale, TCCR0B);
			outp(minterval, OCR0A);
			set_flag=0;
		}
    }  //set
    signal Timer0.fire();
  }

}//HPLTimer0
