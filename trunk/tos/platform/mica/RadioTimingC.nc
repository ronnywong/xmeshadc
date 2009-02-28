/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: RadioTimingC.nc,v 1.1.4.1 2007/04/26 00:26:39 njain Exp $
 */
 
module RadioTimingC {
  provides interface RadioTiming;
}

implementation {

  async command uint16_t RadioTiming.getTiming() {
    //enable input capture.
    //	
    cbi(DDRB, 4);
    while(TOSH_READ_RFM_RXD_PIN()) { }
    outp(0x41, TCCR1B);
    //clear capture flag
    outp(0x1<<ICF1, TIFR);
    //wait for the capture.
    while((inp(TIFR) & (0x1 << ICF1)) == 0) { }
    sbi(PORTB, 6);
    cbi(PORTB, 6);
    return __inw_atomic(ICR1L);
  }
  
  async command uint16_t RadioTiming.currentTime() {
    return __inw_atomic(TCNT1L);
  }
}
