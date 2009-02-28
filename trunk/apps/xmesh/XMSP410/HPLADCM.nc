/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: HPLADCM.nc,v 1.1.4.1 2007/04/26 20:14:25 njain Exp $
 */


module HPLADCM {
  provides {
    interface StdControl;
    interface HPLADC as ADC;
  }
}
implementation
{
  /* The port mapping table */
  bool init_portmap_done;
  uint8_t TOSH_adc_portmap[TOSH_ADC_PORTMAPSIZE];
  
  void init_portmap() {
    /* The default ADC port mapping */
    atomic {
      if( init_portmap_done == FALSE ) {
	int i;
	for (i = 0; i < TOSH_ADC_PORTMAPSIZE; i++)
	  TOSH_adc_portmap[i] = i;
	
	// Setup fixed bindings associated with ATmega128 ADC 
	TOSH_adc_portmap[TOS_ADC_BANDGAP_PORT] = TOSH_ACTUAL_BANDGAP_PORT;
	TOSH_adc_portmap[TOS_ADC_GND_PORT] = TOSH_ACTUAL_GND_PORT;
	init_portmap_done = TRUE;
      }
    }
  }

  command result_t StdControl.init() {
    call ADC.init();
  }

  command result_t StdControl.start() {
  }

  command result_t StdControl.stop() {
    cbi(ADCSR,ADEN);
  }

  async command result_t ADC.init() {
    init_portmap();

    // Enable ADC Interupts, 
    // Set Prescaler division factor to 64 
    atomic {
      outp(((1 << ADIE) | (6 << ADPS0)),ADCSR); 
      
//      outp(0,ADMUX);
      outp(0x40,ADMUX);  // changed for xscale mote to use external AVCC
    }
    return SUCCESS;
  }

  async command result_t ADC.setSamplingRate(uint8_t rate) {
    uint8_t current_val = inp(ADCSR);
    current_val = (current_val & 0xF8) | (rate & 0x07);
    outp(current_val, ADCSR);
    return SUCCESS;
  }

  async command result_t ADC.bindPort(uint8_t port, uint8_t adcPort) {
    if (port < TOSH_ADC_PORTMAPSIZE &&
	port != TOS_ADC_BANDGAP_PORT &&
	port != TOS_ADC_GND_PORT) {
      init_portmap();
      atomic TOSH_adc_portmap[port] = adcPort;
      return SUCCESS;
    }
    else
      return FAIL;
  }

  async command result_t ADC.samplePort(uint8_t port) {
    atomic {
      outp(((TOSH_adc_portmap[port] & 0x1F) | 0x40), ADMUX);
    }
    sbi(ADCSR, ADEN);
    sbi(ADCSR, ADSC);
    
    return SUCCESS;
  }

  async command result_t ADC.sampleAgain() {
    sbi(ADCSR, ADSC);
    return SUCCESS;
  }

  async command result_t ADC.sampleStop() {
    // SIG_ADC does the stop
    return SUCCESS;
  }

  default async event result_t ADC.dataReady(uint16_t done) { return SUCCESS; }

  TOSH_SIGNAL(SIG_ADC) {
    uint16_t data = inw(ADCL);
    data &= 0x3ff;
    sbi(ADCSR, ADIF);
    cbi(ADCSR, ADEN);
    __nesc_enable_interrupt();
    signal ADC.dataReady(data);
  }
}
