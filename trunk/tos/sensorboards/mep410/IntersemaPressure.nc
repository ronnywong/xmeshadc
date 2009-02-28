/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: IntersemaPressure.nc,v 1.1.4.1 2007/04/27 05:20:05 njain Exp $
 */

/*
 *
 * Authors:		Joe Polastre
 *
 * $Id: IntersemaPressure.nc,v 1.1.4.1 2007/04/27 05:20:05 njain Exp $
 */

includes sensorboard;

configuration IntersemaPressure
{
  provides {
    interface ADC as Temperature;
    interface ADC as Pressure;
    interface ADCError as TemperatureError;
    interface ADCError as PressureError;
    interface Calibration;
    interface SplitControl;
  }
}
implementation
{
  components IntersemaPressureM, IntersemaLower, TimerC, NoLeds;

  SplitControl = IntersemaPressureM;
  Temperature = IntersemaPressureM.Temperature;
  Pressure = IntersemaPressureM.Pressure;
  Calibration = IntersemaPressureM;

  PressureError = IntersemaPressureM.PressureError;
  TemperatureError = IntersemaPressureM.TemperatureError;

  IntersemaPressureM.LowerControl -> IntersemaLower.StdControl;

  IntersemaPressureM.LowerPressure -> IntersemaLower.Pressure;
  IntersemaPressureM.LowerTemp -> IntersemaLower.Temp;

  IntersemaPressureM.PressError -> IntersemaLower.PressError;
  IntersemaPressureM.TempError -> IntersemaLower.TempError;

  IntersemaPressureM.LowerCalibrate -> IntersemaLower.Calibration;

  IntersemaPressureM.Timer -> TimerC.Timer[unique("Timer")];
  IntersemaPressureM.TimerControl -> TimerC;

  IntersemaPressureM.Leds -> NoLeds;
}
