/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: Grenade.nc,v 1.1.4.1 2007/04/27 05:24:54 njain Exp $
 */

/*  
 * 
  * Authors:		Mike Grimmer
 * Date last modified:  2-20-04
 */

interface Grenade
{
  command result_t skipROM();
  command result_t setInterrupt(uint8_t interval);
  command result_t clrInterrupt(uint8_t interval);

  command result_t setRTClock(uint8_t *tod);
  command result_t readRTClock();
  command result_t FireReset();
  command result_t PullPin();

  event result_t readRTClockDone(uint8_t tod[4]);
}

