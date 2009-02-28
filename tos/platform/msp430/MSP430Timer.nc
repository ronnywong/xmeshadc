/*
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: MSP430Timer.nc,v 1.1.4.1 2007/04/26 22:11:49 njain Exp $
 */
 
 
//@author Cory Sharp <cssharp@eecs.berkeley.edu>
//@author Jan Hauer <hauer@tkn.tu-berlin.de>

includes MSP430Timer;

interface MSP430Timer
{
  async command uint16_t read();
  async command bool isOverflowPending();
  async command void clearOverflow();
  async event void overflow();

  async command void setMode( int mode );
  async command int getMode();
  async command void clear();
  async command void disableEvents();
  async command void setClockSource( uint16_t clockSource );
  async command void setInputDivider( uint16_t inputDivider );
  // partial timer management, add more commands here as appropriate
}

