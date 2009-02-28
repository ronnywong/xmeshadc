/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: Clock.h,v 1.3.4.1 2007/04/26 00:09:07 njain Exp $
 */

// Usage is Clock.setRate(TOS_InPS, TOS_SnPS)
// the following setting is for Atmega128L mica motes only. 
enum {
  TOS_I1000PS = 32,  TOS_S1000PS = 1,
  TOS_I100PS  = 40,  TOS_S100PS  = 2,
  TOS_I10PS   = 101, TOS_S10PS   = 3,
  TOS_I1024PS = 0,   TOS_S1024PS = 3,
  TOS_I512PS  = 1,   TOS_S512PS  = 3,
  TOS_I256PS  = 3,   TOS_S256PS  = 3,
  TOS_I128PS  = 7,   TOS_S128PS  = 3,
  TOS_I64PS   = 15,  TOS_S64PS   = 3,
  TOS_I32PS   = 31,  TOS_S32PS   = 3,
  TOS_I16PS   = 63,  TOS_S16PS   = 3,
  TOS_I8PS    = 127, TOS_S8PS    = 3,
  TOS_I4PS    = 255, TOS_S4PS    = 3,
  TOS_I2PS    = 15 , TOS_S2PS    = 7,
  TOS_I1PS    = 31 , TOS_S1PS    = 7,
  TOS_I0PS    = 0,   TOS_S0PS    = 0
};
enum {
  DEFAULT_SCALE=3, DEFAULT_INTERVAL=127
};

