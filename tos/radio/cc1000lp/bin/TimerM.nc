/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: TimerM.nc,v 1.1.4.2 2007/04/27 04:56:00 njain Exp $
 */

#include "AssrMask.h"
module TimerM {
    provides interface Timer[uint8_t id];
    provides interface Timer as RadioTimer;
    provides interface StdControl;
    uses {
	interface Leds;
	interface Clock;
	interface PowerManagement;
    }
}

implementation {
    norace uint32_t mState;		// each bit represent a timer state 
    norace uint8_t radioState;		// each bit represent a timer state 
    norace uint8_t mScale, mInterval;
    norace int8_t queue_head;
    norace int8_t queue_tail;
    norace uint8_t queue_size;
    norace uint8_t queue[NUM_TIMERS];

    norace struct timer_s {
        uint8_t type;		// one-short or repeat timer
        int32_t ticks;		// clock ticks for a repeat timer 
        int32_t ticksLeft;	// ticks left before the timer expires
    } mTimerList[NUM_TIMERS];

    norace int32_t radioTicksLeft;
  
    enum {
	maxTimerInterval = 230
    };
    command result_t StdControl.init() {
        //mState=0;
        radioState=0;
        queue_head = queue_tail = -1;
        queue_size = 0;
        mScale = 3;
        mInterval = maxTimerInterval;
        return call Clock.setRate(mInterval, mScale) ;
    }

    command result_t StdControl.start() {
        return SUCCESS;
    }

    command result_t StdControl.stop() {
        //mState=0;
        radioState=0;
        mInterval = maxTimerInterval;
        return SUCCESS;
    }

    command result_t RadioTimer.start(char type, 
				   uint32_t interval) {
	return call RadioTimer.start_phased(type, interval, interval);	

    }

norace uint8_t interrupt;

    command result_t RadioTimer.start_phased(char type, 
				   uint32_t first, uint32_t interval) {
	int16_t diff;
        atomic {
            diff = call Clock.readCounter();
            first += diff;
            radioTicksLeft = first;
            radioState = 1;
	   if(interrupt == 0 && first < mInterval){
               	 mInterval =  first;
               	 call Clock.setInterval(mInterval);
	   }
	} 
        return SUCCESS;
    }

    command uint32_t RadioTimer.ticksLeft() {
    	return  radioTicksLeft -  call Clock.readCounter();
    }

    command result_t RadioTimer.stop() {

        if (radioState) { // if the timer is running 
	    radioState = 0;
            return SUCCESS;
        }
        return FAIL; //timer not running
    }


    default event result_t RadioTimer.fired() {
        return SUCCESS;
    }
    command result_t Timer.start[uint8_t id](char type, 
				   uint32_t interval) {
	return call Timer.start_phased[id](type, interval, interval);	

    }

    command result_t Timer.start_phased[uint8_t id](char type, 
				   uint32_t first, uint32_t interval) {
	uint32_t localbitMask=0x1;				   	
	int16_t diff;
        if (id >= NUM_TIMERS) return FAIL;
        if (type>1) return FAIL;
        mTimerList[id].ticks = interval ;
        mTimerList[id].type = type;
        atomic {
            diff = call Clock.readCounter();
            first += diff;
            mTimerList[id].ticksLeft = first;
            mState|=(localbitMask<<id);
            if (first < mInterval) {
                mInterval=first;
                call Clock.setInterval(mInterval);
                call PowerManagement.adjustPower();
            }
	} 
        return SUCCESS;
    }

    command uint32_t Timer.ticksLeft[uint8_t id]() {
    	return  mTimerList[id].ticksLeft -  call Clock.readCounter();
    }


    command result_t Timer.stop[uint8_t id]() {

        if (id>=NUM_TIMERS) return FAIL;
        if (mState&(0x1<<id)) { // if the timer is running 
	    atomic mState &= ~(0x1<<id);
            return SUCCESS;
        }
        return FAIL; //timer not running
    }


    default event result_t Timer.fired[uint8_t id]() {
        return SUCCESS;
    }

    void enqueue(uint8_t value) {
      if (queue_tail == NUM_TIMERS - 1)
	queue_tail = -1;
      queue_tail++;
      queue_size++;
      queue[(uint8_t)queue_tail] = value;
    }

    uint8_t dequeue() {
      if (queue_size == 0)
        return NUM_TIMERS;
      if (queue_head == NUM_TIMERS - 1)
        queue_head = -1;
      queue_head++;
      queue_size--;
      return queue[(uint8_t)queue_head];
    }

    task void signalOneTimer() {
      uint8_t itimer = dequeue();
      if (itimer < NUM_TIMERS)
        signal Timer.fired[itimer]();
      call PowerManagement.adjustPower();
    }

    void HandleFire() {
        uint8_t i, min_val = maxTimerInterval;
	uint32_t place = 0x1;
            for (i=0;i<NUM_TIMERS;i++)  {
                if (mState&place) {
		    mTimerList[i].ticksLeft -= (mInterval+1);
                    if (mTimerList[i].ticksLeft<=2) {
                        if (mTimerList[i].type==TIMER_REPEAT) {
                            mTimerList[i].ticksLeft += mTimerList[i].ticks;
			    if(mTimerList[i].ticksLeft < min_val) min_val = mTimerList[i].ticksLeft;
                        } else {// one shot timer 
                            mState &=~place; 
                        }
                        enqueue(i);
			post signalOneTimer();
                    }else if(mTimerList[i].ticksLeft < min_val) min_val = mTimerList[i].ticksLeft;
                }
		place <<= 1;
            }
            if (radioState && (radioTicksLeft < min_val )) {	
                 min_val = radioTicksLeft;
	    } else {
	    }
	    atomic {
               	 mInterval =  min_val;
               	 call Clock.setInterval(mInterval);
            }
    }
norace uint8_t state;
    async event result_t Clock.fire() {
	interrupt = 1;
	state ^= 0x1;
        //call Clock.setInterval(200);
        if(((radioTicksLeft -= (mInterval+1)) <= 2) &&
	   radioState){
               radioState = 0;
               signal RadioTimer.fired();
	}
	interrupt = 0;
	HandleFire();
	while ((inp(ASSR) & ASSR_MASK) != 0) {
    		asm volatile("nop");
	}
        return SUCCESS;
    }
}
