/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: RF230InterruptsM.nc,v 1.1.2.2 2007/04/27 05:02:05 njain Exp $
 */

 
module RF230InterruptsM {
	provides {
		interface StdControl as InterruptControl;
		interface RF230Interrupts;
	}
	
	uses {
		interface HPLRF230;	//spi access
		interface TimerCapture; //capture
		
		interface PowerManagement;
		//NOTE:
		//We use the interrupts enabled/disabled as the mechanism to determine
		//Radio status.  When interrupts are disabled we assume that the radio
		//sleeps and thus the processor can also sleep.
		
		//NOTE:
		//To enable capture with time stamps will need to start timer.
	}
}

implementation {
	#include "pinMacros.h"
	
/* === Module State ======================================================== */

	//STATELESS
	//TRX_KNOWN_IRQS - defined in RF230Consts.h
	
/* === StdControl ========================================================== */

	command result_t InterruptControl.init() {
		//add timer init if capture needs running counter
		return SUCCESS;
	}
	
	command result_t InterruptControl.start() {
		//add timer start if capture needs running counter
		
		//setup rf230 interrupt mask
		//call HPLRF230.writeReg(RG_IRQ_MASK, TRX_KNOWN_IRQS);  //move this to controlM

		//capture - set edge, clears pending interrupts
		call TimerCapture.setEdge(1);	//low2high
		
		//do not enable events here - done in radioRaw
		
		return SUCCESS;
	}
	
	command result_t InterruptControl.stop() {
		//add timer stop if capture needs running counter
		//call TimerCapture.disableEvents();  //also clears pending interrupts
		//call PowerManagement.adjustPower();
		return SUCCESS;
	}
	
	
/* === Capture events ====================================================== */
	
	/**
	 *	@brief handle the interrupt associated with the captued event
	 *
	 */
	async event void TimerCapture.captured(uint16_t time) {
		//NOTE:
		//Ignore the time value since timer not on
		
		//BIG NOTE:
		//This interrupt is handled with interrupts off!
		//So if you plan to spin in anywhere along this call and 
		//hope that another interrupt will come and stop your spin, this will
		//not happen.
		
		volatile uint8_t irqStatus;
		
		irqStatus = call HPLRF230.readReg(RG_IRQ_STATUS);
		irqStatus &= TRX_KNOWN_IRQS;
		
		#ifdef OUTPUT_IRQ_STATUS
		PORTA = irqStatus; //DEBUG!!!
		#endif
				
		//RX_START
		if (irqStatus & TRX_IRQ_RX_START) {
			signal RF230Interrupts.INT_RX_Start();
		} 
		
		//TRX_DONE
		if (irqStatus & TRX_IRQ_TRX_END) {
			signal RF230Interrupts.INT_TRX_Done();
		} 
		
		//TRX_UnderRun
		if (irqStatus & TRX_IRQ_TRX_UR) {
			signal RF230Interrupts.INT_TRX_UnderRun();
		}
		
		//PLL_Locked

		//Ignored for now.
		
		return;
	}
	
/* === RF230Interrupts ===================================================== */

	async command void RF230Interrupts.enable() {
		call TimerCapture.enableEvents();	//doesn't clear pending interrupts
		call PowerManagement.adjustPower();
	}
	
	async command void RF230Interrupts.disable() {
		call TimerCapture.disableEvents();	//clears pending interrupts
		call PowerManagement.adjustPower();
	}

/* === Default events ====================================================== */

	default async void event RF230Interrupts.INT_RX_Start() { }
	
	default async void event RF230Interrupts.INT_TRX_Done() { }
	
	default async void event RF230Interrupts.INT_TRX_UnderRun() { }
	
	default async void event RF230Interrupts.INT_PLL_Locked() { }
	
}
