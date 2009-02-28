/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: Echo10M.nc,v 1.1.4.1 2007/04/27 05:14:09 njain Exp $
 */
 
module Echo10M {
  provides interface SplitControl;
  uses {
    interface Timer;
    interface Power;
    interface SetParam;
    interface StdControl as SubControl;
  }
}
implementation {
  enum {
    WARMUP = 10
  };

  task void initDone() { signal SplitControl.initDone(); }
  command result_t SplitControl.init() {
    post initDone();
    return call SubControl.init();
  }

  command result_t SplitControl.start() {
    if (!call SubControl.start())
      return FAIL;

    call Power.on();
    call SetParam.setParam(AVERAGE_FOUR);
    return call Timer.start(TIMER_ONE_SHOT, WARMUP);
  }

  event result_t Timer.fired() {
    signal SplitControl.startDone();
    return SUCCESS;
  }

  task void stopDone() { signal SplitControl.stopDone(); }
  command result_t SplitControl.stop() {
    post stopDone();
    call Power.off();
    return call SubControl.stop();
  }
}
