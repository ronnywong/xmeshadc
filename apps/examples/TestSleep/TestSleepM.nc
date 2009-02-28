/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: TestSleepM.nc,v 1.1.4.2 2007/04/26 19:34:52 njain Exp $
 */

/**
 * This application:
 *   -Fires repetitive timer
 *   -Toggles on an led, puts the uP to sleep:
 *	(~3.2ma of current with LED on)
 *	(~15 uA of current with LED off)
 */



/// @author Martin Turon <mturon@xbow.com>

module TestSleepM
{
  provides interface StdControl;
  uses {
    interface StdControl as CommControl;
    interface Timer;
    interface Leds;
  }
// these are only needed for Atmel AVR based platforms
//#ifdef __AVR__
  uses interface PowerManagement;
  uses command result_t Enable();
//#endi//f
}
implementation
{
  command result_t StdControl.init()
  {
      call Leds.init();
//#ifdef __AVR__
    call Enable();

//#endif
    call CommControl.init();
    call CommControl.stop();   //turn-off radio

    return SUCCESS;
  }

  command result_t StdControl.start()
  {
   if (SUCCESS==call Timer.start(TIMER_REPEAT, 5000))
       TOSH_CLR_RED_LED_PIN();
    return SUCCESS;
  }

  command result_t StdControl.stop()
  {
    return SUCCESS;
  }
  task void sleep(){
   call PowerManagement.adjustPower();
  }
/*-------------------------------------------------------------------------------------------
 * Clock.fire: just toggle red led to show that we're alive
 *-------------------------------------------------------------------------------------------*/
  event result_t Timer.fired()
  {
    call Leds.redToggle();
	post sleep();
    return SUCCESS;
  }

}

