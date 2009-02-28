/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: PowerControlM.nc,v 1.1.4.1 2007/04/27 05:32:33 njain Exp $
 */
 
/*
 *
 * Power Control Component for mtp400ca
 *
 *
 * Authors: Hu Siquan <husq@xbow.com>
 *
 */


module PowerControlM
{
    provides interface SplitControl as PowerControl;
    uses interface Timer as PowerStabalizingTimer;
}
implementation
{
	#define VOLTAGE_STABLE_TIME 10
	  enum {OFF, WARMUP, ON};
      uint8_t state;


  	command result_t PowerControl.init() {
  		state = OFF;
        return SUCCESS;  		
  		}	
	
	command result_t PowerControl.start() {
	  // power mtp400 up
  		TOSH_CLR_PW7_PIN();	  
      // wait how many usecs to stablize the power supply of adc?
	  atomic state = WARMUP;
      call PowerStabalizingTimer.start(TIMER_ONE_SHOT, VOLTAGE_STABLE_TIME);	
      return SUCCESS; 
    }

     event result_t PowerStabalizingTimer.fired() {  
	   state = ON;
	   signal PowerControl.startDone();
       return SUCCESS;
    }
    
    command result_t PowerControl.stop() {
  		TOSH_SET_PW7_PIN();    	
  		state = OFF;
        return SUCCESS;      	
    	
    }
    
   default event result_t PowerControl.initDone()
  {
 	return SUCCESS;
  }
  default event result_t PowerControl.startDone()
  {
 	return SUCCESS;
  }
  default event result_t PowerControl.stopDone()
  {
 	return SUCCESS;
  }

  
}
