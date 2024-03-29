/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: I2CM.nc,v 1.2.4.1 2007/04/26 00:10:52 njain Exp $
 */
 
/*
 *
 * Authors:		Joe Polastre, Rob Szewczyk
 * Date last modified:  7/18/02
 *
 */

/**
 * @author Joe Polastre
 * @author Rob Szewczyk
 */


module I2CM
{
  provides {
    interface StdControl;
    interface I2C;
  }
}
implementation
{
  // global variables
  char state;           	// maintain the state of the current process
  char local_data;		// data to be read/written
  result_t result;

  // define constants for state
  enum {READ_DATA=1, WRITE_DATA, SEND_START, SEND_END};

  // wait when triggering the clock
  void wait() {
    asm volatile  ("nop" ::);
  }

  // hardware pin functions
  void SET_CLOCK() { TOSH_SET_I2C_BUS1_SCL_PIN(); }
  void CLEAR_CLOCK() { TOSH_CLR_I2C_BUS1_SCL_PIN(); }
  void MAKE_CLOCK_OUTPUT() { TOSH_MAKE_I2C_BUS1_SCL_OUTPUT(); }
  void MAKE_CLOCK_INPUT() { TOSH_MAKE_I2C_BUS1_SCL_INPUT(); }

  void SET_DATA() { TOSH_SET_I2C_BUS1_SDA_PIN(); }
  void CLEAR_DATA() { TOSH_CLR_I2C_BUS1_SDA_PIN(); }
  void MAKE_DATA_OUTPUT() { TOSH_MAKE_I2C_BUS1_SDA_OUTPUT(); }
  void MAKE_DATA_INPUT() { TOSH_MAKE_I2C_BUS1_SDA_INPUT(); }
  char GET_DATA() { return TOSH_READ_I2C_BUS1_SDA_PIN(); }

  void pulse_clock() {
	TOSH_uwait(5);
	SET_CLOCK();
	TOSH_uwait(5);
	CLEAR_CLOCK();
  }

  char read_bit() {
	uint8_t i;
	
	MAKE_DATA_INPUT();
        TOSH_uwait(5);
	SET_CLOCK();
	TOSH_uwait(5);
	i = GET_DATA();
	CLEAR_CLOCK();
	return i;
  }

  char i2c_read(){
	uint8_t data = 0;
	uint8_t i = 0;
	for(i = 0; i < 8; i ++){
		data = (data << 1) & 0xfe;
		if(read_bit() == 1){
			data |= 0x1;
		}
	}
	return data;
  }

  char i2c_write(char c) { 
	uint8_t i;
	MAKE_DATA_OUTPUT();
	for(i = 0; i < 8; i ++){
		if(c & 0x80){
			SET_DATA();
		}else{
			CLEAR_DATA();
		}
		pulse_clock();
		c = c << 1;
	}
 	i = read_bit();	
	return i == 0;
  } 

  void i2c_start() {
	SET_DATA();
	SET_CLOCK();
	MAKE_DATA_OUTPUT();
	TOSH_uwait(5);
	CLEAR_DATA();
	TOSH_uwait(5);
	CLEAR_CLOCK();
  }

  void i2c_ack() {
	MAKE_DATA_OUTPUT();
	CLEAR_DATA();
	pulse_clock();
  }

  void i2c_nack() {
	MAKE_DATA_OUTPUT();
	SET_DATA();
	pulse_clock();
  }

  void i2c_end() {
	MAKE_DATA_OUTPUT();
	CLEAR_DATA();
  	TOSH_uwait(5);
	SET_CLOCK();
	TOSH_uwait(5);
	SET_DATA();
  }

  task void I2C_task(){
    uint8_t current_state = state;
    state = 0;
    if((current_state & 0xf) == READ_DATA){
	signal I2C.readDone(i2c_read());
	if (current_state & 0xf0) 
	    i2c_ack();
	else
	    i2c_nack();
    }else if(current_state == WRITE_DATA){
	    signal I2C.writeDone(i2c_write(local_data));
    }else if(current_state == SEND_START){
	    i2c_start();
	    signal I2C.sendStartDone();
    }else if(current_state == SEND_END){
	    i2c_end();
	    signal I2C.sendEndDone();
    }
  }

  command result_t StdControl.init() {
    SET_CLOCK();
    SET_DATA();
    MAKE_CLOCK_OUTPUT();
    MAKE_DATA_OUTPUT();
    state = 0;
    local_data = 0;
    return SUCCESS;
  }

  command result_t StdControl.start() {
    return SUCCESS;
  }

  command result_t StdControl.stop() {
    return SUCCESS;
  }

  command result_t I2C.sendStart() {
    if (state != 0) 
        return FAIL;
    state = SEND_START;
    post I2C_task();
    return SUCCESS;
  }

  command result_t I2C.sendEnd() {
    if (state != 0) 
        return FAIL;
    state = SEND_END;
    post I2C_task();
    return SUCCESS;
  }

  command result_t I2C.read(bool ack) {
    if (state != 0) 
        return FAIL;
    state = READ_DATA;
    if (ack) 
	state |= 0x10;
    post I2C_task();
    return SUCCESS;
  }

  command result_t I2C.write(char data) {
    if(state != 0) 
        return FAIL;
    state = WRITE_DATA;
    local_data = data;
    post I2C_task();
    return SUCCESS;
  }

  default event result_t I2C.sendStartDone() {
    return SUCCESS;
  }

  default event result_t I2C.sendEndDone() {
    return SUCCESS;
  }

  default event result_t I2C.readDone(char data) {
    return SUCCESS;
  }

  default event result_t I2C.writeDone(bool success) {
    return SUCCESS;
  }
  
}
