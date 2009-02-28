/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: HPLADCC.nc,v 1.1.4.1 2007/04/26 00:09:17 njain Exp $
 */
 
/*
 *
 * Authors:		Jason Hill, David Gay, Philip Levis
 * Revision:		$Rev$
 *
 */

// The hardware presentation layer. See hpl.h for the C side.
// Note: there's a separate C side (hpl.h) to get access to the avr macros

// The model is that HPL is stateless. If the desired interface is as stateless
// it can be implemented here (Clock, FlashBitSPI). Otherwise you should
// create a separate component


/**
 * @author Jason Hill
 * @author David Gay
 * @author Philip Levis
 */
module HPLADCC {
  provides interface HPLADC as ADC;
}
implementation
{
  /* The port mapping table */
  bool init_portmap_done;
  enum {
    TOSH_ADC_PORTMAPSIZE = 10
  };

  uint8_t TOSH_adc_portmap[TOSH_ADC_PORTMAPSIZE];

  void init_portmap() {
    /* The default ADC port mapping */
    atomic {
      if( init_portmap_done == FALSE ) {
	int i;
	for (i = 0; i < TOSH_ADC_PORTMAPSIZE; i++)
	  TOSH_adc_portmap[i] = i;
	init_portmap_done = TRUE;
      }
    }
  }

  async command result_t ADC.init() {
    init_portmap();

    outp(0x04, ADCSR); // 250KHz ADC clock (4MHz/16)
	
    cbi(ADCSR, ADSC);
    sbi(ADCSR, ADIF);
    sbi(ADCSR, ADIE);
    cbi(ADCSR, ADEN);

    return SUCCESS;
  }

  async command result_t ADC.setSamplingRate(uint8_t rate) {
    uint8_t current_val = inp(ADCSR);
    current_val = (current_val & 0xF8) | (rate & 0x07);
    outp(current_val, ADCSR);
    return SUCCESS;
  }
  
  async command result_t ADC.bindPort(uint8_t port, uint8_t adcPort) {
    if (port < TOSH_ADC_PORTMAPSIZE)
      {
	atomic {
	  init_portmap();
	  TOSH_adc_portmap[port] = adcPort;
	}
	return SUCCESS;
      }
    else
      return FAIL;
  }

  async command result_t ADC.samplePort(uint8_t port) {
    atomic {
      outp(TOSH_adc_portmap[port], ADMUX);
      if (TOSH_adc_portmap[port] == 8 && port == 8)
	TOSH_SET_PW2_PIN();
      sbi(ADCSR, ADEN);
      sbi(ADCSR, ADSC);
    }
    return SUCCESS;
  }

  async command result_t ADC.sampleAgain() {
    sbi(ADCSR, ADSC);
    return SUCCESS;
  }

  async command result_t ADC.sampleStop() {
    cbi(ADCSR, ADEN);
    return SUCCESS;
  }

  default async event result_t ADC.dataReady(uint16_t done) { return SUCCESS; }
  TOSH_SIGNAL(SIG_ADC) {
    uint16_t data = __inw(ADCL);

    __nesc_enable_interrupt();
    signal ADC.dataReady(data);
  }
}
