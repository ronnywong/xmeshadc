/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: Counter.nc,v 1.1.4.1 2007/04/25 23:35:51 njain Exp $
 */
 
/*
 * Authors:		Jason Hill, David Gay, Philip Levis
 * Date last modified:  6/25/02
 *
 */

/**
 * @author Jason Hill
 * @author David Gay
 * @author Philip Levis
 */


module Counter {
  provides {
    interface StdControl;
  }
  uses {
    interface Timer;
    interface IntOutput;
  }
}
implementation {
  int state;

  command result_t StdControl.init()
  {
    state = 1;
    return SUCCESS;
  }

  command result_t StdControl.start()
  {
    return call Timer.start(TIMER_REPEAT, 250);
  }

  command result_t StdControl.stop()
  {
    return call Timer.stop();
  }

  event result_t Timer.fired()
  {
    if (call IntOutput.output(state))
      state++;
    return SUCCESS;
  }

  event result_t IntOutput.outputComplete(result_t success) 
  {
    if(success == 0) state --;
    return SUCCESS;
  }
}

