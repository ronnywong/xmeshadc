/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: HPLTimer1M.nc,v 1.2.2.2 2007/04/26 00:06:17 njain Exp $
 */

/**
 * HPLTimer1M.nc - Hardeware presentation layer of Timer1.
 *
 * This module is Atmega1281 specific.  It uses only output compare register
 * OCR1A for timing.  It also provides input capture abilties. It operates in 
 * Normal mode for timer and can be setup to interrupt on compare or capture.
 *
 * <pre>
 *	$Id: HPLTimer1M.nc,v 1.2.2.2 2007/04/26 00:06:17 njain Exp $
 * </pre>
 *
 * @date March 21 2006
 */

includes HPLTimer1;

module HPLTimer1M
{
  provides interface StdControl;
  provides interface Clock16 as Timer1;
//  provides interface TimerControl as ControlT1;
//  provides interface TimerCompare as CompareT1;
  provides interface TimerCapture as CaptureT1;

}
implementation
{

/*===TOS Timer Interface Implementation =====================================*/

    volatile uint8_t set_flag;
    volatile uint8_t mscale;
    volatile uint8_t nextScale;
    volatile uint16_t minterval;

    command result_t StdControl.init() {
      atomic {
		mscale = TCLK_CPU_DIV256; 
		minterval = TIMER1_DEFAULT_INTERVAL;
      }
      return SUCCESS;
    }

    command result_t StdControl.start() {
      uint16_t mi;
      uint8_t  ms;
      atomic {
		mi = minterval;
		ms = mscale;
      }
      call Timer1.setRate(mi, ms);
      return SUCCESS;
    } //start

    command result_t StdControl.stop() {
      uint16_t mi;
      atomic {
		mi = minterval;
      }
      call Timer1.setRate(mi, 0);	   //default scale=0=OFF
      return SUCCESS;
    }


    async command void Timer1.setInterval(uint16_t value) {
        atomic OCR1A = value;	 //defined in  local/avr/include/avr/sfr_defs.h
    } 
    async command void Timer1.setNextInterval(uint16_t value) {
      atomic {
		minterval = value;
		set_flag = 1;
      }
    }				  

    async command uint16_t Timer1.getInterval() {
		uint16_t i;
		atomic i = OCR1A;
        return i;
    }

    async command uint8_t Timer1.getScale() {
      uint8_t ms;
		atomic {
			ms = mscale;
		}
      return ms;
    }

    async command void Timer1.setNextScale(uint8_t scale) {
      atomic {
		nextScale= scale;
        set_flag=1;
      }
    }
       

    async command result_t Timer1.setIntervalAndScale(uint16_t interval, uint8_t scale) {
        
        if (scale >7) return FAIL;	//3 bits wide
        
        scale|=0x8;					//set Clear on Timer Compare
		atomic {
			outp(0, TCCR1B);		//stop the timer
			
			cbi(TIMSK1, OCIE1A);	//disable output compare interrupts
			cbi(TIMSK1, TOIE1);		//disable Overflow interrupts			
			cbi(TIMSK1, ICIE1);		//disable input capture interrupts
			
			mscale = scale;
			minterval = interval;
			
			outp(0,TCCR1A);			//normal operation for all
			TCNT1 = 0;		 	//clear the 16bit count 
			OCR1A = interval;	//set the compare value
			sbi(TIFR1,OCF1A);		//clear Timer1A OCF flag by writing 1
			sbi(TIMSK1, OCIE1A);	//enable OCIE1A interrupt
			outp(scale, TCCR1B);	//starts the timer with scale
		}
	    return SUCCESS;
    } //setIntervalandScale

  async command result_t Timer1.setRate(uint16_t interval, char scale) {
   //same as .setIntervalAndScale but does not set mscale/minterval
   //Do NOT enable INTERRUPT
   
    scale &= 0x7;				//3 bits wide
    scale |= 0x8;				//set Clear on Timer Compare
    atomic {
		outp(0, TCCR1B);		//stop the timer
			
		cbi(TIMSK1, OCIE1A);	//disable output compare interrupts
		cbi(TIMSK1, TOIE1);		//disable Overflow interrupts			
		cbi(TIMSK1, ICIE1);		//disable input capture interrupts
			
		outp(0,TCCR1A);			//normal operation for all
		TCNT1 = 0;		 	//clear the 16bit count 
		OCR1A = interval;	//set the compare value
		sbi(TIFR1,OCF1A);		//clear Timer1A OCF flag by writing 1
		sbi(TIMSK1, OCIE1A);	//enable OCIE1A interrupt
		outp(scale, TCCR1B);	//starts the timer with scale
	}
    return SUCCESS;
  }

        
    async command uint16_t Timer1.readCounter() {
		uint16_t i;
		atomic i = TCNT1;
        return (i);  //read time count
    }

    async command void Timer1.setCounter(uint16_t n) {
        TCNT1 = n;
    }


    async command void Timer1.intEnable() {
		sbi(TIMSK1, OCIE1A); // enable timer1 interupt
	}
    async command void Timer1.intDisable() {
		cbi(TIMSK1, OCIE1A); // disable timer1 interupt
	}


  default async event result_t Timer1.fire() { return SUCCESS; }

  TOSH_INTERRUPT(SIG_OUTPUT_COMPARE1A) {
    atomic {
		if (set_flag) {
			mscale = nextScale;
			nextScale|=0x8;
			outp(nextScale, TCCR1B);  //update the clock scale
			OCR1A = minterval;  //update the compare value
			set_flag=0;
		}
    }  //set
    signal Timer1.fire();
  }

  
/*===Timer Control & Timer Capture Interface Implementation =================*/

  /**
   * Default Captured event
   *
   */	
  default async event void CaptureT1.captured(uint16_t time) { }

  /**
   * Set the edge that the capture should occur
   *
   */
  async command void CaptureT1.setEdge(uint8_t LowToHigh) {
	  
	  if( LowToHigh )
	   sbi(TCCR1B,ICES1);	//rising edge
	  else
	   cbi(TCCR1B,ICES1);	//falling edge

	  sbi(TIFR1, ICF1);		//clear any pending interrupt
	  return;
  }

  /**
   * Not Implemented
   *
   */
  async command void CaptureT1.setSynchronous(bool synch) {
  	return;
  }

  /**
   * Determine if a capture overflow is pending.
   *
   */
  async command bool CaptureT1.isOverflowPending() {
	  return( inp(TIFR1) & TOV1 );
  }
  

  /**
   * Reads the value of the last capture event in TxCCRx
   *
   */
  async command uint16_t CaptureT1.getEvent() {
// 	  volatile uint16_t i;
// 	  atomic i = inp(ICR1);  //suspicious
// 	  return (i);
	  return inw(ICR1);
  }

  /**
   * Clear the capture overflow flag for when multiple captures occur
   *
   */
  async command void CaptureT1.clearOverflow() {
	  sbi(TIFR1,TOV1);
	  return;
  }

  /**
   * Clear the capture interrupt flag for when multiple captures occur
   *
   */
  async command void CaptureT1.clearPendingInterrupt() {
	  sbi(TIFR1, ICF1);	//clear any pending interrupt
	  return;
  }


  /**
   * Enable interrupts on capture.  
   *
   * Note: that if a capture event occured while events are disable
   *	it will be delayed until the flag is cleared or serviced when
   *	events are reenabled.
   *
   */
  async command void CaptureT1.enableEvents() {
	  //put TIMER into Normal, capture mode
	  cbi(TCCR1B,WGM10);
	  cbi(TCCR1B,WGM11);
	  cbi(TCCR1B,WGM12);
	  cbi(TCCR1B,WGM13);
	  sbi(TIMSK1, ICIE1);
  }

  /**
   * Disable interrupt on capture
   *
   */
  async command void CaptureT1.disableEvents() {
	  cbi(TIMSK1, ICIE1); //disable
	  sbi(TIFR1, ICF1);	  //clear any pending interrupt
  }


  /**
   *
   */
  async command bool CaptureT1.areEventsEnabled() { 
	  return (inp(TIMSK1) & ICIE1);
  }


   /**
    * INPUT CAPTURE Interrupt Service Routine
    * Signal when an event is captured.
    * global interrupts are disabled in this handler
    *
    */
  TOSH_SIGNAL(SIG_INPUT_CAPTURE1)
  {	  
      signal CaptureT1.captured(call CaptureT1.getEvent());
  }
  
  
//******************************************************************
#ifdef COMPARE
//Count Compare Mode 

  async command uint16_t CompareT1.getEvent() {   }


  async command void CompareT1.setEvent( uint16_t x ) { }

  async command void CompareT1.setEventFromPrev( uint16_t x ) { }

  async command void CompareT1.setEventFromNow( uint16_t x ) {  }

  default async event void CompareT1.fired() { }

#endif


}//HPLTimer1M.nc

