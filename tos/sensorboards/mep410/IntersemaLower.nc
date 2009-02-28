/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: IntersemaLower.nc,v 1.1.4.1 2007/04/27 05:19:48 njain Exp $
 */

/*
 *
 * Authors:		Joe Polastre
 *
 */

includes sensorboard;

configuration IntersemaLower
{
  provides {
    interface ADC as Pressure;
    interface ADC as Temp;
    interface ADCError as PressError;
    interface ADCError as TempError;
    interface StdControl;
    interface Calibration;
  }
}
implementation
{
  components IntersemaLowerM, TimerC;

  StdControl = IntersemaLowerM;
  Pressure = IntersemaLowerM.Pressure;
  Temp = IntersemaLowerM.Temp;
  Calibration = IntersemaLowerM;
  PressError = IntersemaLowerM.PressError;
  TempError = IntersemaLowerM.TempError;

  IntersemaLowerM.Timer -> TimerC.Timer[unique("Timer")];
  IntersemaLowerM.TimerControl -> TimerC;
}
