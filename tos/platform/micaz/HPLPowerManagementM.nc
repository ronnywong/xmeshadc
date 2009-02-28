/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: HPLPowerManagementM.nc,v 1.2.4.1 2007/04/26 00:31:09 njain Exp $
 */
 
/* 
 * Author: Xin Yang (xyang@xbow.com)
 * Date:   11/05/05
 */
 
/**
 * HPLPowerManagement.nc - Manages sleep state of Atmega128L processor
 *
 *
 * <pre>
 *	$Id: HPLPowerManagementM.nc,v 1.2.4.1 2007/04/26 00:31:09 njain Exp $
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


implementation{  

/*===Local State ============================================================*/

  bool disabled = TRUE;

  enum {
    IDLE = 0,
    ADC_NR = (1 << SM0),
    POWER_DOWN = (1 << SM1),
    POWER_SAVE = (1 << SM0) + (1 << SM1),
    STANDBY = (1 << SM2) + (1 << SM1),
    EXT_STANDBY =  (1 << SM0) + (1 << SM1) + (1 << SM2)
  };


/*===Local Functions ========================================================*/
    
  uint8_t getPowerLevel() {
    uint8_t diff;

    // Are external timers running, other than Timer0 ?  
    if (inp(TIMSK) & (~((1<<OCIE0) | (1<<TOIE0)))) { 
      return IDLE;
      
      // SPI (Radio stack on mica2 only)
    } else if (bit_is_set(SPCR, SPIE)) { 
      return IDLE;
            
       // UART0 is tied to GenericComm (radioStack).  Thus it is always enabled
       // once the stack is started.  Checking for UART0 when nothing stops the 
       // UART0 will prevent entry into powerdown mode.  This also means that 
       // Using UART0, with power management enable has the potential that the
       // processor sleep in middle of UART0 transmissions

       //Check UART0 
       //} else if (inp(UCSR0B) & ((1 << RXCIE) | (1 << TXCIE) | 
       //(1 << RXEN)  | (1 << TXEN)) ) {
	   //return IDLE;
	   // UART1 (auxilary UART) status
	   
    } else if (inp(UCSR1B) & ((1 << RXCIE) | (1 << TXCIE) | 
			      (1 << RXEN)  | (1 << TXEN)) ) {
      return IDLE;

      // ADC is enabled
    } else if (bit_is_set(ADCSR, ADEN)) { 
      return ADC_NR;
      
      // Timer0 within 16 tics
    } else if (inp(TIMSK) & ((1<<OCIE0) | (1<<TOIE0))) {
      diff = inp(OCR0) - inp(TCNT0);
      if (diff < 16) return EXT_STANDBY;
      return POWER_SAVE;
      
    } else {
      return POWER_DOWN;
    }
  }

/*===Tasks ==================================================================*/

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
    
/*===Power Management ======================================================*/
    
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
    
  command bool isEnabled() {
    bool ldisabled;
	  
    atomic ldisabled = disabled;
    return ldisabled;
  }
}
