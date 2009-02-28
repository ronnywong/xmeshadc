/*
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: MSP430Timer.h,v 1.1.4.1 2007/04/26 22:11:32 njain Exp $
 */

//@author Cory Sharp <cssharp@eecs.berkeley.edu>

#ifndef _H_MSP430Timer_h
#define _H_MSP430Timer_h

enum {
  MSP430TIMER_CM_NONE = 0,
  MSP430TIMER_CM_RISING = 1,
  MSP430TIMER_CM_FALLING = 2,
  MSP430TIMER_CM_BOTH = 3,
  
  MSP430TIMER_STOP_MODE = 0,
  MSP430TIMER_UP_MODE = 1,
  MSP430TIMER_CONTINUOUS_MODE = 2,
  MSP430TIMER_UPDOWN_MODE = 3,

  MSP430TIMER_TACLK = 0,
  MSP430TIMER_TBCLK = 0,
  MSP430TIMER_ACLK = 1,
  MSP430TIMER_SMCLK = 2,
  MSP430TIMER_INCLK = 3,
  
  MSP430TIMER_CLOCKDIV_1 = 0,
  MSP430TIMER_CLOCKDIV_2 = 1,
  MSP430TIMER_CLOCKDIV_4 = 2,
  MSP430TIMER_CLOCKDIV_8 = 3,
};

typedef struct 
{
  int ccifg : 1;    // capture/compare interrupt flag
  int cov : 1;      // capture overflow flag
  int out : 1;      // output value
  int cci : 1;      // capture/compare input value
  int ccie : 1;     // capture/compare interrupt enable
  int outmod : 3;   // output mode
  int cap : 1;      // 1=capture mode, 0=compare mode
  int clld : 2;     // compare latch load
  int scs : 1;      // synchronize capture source
  int ccis : 2;     // capture/compare input select: 0=CCIxA, 1=CCIxB, 2=GND, 3=VCC
  int cm : 2;       // capture mode: 0=none, 1=rising, 2=falling, 3=both
} MSP430CompareControl_t;

typedef struct 
{
  int taifg : 1;    // timer A interrupt flag
  int taie : 1;     // timer A interrupt enable
  int taclr : 1;    // timer A clear: resets TAR, .id, and .mc
  int _unused0 : 1; // unused
  int mc : 2;       // mode control: 0=stop, 1=up, 2=continuous, 3=up/down
  int id : 2;       // input divisor: 0=/1, 1=/2, 2=/4, 3=/8
  int tassel : 2;   // timer A source select: 0=TxCLK, 1=ACLK, 2=SMCLK, 3=INCLK
  int _unused1 : 6; // unused
} MSP430TimerAControl_t;

typedef struct 
{
  int tbifg : 1;    // timer B interrupt flag
  int tbie : 1;     // timer B interrupt enable
  int tbclr : 1;    // timer B clear: resets TAR, .id, and .mc
  int _unused0 : 1; // unused
  int mc : 2;       // mode control: 0=stop, 1=up, 2=continuous, 3=up/down
  int id : 2;       // input divisor: 0=/1, 1=/2, 2=/4, 3=/8
  int tbssel : 2;   // timer B source select: 0=TxCLK, 1=ACLK, 2=SMCLK, 3=INCLK
  int _unused1 : 1; // unused
  int cntl : 2;     // counter length: 0=16-bit, 1=12-bit, 2=10-bit, 3=8-bit
  int tbclgrp : 2;  // tbclx group: 0=independent, 1=0/12/34/56, 2=0/123/456, 3=all
  int _unused2 : 1; // unused
} MSP430TimerBControl_t;

#endif//_H_MSP430Timer_h

