/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: SwitchM.nc,v 1.1.4.2 2007/04/27 05:16:49 njain Exp $
 */

/*
 * Authors:   Mohammad Rahimi mhr@cens.ucla.edu
 * History:   created @ 01/14/2003 
 * Last Modified:     @ 08/14/2003
 * 
 * driver for ADG715BRU on mda300ca 
 * inspired from joe Polastre previous driver 
 */


module SwitchM
{
    provides {
        interface StdControl as SwitchControl;
        interface Switch;
    }
    uses interface I2CPacket;
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
  uint8_t i2cwflag=0;

  command result_t SwitchControl.init() {
      state = IDLE;
      //**I2CPacket should get initializedd here.
      return SUCCESS;
  }
  
  command result_t SwitchControl.start() {
      return SUCCESS;
  }
  
  command result_t SwitchControl.stop() {
      return SUCCESS;
  }

  
  command result_t Switch.get() {
      /*
      if (state == IDLE)
          {
              state = GET_SWITCH;
              return call I2CPacket.readPacket(1, 0x01);
          }
      */
      return FAIL;
  }

  command result_t Switch.set(char l_position, char l_value) {
      /*
      if (state == IDLE)
          {
              state = SET_SWITCH_GET;
              value = l_value;
              position = l_position;
              return call I2CPacket.readPacket(1,0x01);
          }
      */
      return FAIL;
  }

  command result_t Switch.setAll(char val) {
      if (state == IDLE)
          {
              state = SET_SWITCH_ALL;
              sw_state = val;
              atomic i2cwflag=1;
              if ( call I2CPacket.writePacket(1, (char*)(&sw_state), 0x03) == FAIL)
                  {
				              atomic i2cwflag=0;
                      state = IDLE;
                      return FAIL;
                  }
              else return SUCCESS;
          }
      return FAIL;
  }
  
event result_t I2CPacket.writePacketDone(bool result) {
     if(i2cwflag==0) return SUCCESS;
     atomic i2cwflag=0;
     if (state == SET_SWITCH)
         {
             state = IDLE;
             signal Switch.setDone(result);
         }
     else if (state == SET_SWITCH_ALL) {
         state = IDLE;
         signal Switch.setAllDone(result);
     }
     return SUCCESS;
 }
 
 event result_t I2CPacket.readPacketDone(char length, char* data) {
     /*
       if (state == GET_SWITCH)
          {
          if (length != 1)
          {
          state = IDLE;
          signal Switch.getDone(0);
                      return SUCCESS;
                      }
                      else {
                      state = IDLE;
                      signal Switch.getDone(data[0]);
                      return SUCCESS;
                      }
                      }
                      if (state == SET_SWITCH_GET)
          {
          if (length != 1)
          {
          state = IDLE;
          signal Switch.getDone(0);
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
                  call I2CPacket.writePacket(1, (char*)&sw_state, 0x01);
                  return SUCCESS;
                  } 
     */
     return SUCCESS;
 }
 

  default event result_t Switch.getDone(char val) 
      {
          return SUCCESS;
      }
  
  default event result_t Switch.setDone(bool r) 
      {
          return SUCCESS;
      }
  
  default event result_t Switch.setAllDone(bool r) 
      {
          return SUCCESS;
      }
  
}
