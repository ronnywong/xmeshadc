/*
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: MSP430Compare.nc,v 1.1.4.1 2007/04/26 22:09:15 njain Exp $
 */

//@author Cory Sharp <cssharp@eecs.berkeley.edu>

includes MSP430Timer;

interface MSP430Compare
{
  async command uint16_t getEvent();
  async command void setEvent( uint16_t time );
  async command void setEventFromPrev( uint16_t delta );
  async command void setEventFromNow( uint16_t delta );

  async event void fired();

}

