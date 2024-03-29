/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: MicaWbSwitchM.nc,v 1.1.2.2 2007/04/27 05:50:41 njain Exp $
 */

/*
 *
 * Authors:	        Joe Polastre
 *
 */

module MicaWbSwitchM
{
  provides {
    interface StdControl;
    interface Switch[uint8_t id];
  }
  uses {
    interface StdControl as I2CPacketControl;
    interface I2CPacket as I2CSwitch0;
    interface I2CPacket as I2CSwitch1;
  }
}
implementation
{

  enum { GET_SWITCH, SET_SWITCH, SET_SWITCH_ALL, 
         SET_SWITCH_GET, IDLE};

  char sw_state; /* current state of the switch */
  char state;    /* current state of the i2c request */
  char addr;     /* destination address */
  char position;
  char value;

  command result_t StdControl.init() {
    state = IDLE;
    return call I2CPacketControl.init();
  }

  command result_t StdControl.start() {
    return call I2CPacketControl.start();
  }

  command result_t StdControl.stop() {
    return call I2CPacketControl.stop();
  }

  command result_t Switch.get[uint8_t id]() {
    if (state == IDLE)
    {
      state = GET_SWITCH;
      if (id == 0)
	return call I2CSwitch0.readPacket(1, 0x01);
      else if (id == 1)
	return call I2CSwitch1.readPacket(1, 0x01);
    }
    state = IDLE;
    return FAIL;
  }

  command result_t Switch.set[uint8_t id](char l_position, char l_value) {
    if (state == IDLE)
    {
      state = SET_SWITCH_GET;
      value = l_value;
      position = l_position;
      if (id == 0)
	return call I2CSwitch0.readPacket(1,0x01);
      else if (id == 1)
	return call I2CSwitch1.readPacket(1,0x01);
    }
    state = IDLE;
    return FAIL;
  }

  command result_t Switch.setAll[uint8_t id](char l_value) {
    if (state == IDLE)
    {
      state = SET_SWITCH_ALL;
      sw_state = l_value;
      if (id == 0)
	return call I2CSwitch0.writePacket(1, (char*)(&sw_state), 0x01);
      else if (id == 1)
	return call I2CSwitch1.writePacket(1, (char*)(&sw_state), 0x01);
    }
    state = IDLE;
    return FAIL;
  }

  event result_t I2CSwitch0.writePacketDone(bool result) {
    if (state == SET_SWITCH)
    {
      state = IDLE;
      signal Switch.setDone[0](result);
    }
    else if (state == SET_SWITCH_ALL) {
      state = IDLE;
      signal Switch.setAllDone[0](result);
    }
    return SUCCESS;
  }

  event result_t I2CSwitch1.writePacketDone(bool result) {
    if (state == SET_SWITCH)
    {
      state = IDLE;
      signal Switch.setDone[1](result);
    }
    else if (state == SET_SWITCH_ALL) {
      state = IDLE;
      signal Switch.setAllDone[1](result);
    }
    return SUCCESS;
  }

  event result_t I2CSwitch0.readPacketDone(char length, char* data) {
    if (state == GET_SWITCH)
    {
      if (length != 1)
      {
	state = IDLE;
	signal Switch.getDone[0](0);
	return SUCCESS;
      }
      else {
	state = IDLE;
	signal Switch.getDone[0](data[0]);
	return SUCCESS;
      }
    }
    if (state == SET_SWITCH_GET)
    {
      if (length != 1)
      {
	state = IDLE;
	signal Switch.getDone[0](0);
	return SUCCESS;
      }

      sw_state = data[0];

      if (position == 1) {
	sw_state = sw_state & 0xFE;
	sw_state = sw_state | value;
      }
      if (position == 2) {
	sw_state = sw_state & 0xFD;
	sw_state = sw_state | (value << 1);
      }
      if (position == 3) {
	sw_state = sw_state & 0xFB;
	sw_state = sw_state | (value << 2);
      }
      if (position == 4) {
	sw_state = sw_state & 0xF7;
	sw_state = sw_state | (value << 3);
      }
      if (position == 5) {
	sw_state = sw_state & 0xEF;
	sw_state = sw_state | (value << 4);
      }
      if (position == 6) {
	sw_state = sw_state & 0xDF;
	sw_state = sw_state | (value << 5);
      }
      if (position == 7) {
	sw_state = sw_state & 0xBF;
	sw_state = sw_state | (value << 6);
      }
      if (position == 8) {
	sw_state = sw_state & 0x7F;
	sw_state = sw_state | (value << 7);
      }
      data[0] = sw_state;
      state = SET_SWITCH;
      call I2CSwitch0.writePacket(1, (char*)&sw_state, 0x01);
      return SUCCESS;
    } 
    return SUCCESS;
  }

  event result_t I2CSwitch1.readPacketDone(char length, char* data) {
    if (state == GET_SWITCH)
    {
      if (length != 1)
      {
	state = IDLE;
	signal Switch.getDone[1](0);
	return SUCCESS;
      }
      else {
	state = IDLE;
	signal Switch.getDone[1](data[0]);
	return SUCCESS;
      }
    }
    if (state == SET_SWITCH_GET)
    {
      if (length != 1)
      {
	state = IDLE;
	signal Switch.getDone[1](0);
	return SUCCESS;
      }

      sw_state = data[0];

      if (position == 1) {
	sw_state = sw_state & 0xFE;
	sw_state = sw_state | value;
      }
      if (position == 2) {
	sw_state = sw_state & 0xFD;
	sw_state = sw_state | (value << 1);
      }
      if (position == 3) {
	sw_state = sw_state & 0xFB;
	sw_state = sw_state | (value << 2);
      }
      if (position == 4) {
	sw_state = sw_state & 0xF7;
	sw_state = sw_state | (value << 3);
      }
      if (position == 5) {
	sw_state = sw_state & 0xEF;
	sw_state = sw_state | (value << 4);
      }
      if (position == 6) {
	sw_state = sw_state & 0xDF;
	sw_state = sw_state | (value << 5);
      }
      if (position == 7) {
	sw_state = sw_state & 0xBF;
	sw_state = sw_state | (value << 6);
      }
      if (position == 8) {
	sw_state = sw_state & 0x7F;
	sw_state = sw_state | (value << 7);
      }
      data[0] = sw_state;
      state = SET_SWITCH;
      call I2CSwitch1.writePacket(1, (char*)&sw_state, 0x01);
      return SUCCESS;
    } 
    return SUCCESS;
  }

  default event result_t Switch.setDone[uint8_t id](bool result)
  {
    return SUCCESS;
  }

  default event result_t Switch.setAllDone[uint8_t id](bool result)
  {
    return SUCCESS;
  }

  default event result_t Switch.getDone[uint8_t id](char l_value)
  {
    return SUCCESS;
  }

}
