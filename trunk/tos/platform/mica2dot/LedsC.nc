/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: LedsC.nc,v 1.1.4.1 2007/04/26 00:21:50 njain Exp $
 */
 
/*
 *
 * Authors:		Jason Hill, David Gay, Philip Levis
 * Date last modified:  6/2/03
 *
 */

/**
 * @author Jason Hill
 * @author David Gay
 * @author Philip Levis
 */


module LedsC {
  provides interface Leds;
}
implementation
{
  uint8_t ledsOn;

  enum {
    RED_BIT = 1,
    GREEN_BIT = 2,
    YELLOW_BIT = 4
  };

  async command result_t Leds.init() {
    atomic {
      ledsOn = 0;
      dbg(DBG_BOOT, "LEDS: initialized.\n");
      TOSH_MAKE_RED_LED_OUTPUT();
      TOSH_SET_RED_LED_PIN();
    }
    return SUCCESS;
  }

  async command result_t Leds.redOn() {
    dbg(DBG_LED, "LEDS: Red on.\n");
    atomic {
      TOSH_CLR_RED_LED_PIN();
      ledsOn |= RED_BIT;
    }
    return SUCCESS;
  }

  async command result_t Leds.redOff() {
    dbg(DBG_LED, "LEDS: Red off.\n");
     atomic {
       TOSH_SET_RED_LED_PIN();
       ledsOn &= ~RED_BIT;
     }
     return SUCCESS;
  }

  async command result_t Leds.redToggle() {
    result_t rval;
    atomic {
      if (ledsOn & RED_BIT)
	rval = call Leds.redOff();
      else
	rval = call Leds.redOn();
    }
    return rval;
  }

  async command result_t Leds.greenOn() {
    dbg(DBG_LED, "LEDS: Green on.\n");
    atomic {
      ledsOn |= GREEN_BIT;
    }
    return SUCCESS;
  }

  async command result_t Leds.greenOff() {
    dbg(DBG_LED, "LEDS: Green off.\n");
    atomic {
      ledsOn &= ~GREEN_BIT;
    }
    return SUCCESS;
  }

  async command result_t Leds.greenToggle() {
    result_t rval;
    atomic {
      if (ledsOn & GREEN_BIT)
	rval = call Leds.greenOff();
      else
	rval = call Leds.greenOn();
    }
    return rval;
  }

  async command result_t Leds.yellowOn() {
    dbg(DBG_LED, "LEDS: Yellow on.\n");
    atomic {
      ledsOn |= YELLOW_BIT;
    }
    return SUCCESS;
  }

  async command result_t Leds.yellowOff() {
    dbg(DBG_LED, "LEDS: Yellow off.\n");
    atomic {
      ledsOn &= ~YELLOW_BIT;
    }
    return SUCCESS;
  }

  async command result_t Leds.yellowToggle() {
    result_t rval;
    atomic {
      if (ledsOn & YELLOW_BIT)
	rval = call Leds.yellowOff();
      else
	rval = call Leds.yellowOn();
    }
    return rval;
  }
  
  async command uint8_t Leds.get() {
    uint8_t rval;
    atomic {
      rval = ledsOn;
    }
    return rval;
  }
  
  async command result_t Leds.set(uint8_t ledsNum) {
    atomic {
      ledsOn = (ledsNum & 0x7);
      if (ledsOn & RED_BIT) 
	TOSH_CLR_RED_LED_PIN();
      else 
	TOSH_SET_RED_LED_PIN();
    }
    return SUCCESS;
  }
}
