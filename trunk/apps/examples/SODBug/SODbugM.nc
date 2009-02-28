/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: SODbugM.nc,v 1.1.4.1 2007/04/26 19:32:58 njain Exp $
 */

 
 module SODbugM {
	 
	provides {
	    interface StdControl;
	}
	uses {
		
		//Timer
		interface StdControl as TimerControl;
		interface Timer as UpdateTimer;

    	//Leds
		interface Leds;
	}
	 
 }
 
 
 implementation {
     #define DBG_PKT  1
     #define SO_DEBUG  1

     #include "SOdebug.h"
/*===Local state and buffer =================================================*/

	
/*===StdControl =============================================================*/

	command result_t StdControl.init() {
		call TimerControl.init();
		call Leds.init();
		return SUCCESS;
	}
	
	command result_t StdControl.start() {
		//start the update timer
		call UpdateTimer.start(TIMER_REPEAT, 1000);
 		return SUCCESS;
	}
	
	command result_t StdControl.stop() {
		call UpdateTimer.stop();
		return SUCCESS;		
	}
	
/*===Timer Fire =============================================================*/
	
	event result_t UpdateTimer.fired() {		
       SODbg (DBG_PKT, "This is a hex output: %x\n", 127);
       SODbg (DBG_PKT, "This is a +decimal output: %d \n", 9999);
       SODbg (DBG_PKT, "This is a -decimal output: %d \n", -9999);
	   SODbg (DBG_PKT, "This is a string output:%s \n", "HI");
       call Leds.redToggle();  
	   return SUCCESS;
	}
	
	  
 }
