/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: UARTM.nc,v 1.1.4.1 2007/04/27 06:04:56 njain Exp $
 */


/*
 *
 * Authors:		Jason Hill, David Gay, Philip Levis
 * Date last modified:  5/27/03
 *
 *  5/27/03    pal      Added atomic sections for safety.
 *
 */

/**
 * @author Jason Hill
 * @author David Gay
 * @author Philip Levis
 */


module UARTM {
  provides {
    interface ByteComm;
    interface StdControl as Control;
  }
  uses {
    interface HPLUART;
  }
}
implementation 
{
  bool state;

  command result_t Control.init() {
    dbg(DBG_BOOT, "UART initialized\n");
    atomic {
      state = FALSE;
    }
    return SUCCESS;
  }

  command result_t Control.start() {
    return call HPLUART.init();
  }

  command result_t Control.stop() {
      
    return call HPLUART.stop();
  }
    
  async event result_t HPLUART.get(uint8_t data) {
    // Changed SRM 7.8.02 -- No reason to clear state just because
    // we received some data, I think...

    //    state = FALSE;
    signal ByteComm.rxByteReady(data, FALSE, 0);
    dbg(DBG_UART, "signal: state %d\n", state);
    return SUCCESS;
  }

  async event result_t HPLUART.putDone() {
    bool oldState;
    
    atomic {
      dbg(DBG_UART, "intr: state %d\n", state);
      oldState = state;
      state = FALSE;
    }

    /* Note that the state transition/event signalling is not atomic.
       It is possible, after state has been set to FALSE, that
       someone calls txByte before txDone is signalled. The event
       handler therefore may not be able to transmit. Sharing
       the byte level can be very tricky, unless we assure non-preemptiveness
       or have client ids. The UART implementation is non-preemptive,
       but is not assuredly so. -pal*/
    if (oldState) {
      signal ByteComm.txDone();
      signal ByteComm.txByteReady(TRUE);
    }  
    return SUCCESS;
  }

  async command result_t ByteComm.txByte(uint8_t data) {
    bool oldState;
    
    dbg(DBG_UART, "UART_write_Byte_inlet %x\n", data);

    atomic {
      oldState = state;
      state = TRUE;
    }
    if (oldState) 
      return FAIL;

    call HPLUART.put(data);

    return SUCCESS;
  }

}
