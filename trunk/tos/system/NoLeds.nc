/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: NoLeds.nc,v 1.1.4.1 2007/04/27 06:02:08 njain Exp $
 */

/*
 *
 * Authors:		Jason Hill, David Gay, Philip Levis
 * Date last modified:  6/25/02
 *
 */

/**
 * @author Jason Hill
 * @author David Gay
 * @author Philip Levis
 */



module NoLeds {
  provides interface Leds;
}
implementation
{
  async command result_t Leds.init() {
    return SUCCESS;
  }

  async command result_t Leds.redOn() {
    return SUCCESS;
  }

  async command result_t Leds.redOff() {
    return SUCCESS;
  }

  async command result_t Leds.redToggle() {
    return SUCCESS;
  }

  async command result_t Leds.greenOn() {
    return SUCCESS;
  }

  async command result_t Leds.greenOff() {
    return SUCCESS;
  }

  async command result_t Leds.greenToggle() {
    return SUCCESS;
  }

  async command result_t Leds.yellowOn() {
    return SUCCESS;
  }

  async command result_t Leds.yellowOff() {
    return SUCCESS;
  }

  async command result_t Leds.yellowToggle() {
    return SUCCESS;
  }

  async command uint8_t Leds.get() {
    return 0;
  }

  async command result_t Leds.set(uint8_t value) {
    return SUCCESS;
  }
}
