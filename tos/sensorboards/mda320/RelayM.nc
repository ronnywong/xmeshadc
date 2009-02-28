/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: RelayM.nc,v 1.1.4.1 2007/04/27 05:15:50 njain Exp $
 */

/*
 *
 * Authors:   Mohammad Rahimi mhr@cens.ucla.edu
 * History:   created @ 11/14/2003 
 * 
 * To change the state of the relays
 *
 */

module RelayM {
  provides {
    interface Relay as relay_normally_closed;
    interface Relay as relay_normally_open;
    interface StdControl as RelayControl;  //if u use Digital I/O no and initialize them no need to this.
  }
  uses {
    interface Dio as Dio6;
    interface Dio as Dio7;
    interface StdControl as DioControl;
  }
}
implementation {


  command result_t RelayControl.init() { 
    call DioControl.init();
    return SUCCESS;
  }
  command result_t RelayControl.start() {
    call DioControl.init();
    return SUCCESS;
  }
  
  command result_t RelayControl.stop() {
    return SUCCESS;
  }

  command result_t relay_normally_closed.open()
    {
      call Dio7.low();      
      return SUCCESS;
    }
  
  command result_t relay_normally_closed.close()
    {
      call Dio7.high();
      return SUCCESS;
    }
  
  command result_t relay_normally_closed.toggle()
    {
      call Dio7.Toggle();
      return SUCCESS;
    }
  
  command result_t relay_normally_open.open()
    {
      call Dio6.high();
      return SUCCESS;
    }
  
  command result_t relay_normally_open.close()
    {
      call Dio6.low();
      return SUCCESS;
    }
  
  command result_t relay_normally_open.toggle()
    {
      call Dio6.Toggle();
      return SUCCESS;
    }

   event result_t Dio6.dataReady(uint16_t data) {
      return SUCCESS;
  }

   event result_t Dio7.dataReady(uint16_t data) {
      return SUCCESS;
  }


  event result_t Dio6.dataOverflow() {
      return SUCCESS;
  }

  event result_t Dio7.dataOverflow() {
      return SUCCESS;
  }

}
