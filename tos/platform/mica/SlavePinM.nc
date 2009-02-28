/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: SlavePinM.nc,v 1.1.4.1 2007/04/26 00:27:45 njain Exp $
 */
 
/*
 *
 * Authors:		Jason Hill, David Gay, Philip Levis
 * Date last modified:  $Id: SlavePinM.nc,v 1.1.4.1 2007/04/26 00:27:45 njain Exp $
 *
 */

/**
 * @author Jason Hill
 * @author David Gay
 * @author Philip Levis
 */


module SlavePinM {
  provides interface SlavePin;
  provides interface StdControl;
  uses interface HPLSlavePin;

}
implementation
{
  int8_t n;
  bool signalHigh;

  command result_t StdControl.init() {
    atomic
      {
	n = 1;
	signalHigh = FALSE;
      }
    return call HPLSlavePin.high();
  }

  command result_t StdControl.start() {
    return SUCCESS;
  }

  command result_t StdControl.stop() {
    return SUCCESS;
  }

  inline async command result_t SlavePin.low() {
    atomic
      {
	n--;
	call HPLSlavePin.low();
      }
    return SUCCESS;
  }

  task void signalHighTask() {
    atomic
      signalHigh = FALSE;

    signal SlavePin.notifyHigh();
  }

  inline async command result_t SlavePin.high(bool needEvent) {
    atomic
      {
	n++;
	if (n > 0)
	  {
	    call HPLSlavePin.high();
	    if (needEvent || signalHigh)
	      post signalHighTask();
	  }
	else
	  signalHigh |= needEvent;
      }
    return SUCCESS;
  }
}
