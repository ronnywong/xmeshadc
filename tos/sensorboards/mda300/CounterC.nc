/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: CounterC.nc,v 1.1.4.1 2007/04/27 05:08:56 njain Exp $
 */
 
/*
 *
 * Authors:   Mohammad Rahimi mhr@cens.ucla.edu
 * History:   created 08/14/2003
 *
 * High speed counter channel
 *
 */


includes sensorboard;

configuration CounterC {
  provides {
      //interface DioControl;
      interface StdControl as CounterControl;
      interface Dio as Counter;
      command result_t Plugged();
  }
}
implementation {
    components LedsC,CounterM;
    CounterControl =  CounterM.CounterControl;
    Counter = CounterM.Counter;
    Plugged = CounterM.Plugged;
    CounterM.Leds -> LedsC.Leds;
}
