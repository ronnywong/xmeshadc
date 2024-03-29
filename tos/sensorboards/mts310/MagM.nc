/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: MagM.nc,v 1.1.4.1 2007/04/27 05:35:23 njain Exp $
 */

/*
 *
 * Authors:	Alec Woo, Su Ping
 *
 */

/**
 * @author Alec Woo
 * @author Su Ping
 */


includes sensorboard;
module MagM {
  provides interface StdControl;
  provides interface MagSetting;
  uses {
    interface ADCControl;
    interface StdControl as PotControl;
    interface I2CPot;
  }
#ifdef PLATFORM_PC
  provides interface ADC as MagX;
  provides interface ADC as MagY;
#endif //PLATFORM_PC
}
implementation {

  char axis;

#ifndef PLATFORM_PC

  void power_on() {
    TOSH_MAKE_MAG_CTL_OUTPUT();
    TOSH_SET_MAG_CTL_PIN();
  }

  void power_off() {
    TOSH_MAKE_MAG_CTL_OUTPUT();
    TOSH_CLR_MAG_CTL_PIN();
  }

#else //PLATFORM_PC

  enum {
    PORT_MAGX = 120,
    PORT_MAGY = 121,
    PORT_MAGZ = 122,
  };

  void power_on() { }
  void power_off() { }

  default command result_t ADCControl.init() {
    return SUCCESS;
  }
  default command result_t ADCControl.setSamplingRate( uint8_t rate ) {
    return SUCCESS;
  }
  default command result_t ADCControl.bindPort( uint8_t port, uint8_t adcPort ) {
    return SUCCESS;
  }

  default command result_t PotControl.init() {
    return SUCCESS;
  }
  default command result_t PotControl.start() {
    return SUCCESS;
  }
  default command result_t PotControl.stop() {
    return SUCCESS;
  }

  task void I2CPot_writePotDone() {
    signal I2CPot.writePotDone( TRUE );
  }
  default command result_t I2CPot.writePot( char addr, char pot, char data ) {
    switch( pot ) {
      case 0:
	dbg( DBG_USR1, "(MAG SET BIAS) [micasb] [y=%u]\n", (uint8_t)data );
	return post I2CPot_writePotDone();
      case 1:
	dbg( DBG_USR1, "(MAG SET BIAS) [micasb] [x=%u]\n", (uint8_t)data );
	return post I2CPot_writePotDone();
    }
    return FAIL;
  }
  default command result_t I2CPot.readPot( char addr, char pot ) {
    return FAIL;
  }

  task void MagX_dataReady() {
    signal MagX.dataReady( generic_adc_read(TOS_LOCAL_ADDRESS, PORT_MAGX, 0) );
  }
  async command result_t MagX.getData() {
    dbg( DBG_USR1, "(MAG READ ADC) [micasb] [x]\n" );
    return post MagX_dataReady();
  }
  async command result_t MagX.getContinuousData() {
    return FAIL;
  }

  task void MagY_dataReady() {
    signal MagY.dataReady( generic_adc_read(TOS_LOCAL_ADDRESS, PORT_MAGY, 0) );
  }
  async command result_t MagY.getData() {
    dbg( DBG_USR1, "(MAG READ ADC) [micasb] [y]\n" );
    return post MagY_dataReady();
  }
  async command result_t MagY.getContinuousData() {
    return FAIL;
  }

#endif //PLATFORM_PC

  command result_t StdControl.init() {
    call ADCControl.bindPort(TOS_ADC_MAG_X_PORT, TOSH_ACTUAL_MAG_X_PORT);
    call ADCControl.bindPort(TOS_ADC_MAG_Y_PORT, TOSH_ACTUAL_MAG_Y_PORT);

    power_off();
    dbg(DBG_BOOT, "MAG initialized.\n");
    return rcombine(call ADCControl.init(), call PotControl.init());
  }
  command result_t StdControl.start() { 
    power_on();
    return SUCCESS;
  }
  command result_t StdControl.stop() {
    power_off();
    return SUCCESS;
  }

  command result_t MagSetting.gainAdjustX(uint8_t val){
    axis = 1;
    return call I2CPot.writePot(TOS_MAG_POT_ADDR, axis, val);
  }

  command result_t MagSetting.gainAdjustY(uint8_t val){
    axis = 0;
    return call I2CPot.writePot(TOS_MAG_POT_ADDR, axis, val);
  }

  default event result_t MagSetting.gainAdjustXDone(bool result){
    return SUCCESS;
  }

  default event result_t MagSetting.gainAdjustYDone(bool result){
    return SUCCESS;
  }

  event result_t I2CPot.writePotDone(bool result){
    if (axis == 0)      
      return signal MagSetting.gainAdjustYDone(result);
    if (axis == 1)
      return signal MagSetting.gainAdjustXDone(result);
    return FAIL;
  }
  event result_t I2CPot.readPotDone(char data, bool result) {
	/* do what ? */
	return 1;
  }
}

