/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: HPLCC2420InterruptM.nc,v 1.1.4.1 2007/04/26 22:19:27 njain Exp $
 */

/*
 *
 * Authors: Joe Polastre
 * Date last modified:  $Revision: 1.1.4.1 $
 *
 */

/**
 * @author Joe Polastre
 */

module HPLCC2420InterruptM {
  provides {
    interface HPLCC2420Interrupt as FIFOP;
    interface HPLCC2420Interrupt as FIFO;
    interface HPLCC2420Interrupt as CCA;
    interface HPLCC2420Capture as SFD;
  }
  uses {
    interface MSP430Interrupt as FIFOPInterrupt;
    interface MSP430Interrupt as FIFOInterrupt;
    interface MSP430Interrupt as CCAInterrupt;
    interface MSP430Capture as SFDCapture;
    interface MSP430TimerControl as SFDControl;
  }
}
implementation
{

  // ************* FIFOP Interrupt handlers and dispatch *************
  
  /**
   * enable an edge interrupt on the FIFOP pin
   */
  async command result_t FIFOP.startWait(bool low_to_high) {
    atomic {
      call FIFOPInterrupt.disable();
      call FIFOPInterrupt.clear();
      call FIFOPInterrupt.edge(low_to_high);
      call FIFOPInterrupt.enable();
    }
    return SUCCESS;
  }

  /**
   * disables FIFOP interrupts
   */
  async command result_t FIFOP.disable() {
    atomic {
      call FIFOPInterrupt.disable();
      call FIFOPInterrupt.clear();
    }
    return SUCCESS;
  }

  /**
   * Event fired by lower level interrupt dispatch for FIFOP
   */
  async event void FIFOPInterrupt.fired() {
    result_t val = SUCCESS;
    call FIFOPInterrupt.clear();
    val = signal FIFOP.fired();
    if (val == FAIL) {
      call FIFOPInterrupt.disable();
      call FIFOPInterrupt.clear();
    }
  }

  default async event result_t FIFOP.fired() { return FAIL; }
  
  // ************* FIFO Interrupt handlers and dispatch *************
  
  /**
   * enable an edge interrupt on the FIFO pin
   */
  async command result_t FIFO.startWait(bool low_to_high) {
    atomic {
      call FIFOInterrupt.disable();
      call FIFOInterrupt.clear();
      call FIFOInterrupt.edge(low_to_high);
      call FIFOInterrupt.enable();
    }
    return SUCCESS;
  }

  /**
   * disables FIFO interrupts
   */
  async command result_t FIFO.disable() {
    atomic {
      call FIFOInterrupt.disable();
      call FIFOInterrupt.clear();
    }
    return SUCCESS;
  }

  /**
   * Event fired by lower level interrupt dispatch for FIFO
   */
  async event void FIFOInterrupt.fired() {
    result_t val = SUCCESS;
    call FIFOInterrupt.clear();
    val = signal FIFO.fired();
    if (val == FAIL) {
      call FIFOInterrupt.disable();
      call FIFOInterrupt.clear();
    }
  }

  default async event result_t FIFO.fired() { return FAIL; }

  // ************* CCA Interrupt handlers and dispatch *************
  
  /**
   * enable an edge interrupt on the CCA pin
   */
  async command result_t CCA.startWait(bool low_to_high) {
    atomic {
      call CCAInterrupt.disable();
      call CCAInterrupt.clear();
      call CCAInterrupt.edge(low_to_high);
      call CCAInterrupt.enable();
    }
    return SUCCESS;
  }

  /**
   * disables CCA interrupts
   */
  async command result_t CCA.disable() {
    atomic {
      call CCAInterrupt.disable();
      call CCAInterrupt.clear();
    }
    return SUCCESS;
  }

  /**
   * Event fired by lower level interrupt dispatch for CCA
   */
  async event void CCAInterrupt.fired() {
    result_t val = SUCCESS;
    call CCAInterrupt.clear();
    val = signal CCA.fired();
    if (val == FAIL) {
      call CCAInterrupt.disable();
      call CCAInterrupt.clear();
    }
  }

  default async event result_t CCA.fired() { return FAIL; }

  // ************* SFD Interrupt handlers and dispatch *************

  async command result_t SFD.enableCapture(bool low_to_high) {
    uint8_t _direction;
    atomic {
      TOSH_SEL_CC_SFD_MODFUNC();
      call SFDControl.disableEvents();
      if (low_to_high) _direction = MSP430TIMER_CM_RISING;
      else _direction = MSP430TIMER_CM_FALLING;
      call SFDControl.setControlAsCapture(_direction);
      call SFDCapture.clearOverflow();
      call SFDControl.clearPendingInterrupt();
      call SFDControl.enableEvents();
    }
    return SUCCESS;
  }

  async command result_t SFD.disable() {
    atomic {
      call SFDControl.disableEvents();
      call SFDControl.clearPendingInterrupt();
      TOSH_SEL_CC_SFD_IOFUNC();
    }
    return SUCCESS;
  }

  async event void SFDCapture.captured(uint16_t time) {
    result_t val = SUCCESS;
    call SFDControl.clearPendingInterrupt();
    val = signal SFD.captured(time);
    if (val == FAIL) {
      call SFDControl.disableEvents();
      call SFDControl.clearPendingInterrupt();
    }
    else {
      if (call SFDCapture.isOverflowPending())
	call SFDCapture.clearOverflow();
    }
  }

  default async event result_t SFD.captured(uint16_t val) { return FAIL; }
}
  
