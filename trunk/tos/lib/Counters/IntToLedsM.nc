/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: IntToLedsM.nc,v 1.1.4.1 2007/04/25 23:36:16 njain Exp $
 */
 
/*
 * Authors:		Jason Hill, David Gay, Philip Levis, Nelson Lee
 * Date last modified:  6/25/02
 *
 */

/**
 * @author Jason Hill
 * @author David Gay
 * @author Philip Levis
 * @author Nelson Lee
 */


module IntToLedsM {
  uses interface Leds;

  provides interface IntOutput;
  provides interface StdControl;
}
implementation
{
  command result_t StdControl.init()
  {
    call Leds.init();
    call Leds.redOff();
    call Leds.yellowOff();
    call Leds.greenOff();
    return SUCCESS;
  }

  command result_t StdControl.start() {
    return SUCCESS;
  }

  command result_t StdControl.stop() {
    return SUCCESS;
  }
  

  task void outputDone()
  {
    signal IntOutput.outputComplete(1);
  }

  command result_t IntOutput.output(uint16_t value)
  {
    if (value & 1) call Leds.redOn();
    else call Leds.redOff();
    if (value & 2) call Leds.greenOn();
    else call Leds.greenOff();
    if (value & 4) call Leds.yellowOn();
    else call Leds.yellowOff();

    post outputDone();

    return SUCCESS;
  }
}

