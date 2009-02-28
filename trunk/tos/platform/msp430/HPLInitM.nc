/*
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: HPLInitM.nc,v 1.1.4.1 2007/04/26 22:05:26 njain Exp $
 */

// @author Jason Hill
// @author David Gay
// @author Philip Levis
// @author Cory Sharp <cssharp@eecs.berkeley.edu>

module HPLInitM
{
  provides command result_t init();
  uses interface StdControl as MSP430ClockControl;
}
implementation
{
  command result_t init()
  {
    TOSH_SET_PIN_DIRECTIONS();
    call MSP430ClockControl.init();
    call MSP430ClockControl.start();
    return SUCCESS;
  }
}

