/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: LogicalTime.nc,v 1.1.4.1 2007/04/27 06:01:43 njain Exp $
 */

/*
 *
 * Authors:		Su Ping  (sping@intel-research.net)
 *
 * Date last modified:  10/5/02
 *
 */

/**
 * @author Su Ping (sping@intel-research.net)
 */


 configuration LogicalTime {
     provides interface Time;
     provides interface TimeUtil;
     provides interface StdControl;
     provides interface AbsoluteTimer[uint8_t id];
     provides interface Timer[uint8_t id];
     provides interface TimeSet;
 }
 implementation {
     components TimerC, SimpleTimeM, TimeUtilC, NoLeds;

     Timer = TimerC.Timer;
     TimeUtil = TimeUtilC;
     AbsoluteTimer = SimpleTimeM;
     Time = SimpleTimeM;
     StdControl = SimpleTimeM;
     TimeSet = SimpleTimeM;

     SimpleTimeM.TimerControl -> TimerC;
     SimpleTimeM.Timer -> TimerC.Timer[unique("Timer")];
     SimpleTimeM.Leds ->NoLeds;
     SimpleTimeM.TimeUtil -> TimeUtilC;
     
}
