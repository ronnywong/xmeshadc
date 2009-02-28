/*
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: MSP430ClockInit.nc,v 1.1.4.1 2007/04/26 22:08:58 njain Exp $
 */

//@author Cory Sharp <cssharp@eecs.berkeley.edu>

interface MSP430ClockInit
{
  event void initClocks();
  event void initTimerA();
  event void initTimerB();

  command void defaultInitClocks();
  command void defaultInitTimerA();
  command void defaultInitTimerB();
}

