/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: HPLMicC.nc,v 1.1.4.1 2007/04/26 00:14:47 njain Exp $
 */
 
/*
 *
 * Authors:		Alec Woo
 * Date last modified:  4/23/04
 *
 */

module HPLMicC{
  provides interface MicInterrupt;
}
implementation
{
  async command result_t MicInterrupt.enable(){
    sbi(EIMSK, 7);
    return SUCCESS;
  }

  async command result_t MicInterrupt.disable(){
    cbi(EIMSK, 7);
    return SUCCESS;
  }

  default async event result_t MicInterrupt.toneDetected() {
    return SUCCESS;
  }

#ifndef PLATFORM_PC
  // On Mica2, the actual hardware interrupt is INT7
  // a macro mapping to PORTE pin 7.
  TOSH_SIGNAL(SIG_INTERRUPT7){
    call MicInterrupt.disable();
    __nesc_enable_interrupt();
    signal MicInterrupt.toneDetected();
  }
#endif
}
