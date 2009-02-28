/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: MicM.nc,v 1.1.2.2 2007/04/27 05:38:01 njain Exp $
 */

/*
 *
 * Authors:		Jason Hill, David Gay, Philip Levis
 * Revision:		$Rev$
 *
 */

/*  OS component abstraction of the analog photo sensor and */
/*  associated A/D support.  It provides an asynchronous interface */
/*  to the photo sensor. */

/*  PHOTO_INIT command initializes the device */
/*  PHOTO_GET_DATA command initiates acquiring a sensor reading. */
/*  It returns immediately.   */
/*  PHOTO_DATA_READY is signaled, providing data, when it becomes */
/*  available. */
/*  Access to the sensor is performed in the background by a separate */
/* TOS task. */

/**
 * @author Jason Hill
 * @author David Gay
 * @author Philip Levis
 */


includes sensorboard;
module MicM {
  provides interface StdControl;
  provides interface Mic;
  provides interface MicInterrupt;
  uses {
    interface ADCControl;
    interface StdControl as PotControl;
    interface I2CPot;
  }
}
implementation {

  command result_t StdControl.init() {
    call ADCControl.bindPort(TOS_ADC_MIC_PORT, TOSH_ACTUAL_MIC_PORT);
    TOSH_MAKE_MIC_CTL_OUTPUT();
    TOSH_CLR_MIC_CTL_PIN();
    TOSH_MAKE_MIC_MUX_SEL_OUTPUT();
    TOSH_CLR_MIC_MUX_SEL_PIN();
    TOSH_MAKE_TONE_DECODE_SIGNAL_INPUT();
    call MicInterrupt.disable();
    return rcombine(call ADCControl.init(), call PotControl.init());
  }

  command result_t StdControl.start() {
    TOSH_SET_MIC_CTL_PIN();
    return SUCCESS;
  }

  command result_t StdControl.stop() {
    call MicInterrupt.disable();
    TOSH_MAKE_MIC_CTL_OUTPUT();
    TOSH_CLR_MIC_CTL_PIN();
    return SUCCESS;
  }

  command result_t Mic.muxSel(uint8_t sel){
    if (sel == 0){
      TOSH_CLR_MIC_MUX_SEL_PIN();      
      return SUCCESS;
    }else if (sel == 1){
      TOSH_SET_MIC_MUX_SEL_PIN();
      return SUCCESS;
    }
    return FAIL;
  }

  async command result_t MicInterrupt.enable(){
    sbi(EIMSK, INT3);
    return SUCCESS;
  }

  async command result_t MicInterrupt.disable(){
    cbi(EIMSK, INT3);
    return SUCCESS;
  }

  command result_t Mic.gainAdjust(uint8_t val){
    return call I2CPot.writePot(TOS_MIC_POT_ADDR, 0, val);
  }

  event result_t I2CPot.readPotDone(char data, bool result){
    return SUCCESS;
  }

  event result_t I2CPot.writePotDone(bool result){
    return SUCCESS;
  }

  command uint8_t Mic.readToneDetector(){
    return TOSH_READ_TONE_DECODE_SIGNAL_PIN();
  }  


  default async event result_t MicInterrupt.toneDetected() {
    return SUCCESS;
  }
 
#ifndef PLATFORM_PC
  TOSH_SIGNAL(SIG_INTERRUPT3) {
    call MicInterrupt.disable();
    __nesc_enable_interrupt();
    signal MicInterrupt.toneDetected();
  }
#endif
}

