/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: HPLADCM.nc,v 1.2.2.2 2007/04/26 00:04:53 njain Exp $
 */
 
/*
 *
 * Authors:		Jason Hill, David Gay, Philip Levis
 * Version:		$Id: HPLADCM.nc,v 1.2.2.2 2007/04/26 00:04:53 njain Exp $
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
/***************************************************************************** 
$Log: HPLADCM.nc,v $
Revision 1.2.2.2  2007/04/26 00:04:53  njain
CVS: Please enter a Bugzilla bug number on the next line.
BugID: 1100

CVS: Please enter the commit log message below.
License header modified in each file for MoteWorks_2_0_F release

Revision 1.2.2.1  2007/01/12 10:45:41  lwei
CVS: Please enter a Bugzilla bug number on the next line.
BugID:
CVS: Please enter the commit log message below.
1.  Commit the 2.0.E RC1 version for new M2110 M2100 M9100 M4100 Platform, it need to use the new toolchain for 1281 and RF230.
CVS: ----------------------------------------------------------------------
CVS: Enter Log. Lines beginning with `CVS:' are removed automatically
CVS:
CVS: Committing in <DIRECTORY NAME>
CVS:
CVS: Modified Files:
CVS: Tag: MoteWorks_2_0_RELEASE_BRANCH
CVS: <FILE1> <FILE2> ... <FILEn>
CVS: ----------------------------------------------------------------------

Revision 1.2  2006/07/10 22:08:52  rkapur
Updating MAIN to 2.1 tree

Revision 1.1.2.1  2006/06/06 21:53:08  xyang
RCB230 Initial Check in

Revision 1.2  2006/03/23 04:25:06  husq
Update micazb drivers adapt to MoteWorks tree

Revision 1.1  2006/01/03 07:46:18  mturon
Initial install of MoteWorks tree

Revision 1.2  2005/03/02 22:45:00  jprabhu
Added Log CVS-Tag

*****************************************************************************/
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
    cbi(ADCSRA,ADEN);
  }

  async command result_t ADC.init() {
    init_portmap();

    // Enable ADC Interupts, 
    // Set Prescaler division factor to 64 
    atomic {
      outp(((1 << ADIE) | (6 << ADPS0)),ADCSRA); 
      
      outp(0,ADMUX);
    }
    return SUCCESS;
  }

  async command result_t ADC.setSamplingRate(uint8_t rate) {
    uint8_t current_val = inp(ADCSRA);
    current_val = (current_val & 0xF8) | (rate & 0x07);
    outp(current_val, ADCSRA);
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
      outp((TOSH_adc_portmap[port] & 0x1F), ADMUX);
    }
    sbi(ADCSRA, ADEN);
      if(TOS_ADC_VOLTAGE_PORT==port)
   	TOSH_uwait(100);
    sbi(ADCSRA, ADSC);
    
    return SUCCESS;
  }

  async command result_t ADC.sampleAgain() {
    sbi(ADCSRA, ADSC);
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
    sbi(ADCSRA, ADIF);
    cbi(ADCSRA, ADEN);
    __nesc_enable_interrupt();
    signal ADC.dataReady(data);
  }
}
