/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: HPLPowerManagementM.nc,v 1.1.4.1 2007/04/26 00:15:07 njain Exp $
 */

/* Author:  Robert Szewczyk
 *
 * $Id: HPLPowerManagementM.nc,v 1.1.4.1 2007/04/26 00:15:07 njain Exp $
 */

/**
 * @author Robert Szewczyk
 */


module HPLPowerManagementM {
    provides {
      interface PowerManagement;
      command result_t Enable();
      command result_t Disable();
    }
}
implementation{  

    bool disabled = TRUE;

    enum {
	IDLE = 0,
	ADC_NR = (1 << SM0),
	POWER_DOWN = (1 << SM1),
	POWER_SAVE = (1 << SM0) + (1 << SM1),
	STANDBY = (1 << SM2) + (1 << SM1),
	EXT_STANDBY =  (1 << SM0) + (1 << SM1) + (1 << SM2)
    };


    uint8_t getPowerLevel() {
	uint8_t diff;
	// Are external timers running?
	if (inp(TIMSK) & (~((1<<OCIE0) | (1<<TOIE0)))) { 
	    return IDLE;
	} else if (bit_is_set(SPCR, SPIE)) { // SPI (Radio stack on mica)
	    return IDLE;
	    //	} else if (bit_is_set(ACSR, ACIE)) { //Analog comparator
	    //	    return IDLE;
/***
        // HPLUART0M needs to disable pwr management while sending byte to work.

	//Check UART0 
	} else if (inp(UCSR0B) & ((1 << RXCIE) | (1 << TXCIE) | 
				  (1 << RXEN)  | (1 << TXEN))) {
	    return IDLE; //UART0 active so must keep CPU clock running
	//Check UART1 (auxilary UART) status
	} else if (inp(UCSR1B) & ((1 << RXCIE) | (1 << TXCIE) | 
				  (1 << RXEN)  | (1 << TXEN))) {
	    return IDLE; //UART1 active so must keep CPU clock running
***/
	} else if (bit_is_set(ADCSR, ADEN)) { // ADC is enabled
	    return ADC_NR;
	} else if (inp(TIMSK) & ((1<<OCIE0) | (1<<TOIE0))) {
	    diff = inp(OCR0) - inp(TCNT0);
	    if (diff < 16) 
		return EXT_STANDBY;
	    return POWER_SAVE;
	} else {
	    return POWER_DOWN;
	}
    }
    
    task void doAdjustment() {
	uint8_t foo, mcu;
	foo = getPowerLevel();
	mcu = inp(MCUCR);
	mcu &= 0xe3;
	if ((foo == EXT_STANDBY) || (foo == POWER_SAVE)) {
	    mcu |= IDLE;
	    while ((inp(ASSR) & 0x7) != 0) {
		asm volatile("nop");
	    }
	    mcu &= 0xe3;
	}
	mcu |= foo;
	outp(mcu, MCUCR);
	sbi(MCUCR, SE);
	
    }    
    async command uint8_t PowerManagement.adjustPower() {
        uint8_t mcu;
        if (!disabled)
          post doAdjustment();
        else {
	  mcu = inp(MCUCR);
	  mcu &= 0xe3;
	  mcu |= IDLE;
	  outp(mcu, MCUCR);
   	  sbi(MCUCR, SE);
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
}
