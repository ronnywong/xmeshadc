/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: TimerC.nc,v 1.1.4.1 2007/04/27 06:04:14 njain Exp $
 */

/* 
 * Authors:  Su Ping,  (converted to nesC by Sam Madden)
 *           David Gay,      Intel Research Berkeley Lab
 *           Phil Levis
 * Date:     4/12/2002
 * NesC conversion: 6/28/2002
 * interface cleanup: 7/16/2002
 * Configuration:     8/12/2002
 */

/**
 * @author Su Ping
 * @author (converted to nesC by Sam Madden)
 * @author David Gay
 * @author Intel Research Berkeley Lab
 * @author Phil Levis
 */



configuration TimerC {
  provides interface Timer[uint8_t id];
  provides interface StdControl;
}

implementation {
  components TimerM, ClockC, NoLeds, HPLPowerManagementM;

  TimerM.Leds -> NoLeds;
  TimerM.Clock -> ClockC;
  TimerM.PowerManagement -> HPLPowerManagementM;

  StdControl = TimerM;
  Timer = TimerM;
}
