/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: TestSleepC.nc,v 1.1.4.1 2007/04/26 19:34:43 njain Exp $
 */

/// @author Martin Turon <mturon@xbow.com>

/**
 * TestSleep simple puts the processor into sleep mode and stays there.
 * The instananeous and average current should be ~20 uA on the ATmega128.
 */
configuration TestSleepC
{
}
implementation
{
  components Main
	   , TestSleepM
		   , TimerC
		   , LedsC
	   , GenericComm as Comm
#ifdef __AVR__
// HPLPowerManagement is only needed for AVR based platforms
	   , HPLPowerManagementM as PM
#endif
	   ;

#ifdef __AVR__
  TestSleepM.PowerManagement -> PM;
  TestSleepM.Enable -> PM.Enable;
#endif

  Main.StdControl -> TestSleepM;
  Main.StdControl -> TimerC;
  TestSleepM.Timer -> TimerC.Timer[unique("Timer")];
  TestSleepM.Leds -> LedsC;

  TestSleepM.CommControl -> Comm;
}

