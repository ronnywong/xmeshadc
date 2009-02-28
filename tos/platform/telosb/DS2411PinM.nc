/*
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: DS2411PinM.nc,v 1.1.4.1 2007/04/26 22:24:28 njain Exp $
 */

//@author Cory Sharp <cssharp@eecs.berkeley.edu>

module DS2411PinM
{
  provides interface DS2411Pin;
  uses interface MSP430GeneralIO as MSP430Pin;
}
implementation
{
  command void DS2411Pin.init()
  {
    call MSP430Pin.selectIOFunc();
    call MSP430Pin.makeInput();
    call MSP430Pin.setLow();
  }

  command void DS2411Pin.output_low()
  {
    call MSP430Pin.makeOutput();
  }

  command void DS2411Pin.output_high()
  {
    call MSP430Pin.makeInput();
  }

  command void DS2411Pin.prepare_read()
  {
    call MSP430Pin.makeInput();
  }

  command uint8_t DS2411Pin.read()
  {
    return call MSP430Pin.getRaw();
  }
}

