/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: SimpleTimeM.nc,v 1.1.4.1 2007/04/27 06:03:57 njain Exp $
 */

/*
 *
 * Authors:		Su Ping  (sping@intel-research.net)

 * Date last modified:  9/25/02
 *
 */

/**
 * @author Su Ping (sping@intel-research.net)
 */


includes TosTime;
includes Timer;
includes AbsoluteTimer;

module SimpleTimeM {
  provides {
    interface StdControl;
    interface Time;
    interface TimeSet;
    interface AbsoluteTimer[uint8_t id];
  }
  uses {
    interface Timer;
    interface TimeUtil;
    interface StdControl as TimerControl;
    interface Leds;
  }
}
implementation
{
  enum {
    INTERVAL = 32
  };
  tos_time_t time;
  tos_time_t aTimer[MAX_NUM_TIMERS];
  uint32_t   aRepeatTimer[MAX_NUM_TIMERS];
  uint16_t   aRepeatPhase[MAX_NUM_TIMERS];

  command result_t StdControl.init() {
    // initialize logical time
    atomic {
      time.high32=0; 
      time.low32 =0;
    }
    call TimerControl.init();

    return SUCCESS;
  }

  command result_t StdControl.start() {
    call TimerControl.start();
    call Timer.start(TIMER_REPEAT, INTERVAL);
    return SUCCESS ;
  }

  command result_t StdControl.stop() {
    call Timer.stop();
    call TimerControl.stop();
    return SUCCESS;
  }

  async command uint16_t Time.getUs() {
    return 0;
  }

  async command tos_time_t Time.get() {
    tos_time_t t;

    atomic t = time;
    return t;
  }

  async command uint32_t Time.getHigh32()  {
    uint32_t rval;
    atomic {
      rval = time.high32;
    }
    return rval;
  }

  async command uint32_t Time.getLow32() {
    uint32_t rval;
    atomic {
      rval = time.low32;
    }
    return rval;
  }

  command result_t AbsoluteTimer.set[uint8_t id](tos_time_t in) {
    if ( id>=MAX_NUM_TIMERS ) {
      dbg(DBG_TIME, "Atimer.set: Invalid id=\%d max=%d\n", id, MAX_NUM_TIMERS);
      return FAIL;
    }

    if (call TimeUtil.compare(call Time.get(), in) > 0)
      {
	dbg(DBG_TIME, "Atimer.set: time has passed\n");
	//signal AbsoluteTimer.fired[id]();
	return FAIL;
      }
    aTimer[id] = in;
    // dbg(DBG_TIME, "Atimer.set: baseTimerIndex =\%d \n", baseTimerIndex);
    return SUCCESS;
  }

  command result_t AbsoluteTimer.setRepeat[uint8_t id](uint32_t period,
						       uint16_t phase) {

    if ( id>=MAX_NUM_TIMERS ) {
      dbg(DBG_TIME, "Atimer.set: Invalid id=\%d max=%d\n", id, MAX_NUM_TIMERS);
      return FAIL;
    }

    aTimer[id].low32 = aTimer[id].high32 = 0;
    aRepeatTimer[id] = period;
    aRepeatPhase[id] = phase;
    return SUCCESS;
  }

  command result_t AbsoluteTimer.cancel[uint8_t id]() {
    if (id >= MAX_NUM_TIMERS || (aTimer[id].high32 == 0 && aTimer[id].low32 == 0))
      return FAIL;
    aTimer[id].high32 = 0;
    aTimer[id].low32 = 0;
    return SUCCESS;
  }

  default event result_t AbsoluteTimer.fired[uint8_t id]() {
    return SUCCESS ;
  }

  default event result_t AbsoluteTimer.firedRepeat[uint8_t id](tos_time_t t) {
    return SUCCESS ;
  }

  event result_t Timer.fired() {
    uint8_t i;

    atomic time = call TimeUtil.addUint32(time, INTERVAL);

/* 3784 ticks/ms */
//    dbg(DBG_USR1, "@%lld abstimer fired\n", 
//	tos_state.tos_time/3784);

    // The i-1 hack gets rid of a gcc warning when we have no AbsoluteTimers
    for (i = 1; i <= MAX_NUM_TIMERS; i++) {

	if (aTimer[i - 1].low32 == 0 && aTimer[i - 1].high32 == 0 &&
	    aRepeatTimer[i-1] > 0) {
	    // it's a repeatTimer
	    if ((time.low32-aRepeatPhase[i - 1]) 
		% aRepeatTimer[i - 1] < INTERVAL)
		
		signal AbsoluteTimer.firedRepeat[i - 1](time);
	    
	} else if ((aTimer[i - 1].low32 || aTimer[i - 1].high32) &&
		   call TimeUtil.compare(time, aTimer[i - 1]) >= 0) {
	    // it's a one-shot absoluteTimer
	    aTimer[i - 1].high32 = 0;
	    aTimer[i - 1].low32 = 0;
	    signal AbsoluteTimer.fired[i - 1]();
	}
    }
    return SUCCESS;
  }

  /**
   *  Set the 64 bits logical time to a specified value 
   *  @param t Time in the unit of binary milliseconds
   *           type is tos_time_t
   *  @return none
   */
  command void TimeSet.set(tos_time_t t) {
    tos_time_t change;
    uint8_t i;

    atomic {
      time = t;
    }

    dbg(DBG_USR1, "@%lld TIME %d -> %d\n", 
	tos_state.tos_time/3784, t.low32, time.low32);

    change = call TimeUtil.subtract(t, time);

    /* Adjust all timers to be the same time in the future
       (avoids big surprises when setting the time way in the past...) */
    for (i = 0; i < MAX_NUM_TIMERS; i++)
      if (aTimer[i].low32 || aTimer[i].high32)
	aTimer[i] = call TimeUtil.add(aTimer[i], change);
  }


  /**
   *  Adjust logical time by n  binary milliseconds.
   *
   *  @param us unsigned 16 bit interger 
   *            positive number advances the logical time 
   *            negtive argument regress the time 
   *            This operation will not take effect immidiately
   *            The adjustment is done duing next clock.fire event
   *            handling.
   *  @return none
   */
  command void TimeSet.adjust(int16_t n) {
    call TimeSet.adjustNow(n);
  }

  /**
   *  Adjust logical time by x milliseconds.
   *
   *  @param x  32 bit interger
   *            positive number advances the logical time
   *            negtive argument regress the time
   *  @return none
   */
  command void TimeSet.adjustNow(int32_t x) {
    call TimeSet.set(call TimeUtil.addint32(time, x));
  }

}
