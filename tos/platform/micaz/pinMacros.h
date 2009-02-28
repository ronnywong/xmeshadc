/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: pinMacros.h,v 1.3.4.1 2007/04/26 21:52:21 njain Exp $
 */

/**
 * @author Xin Yang, Crossbow
 */

 /* Last Modified: $Date: 2007/04/26 21:52:21 $
  *
  * $Log: pinMacros.h,v $
  * Revision 1.3.4.1  2007/04/26 21:52:21  njain
  * CVS: Please enter a Bugzilla bug number on the next line.
  * BugID: 1100
  *
  * CVS: Please enter the commit log message below.
  * License header modified in each file for MoteWorks_2_0_F release
  *
  * Revision 1.3  2006/01/16 01:16:27  xyang
  * bug fix
  *
  * Revision 1.2  2006/01/16 00:57:18  xyang
  * Turned off all debugging pins & commands
  *
  * Revision 1.1  2006/01/16 00:24:08  xyang
  * Moved debugging file pinMacros.h to platform level
  *
  * Revision 1.1  2006/01/06 03:09:27  xyang
  * Unified MicaZ stack.
  *
  * Revision 1.2  2005/10/09 22:48:20  xyang
  *
  * First Implemenation of async MicaZ LP Mac layer.
  *
  */ 

#ifndef DEBUG_PINS__
#define DEBUG_PINS__

///////////////////////////////////////
// DEBUG PIN USAGE DEFINES
// - comment out these for release
///////////////////////////////////////
//#define USE_ADC_PINS
//#define DEBUG_POWER_MODE

///////////////////////////////////////
// Main Macro Functions
///////////////////////////////////////

#define IO_DEBUG_SET(name) DEBUG_##name##_SET()
#define IO_DEBUG_CLR(name) DEBUG_##name##_CLR()
#define IO_DEBUG_TOGGLE(name) {DEBUG_##name##_SET(); TOSH_uwait(50); DEBUG_##name##_CLR();}

///////////////////////////////////////
// PIN_ASSIGNMENTS
///////////////////////////////////////

#ifdef USE_ADC_PINS
	TOSH_ASSIGN_PIN(ADC1,F,1);
	TOSH_ASSIGN_PIN(ADC2,F,2);
	TOSH_ASSIGN_PIN(ADC3,F,3);

void setDebugPinDirection() {
	TOSH_MAKE_ADC1_OUTPUT();
	TOSH_MAKE_ADC2_OUTPUT();
	TOSH_MAKE_ADC3_OUTPUT();
		
}

#endif

///////////////////////////////////////
// CC2420_RADIOM
///////////////////////////////////////

#define DEBUG_TIMING_TEST_SET() 	//TOSH_SET_PW4_PIN()		//TIMING_TEST
#define DEBUG_TIMING_TEST_CLR() 	//TOSH_CLR_PW4_PIN()
#define DEBUG_CCA_SET()		  		//TOSH_SET_PW3_PIN()		//CCA
#define DEBUG_CCA_CLR()				//TOSH_CLR_PW3_PIN()
#define DEBUG_START_STOP_SET()		//TOSH_SET_ADC1_PIN()		//START_STOP
#define DEBUG_START_STOP_CLR()		//TOSH_CLR_ADC1_PIN()

#define DEBUG_TIMING_RX_SET()   	//TOSH_SET_PW6_PIN()	//TIMING_RX
#define DEBUG_TIMING_RX_CLR()   	//TOSH_CLR_PW6_PIN()

///////////////////////////////////////
// SLOTTEDSENDM
///////////////////////////////////////

#define DEBUG_DATA_PACKET_SET()		//TOSH_SET_PW5_PIN()		//Sent data packet
#define DEBUG_DATA_PACKET_CLR()		//TOSH_CLR_PW5_PIN() 
#define DEBUG_ASYNC_RECV_TEST_SET() //TOSH_SET_PW6_PIN() 	//async Recv
#define DEBUG_ASYNC_RECV_TEST_CLR()	//TOSH_CLR_PW6_PIN() 
#define DEBUG_SNIFF_TIMER_SET()		//TOSH_SET_PW5_PIN() 	//Sniff Timer
#define DEBUG_SNIFF_TIMER_CLR()		//TOSH_CLR_PW5_PIN() 
#define DEBUG_ASYNC_DATA_RECV_SET()	//TOSH_SET_ADC2_PIN()		//Async Recv
#define DEBUG_ASYNC_DATA_RECV_CLR()	//TOSH_CLR_ADC2_PIN() 
#define DEBUG_FALSE_WAKEUP_SET()	//TOSH_SET_PW5_PIN()	//False Wakeup
#define DEBUG_FALSE_WAKEUP_CLR()	//TOSH_CLR_PW5_PIN()		
#define DEBUG_LOST_PREAMBLE_SET()	//TOSH_SET_PW6_PIN()	//Lost Preamble
#define DEBUG_LOST_PREAMBLE_CLR()	//TOSH_CLR_PW6_PIN()		
#define DEBUG_ERROR_COND_SET()		//TOSH_SET_PW6_PIN()	//Error Condition
#define DEBUG_ERROR_COND_CLR()		//TOSH_CLR_PW6_PIN()	
#define DEBUG_TRACE_SET()			//TOSH_SET_PW6_PIN()		//Code Tracing
#define DEBUG_TRACE_CLR()			//TOSH_CLR_PW6_PIN()

///////////////////////////////////////
// TIMERM
///////////////////////////////////////

#define DEBUG_TIMING_START_SET()				//TOSH_SET_PW3_PIN()	//Timer start
#define DEBUG_TIMING_START_CLR()				//TOSH_CLR_PW3_PIN()
#define DEBUG_TIMING_SIGNAL_ONE_TIMER_SET()		//TOSH_SET_PW6_PIN()	//Fired Many times (one for each registered)
#define DEBUG_TIMING_SIGNAL_ONE_TIMER_CLR()		//TOSH_CLR_PW6_PIN()
#define DEBUG_TIMING_HANDLE_FIRE_SET() 			//TOSH_SET_PW3_PIN()	//Posted only once
#define DEBUG_TIMING_HANDLE_FIRE_CLR() 			//TOSH_CLR_PW3_PIN()				
#define DEBUG_TIMING_FIRE_SET() 				//TOSH_SET_PW6_PIN()	//async interrupt fire
#define DEBUG_TIMING_FIRE_CLR() 				//TOSH_CLR_PW6_PIN()

///////////////////////////////////////
// HPLCC2420M
///////////////////////////////////////

#define DEBUG_FIFOP_INT_SET()				//TOSH_SET_PW5_PIN()	//FIFOP Enable/disable
#define DEBUG_FIFOP_INT_CLR()				//TOSH_CLR_PW5_PIN()	
#define DEBUG_RX_INT_SET() 					//TOSH_SET_PW4_PIN()	//FIFOP Intrpt signal to return time
#define DEBUG_RX_INT_CLR() 					//TOSH_CLR_PW4_PIN()

///////////////////////////////////////
// HPLPOWERMANAGEMENTM
///////////////////////////////////////

#define DEBUG_sm0_SET()			//TOSH_SET_PW1_PIN()
#define DEBUG_sm0_CLR()			//TOSH_CLR_PW1_PIN()
#define DEBUG_sm1_SET()			//TOSH_SET_PW2_PIN()
#define DEBUG_sm1_CLR()			//TOSH_CLR_PW2_PIN()
#define DEBUG_sm2_SET()			//TOSH_SET_PW3_PIN()
#define DEBUG_sm2_CLR()			//TOSH_CLR_PW3_PIN()
#define DEBUG_POWER_ADJUST_SET()	//TOSH_SET_PW6_PIN()
#define DEBUG_POWER_ADJUST_CLR()	//TOSH_CLR_PW6_PIN()

#endif

