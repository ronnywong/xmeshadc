/*
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: MSP430TimerControl.nc,v 1.1.4.1 2007/04/26 22:12:22 njain Exp $
 */

//@author Cory Sharp <cssharp@eecs.berkeley.edu>
//@author Joe Polastre

includes MSP430Timer;

interface MSP430TimerControl
{
  async command MSP430CompareControl_t getControl();
  async command bool isInterruptPending();
  async command void clearPendingInterrupt();

  async command void setControl( MSP430CompareControl_t control );
  async command void setControlAsCompare();
  async command void setControlAsCapture(bool low_to_high);

  async command void enableEvents();
  async command void disableEvents();
  async command bool areEventsEnabled();

}

