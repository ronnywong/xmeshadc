/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: MyApp.nc,v 1.1.2.2 2007/04/26 19:59:01 njain Exp $
 */
 
/**
 * This configuration shows how to use the Timer and LED components
 *
 **/
configuration MyApp {
}
implementation {
  components Main, MyAppM, TimerC, LedsC;
  
  Main.StdControl -> TimerC.StdControl;
  Main.StdControl -> MyAppM.StdControl;
  
  MyAppM.Timer -> TimerC.Timer[unique("Timer")];
  MyAppM.Leds -> LedsC.Leds;
}

