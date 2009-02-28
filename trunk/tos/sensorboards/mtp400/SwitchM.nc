/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: SwitchM.nc,v 1.1.4.1 2007/04/27 05:33:23 njain Exp $
 */

/*
 * driver for 3 Multiplexer on mtp400ca
 *
 * PW0/PW1/PW2 control selecting of Channel
 * PW0 -> A0
 * PW1 -> A1
 * PW2 -> A2
 * A2A1A0 are the address of channel
 * 
 * VSensor provides the VCC and control the Enable/Disable of ADG708 
 *
 * COM port output the select channel signal
 *
 * Authors: Hu Siquan <husq@xbow.com>
 *
 */


module SwitchM
{
    provides interface StdControl as SwitchControl;
    provides interface Switch; 
}
implementation
{

  enum { SET_CHANNEL, IDLE};
  
  char sw_state; /* current state of the Multiplexer */
  char state;    /* current state of set_channel request */
 
 #define  testbit(var, bit)   ((var) & (1 <<(bit)))      //if zero then return zero and if one not equal zero 
    // hardware pin functions
  void SET_SWITCH_BIT0() { TOSH_SET_PW0_PIN(); }
  void CLEAR_SWITCH_BIT0() { TOSH_CLR_PW0_PIN(); }
  void SET_SWITCH_BIT1() { TOSH_SET_PW1_PIN(); }
  void CLEAR_SWITCH_BIT1() { TOSH_CLR_PW1_PIN(); }
  void SET_SWITCH_BIT2() { TOSH_SET_PW2_PIN(); }
  void CLEAR_SWITCH_BIT2() { TOSH_CLR_PW2_PIN(); }    

  command result_t SwitchControl.init() {
      state = IDLE;
      return SUCCESS;
  }
  
  command result_t SwitchControl.start() {
      return SUCCESS;
  }
  
  command result_t SwitchControl.stop() {
      return SUCCESS;
  }
  
  void task switchdone()
  {
	if (state == SET_CHANNEL) {
        state = IDLE;
  		signal Switch.setCHDone();
     }
  	return;

  }

  command result_t Switch.setCH(char val) {

      if (state == IDLE)
          {
              state = SET_CHANNEL;
              sw_state = val;
              if(testbit(sw_state, 0))SET_SWITCH_BIT0();
              else CLEAR_SWITCH_BIT0();
              if(testbit(sw_state, 1))SET_SWITCH_BIT1();
              else CLEAR_SWITCH_BIT1();
              if(testbit(sw_state, 2))SET_SWITCH_BIT2();
              else CLEAR_SWITCH_BIT2();
              
              TOSH_uwait(15);
              post switchdone();
              return SUCCESS;
          }
      return FAIL;
  }
  

  default event result_t Switch.setCHDone() 
  {
     return SUCCESS;
  }
  
}
