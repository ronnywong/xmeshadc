/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: RelayM.nc,v 1.1.4.1 2007/04/27 05:46:25 njain Exp $
 */
 
/*
 *
 * Authors:   pipeng
 * History:   created @ 9/10/2005 
 * 
 * To change the state of the relays
 *
 */

module RelayM {
  provides {
    interface StdControl as RelayControl;
    interface Relay as relay1;
    interface Relay as relay2;
  }
  uses{
  interface StdControl;
  }
}
implementation {

  uint8_t   state1,state2;
  command result_t RelayControl.init() {
  state1=0;
  state2=0;
  return SUCCESS;
  }
  command result_t RelayControl.start() {
  return SUCCESS;
  }
  command result_t RelayControl.stop() {
  return SUCCESS;
  }

  command result_t relay1.open()
    {
      TOSH_MAKE_RELAY1_OUTPUT();
      TOSH_SET_RELAY1_PIN();  
      state1=1;    
      return SUCCESS;
    }
  
  command result_t relay1.close()
    {
      TOSH_MAKE_RELAY1_OUTPUT();
      TOSH_CLR_RELAY1_PIN();      
      state1=0;    
      return SUCCESS;
    }
  
  command result_t relay1.toggle()
    {
      if(state1==0)
      {
      TOSH_MAKE_RELAY1_OUTPUT();
      TOSH_SET_RELAY1_PIN();  
      state1=1;    
      }
      else
      {
      TOSH_MAKE_RELAY1_OUTPUT();
      TOSH_CLR_RELAY1_PIN();      
      state1=0;    
      }
      return SUCCESS;
    }
  
  command result_t relay2.open()
    {
      TOSH_MAKE_RELAY2_OUTPUT();
      TOSH_SET_RELAY2_PIN();  
      state2=1;    
      return SUCCESS;
    }
  
  command result_t relay2.close()
    {
      TOSH_MAKE_RELAY2_OUTPUT();
      TOSH_CLR_RELAY2_PIN();  
      state2=1;    
      return SUCCESS;
    }
  
  command result_t relay2.toggle()
    {
      if(state2==0)
      {
      TOSH_MAKE_RELAY2_OUTPUT();
      TOSH_SET_RELAY2_PIN();  
      state2=1;    
      }
      else
      {
      TOSH_MAKE_RELAY2_OUTPUT();
      TOSH_CLR_RELAY2_PIN();      
      state2=0;    
      }
      return SUCCESS;
    }

}
