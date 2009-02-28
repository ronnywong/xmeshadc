/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: HPLPowerManagementM.nc,v 1.1.2.2 2007/04/26 22:03:06 njain Exp $
 */

 
/**
 * HPLPowerManagement.nc - Manages sleep state of Atmega128L processor
 *
 *
 * <pre>
 *	$Id: HPLPowerManagementM.nc,v 1.1.2.2 2007/04/26 22:03:06 njain Exp $
 * </pre>
 *
 * @author Robert Szewczyk
 * @author Xin Yang
 * @date November 13 2005
 */

module HPLPowerManagementM {
  provides {
    interface PowerManagement;
    command result_t Enable();
    command result_t Disable();
    command bool isEnabled();
  }
}


implementation {  

/*===Check Options===========================================================*/

	//#define CHECK_UART0  // - disabled for low power
	
	
/*===Local State ============================================================*/

	#if (defined(CPU_PWRMGMT) && !defined(BASE_STATION))
//	#ifdef CPU_PWRMGMT
		bool disabled = FALSE;
	#else
		bool disabled = TRUE;
	#endif

	#define POWER_IDLE   0
	#define ADC_NR      _BV(SM0)
	#define POWER_DOWN  _BV(SM1)
	#define POWER_SAVE  ( _BV(SM1) | _BV(SM0) )
	#define STANDBY     ( _BV(SM2) | _BV(SM1) )
	#define EXT_STANDBY ( _BV(SM2) | _BV(SM1) | _BV(SM0))

/*=== Local Functions ========================================================*/
    

  uint8_t getPowerLevel() {

    if (bit_is_set(TIMSK0, OCIE0A)) {
	    // Jiffy Timer Active
	    return POWER_IDLE;
	    
    } else if (bit_is_set(TIMSK1, ICIE1)) {
	    // Timer1 Capture Enabled - indicates radio is on
	    return POWER_IDLE;
      
    } else if (bit_is_set(SPCR, SPIE)) { 
	    // SPI Interrupts enabled - (not enabled on micaz & rcb230)
	    return POWER_IDLE;
       
#ifdef CHECK_UART0

	// UART0 is tied to GenericComm (radioStack).  Thus it is always enabled
	// once the stack is started.  Checking for UART0 when nothing stops the 
	// UART0 will prevent entry into powerdown mode.  So we DO NOT check if 
	// UART0 is enabled before sleeping processor.  This also means that 
	// using UART0, with power management enabled has the potential that the
	// processor might sleep in the middle of UART0 transmissions
	
	} else if (inp(UCSR0B) & (_BV(RXCIE0) | _BV(TXCIE0) | _BV(RXEN0) | _BV(TXEN0))) {
		//Check UART0 
		return POWER_IDLE;
	   
#endif
	   
    } else if (inp(UCSR1B) & (_BV(RXCIE1) | _BV(TXCIE1) | _BV(RXEN1) | _BV(TXEN1))) {
	    // UART1 ACTIVE
	    return POWER_IDLE;
      
    } else if (bit_is_set(ADCSRA, ADEN)) { 
	    // ADC is enabled
	    return ADC_NR;
      
	} else if (inp(TIMSK2) & ( _BV(OCIE2A) | _BV(TOIE2) )) {
		//Timer2 Active
		uint8_t diff;
		diff = inp(OCR2A) - inp(TCNT2);
		if (diff < 16) return EXT_STANDBY;	//Will fire < 16 ticks (ms)
		else return POWER_SAVE;	//Will fire > 16 ticks (ms)
      
    } else {
	    //Nothing ACTIVE, Only EXT. INTERRUPTS & WDT & TWI address can wake processor
	    return POWER_DOWN;
	    
    }
  }

/*===Tasks ==================================================================*/

  task void doAdjustment() {
    uint8_t foo, mcu;
    foo = getPowerLevel();
    mcu = inp(SMCR);
    mcu &= 0xf1;	//mask SM2,SM1,SM0
    if ((foo == EXT_STANDBY) || (foo == POWER_SAVE)) {
      mcu |= POWER_IDLE;
      while ((inp(ASSR) & 0x1f) != 0) {  //wait until TCNT, OCRA, OCRB done
		asm volatile("nop");
      }
      mcu &= 0xf1;
    }
    mcu |= foo;
    outp(mcu, SMCR);	// set new sleep state
    sbi(SMCR, SE);		// set sleep enable bit
	
  }
    
/*===Power Management ======================================================*/
    
  async command uint8_t PowerManagement.adjustPower() {
    uint8_t mcu;
    if (!disabled)
      post doAdjustment();
    else {
      mcu = inp(SMCR);
      mcu &= 0xf1;
      mcu |= POWER_IDLE;
      outp(mcu, SMCR);
      sbi(SMCR, SE);
    }
    return 0;
  }

  command result_t Enable() {
    atomic disabled = FALSE;
    return SUCCESS;
  }

  command result_t Disable() {
    atomic disabled = TRUE;
    return SUCCESS;
  }
    
  command bool isEnabled() {
    bool ldisabled;
	  
    atomic ldisabled = disabled;
    return ldisabled;
  }
}
