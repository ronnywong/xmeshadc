/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: MicM.nc,v 1.1.4.1 2007/04/27 05:55:26 njain Exp $
 */

/*
 *
 * Authors:  Mike Grimmer
 *
 */

includes sensorboard;
module MicM 
{
  provides interface StdControl;
  provides interface Mic;
  uses 
  {
    interface ADCControl;
    interface StdControl as PotControl;
    interface I2CPot;
  }
}
implementation 
{
  command result_t StdControl.init() 
  {
    call ADCControl.bindPort(TOS_ADC_MIC_PORT, TOSH_ACTUAL_MIC_PORT);
    MAKE_PW1_OUTPUT();
    SET_PW1();
    MAKE_PWM1B_OUTPUT();
    SET_PWM1B();
    call ADCControl.init();
    call PotControl.init();
    return SUCCESS;
  }

  command result_t StdControl.start() 
  {
    TOSH_SET_MIC_CTL_PIN();
    return SUCCESS;
  }

  command result_t StdControl.stop() 
  {
    TOSH_CLR_MIC_CTL_PIN();
    return SUCCESS;
  }

  command result_t Mic.muxSel(uint8_t sel){
    if (sel == 0){
      CLR_PWM1B();      
      return SUCCESS;
    }else if (sel == 1){
      SET_PWM1B();
      return SUCCESS;
    }
    return FAIL;
  }

  command result_t Mic.gainAdjust(uint8_t val)
  {
    return call I2CPot.writePot(TOS_MIC_POT_ADDR, 0, val);
  }

  event result_t I2CPot.readPotDone(char data, bool result)
  {
    return SUCCESS;
  }

  event result_t I2CPot.writePotDone(bool result)
  {
    return SUCCESS;
  }

}

