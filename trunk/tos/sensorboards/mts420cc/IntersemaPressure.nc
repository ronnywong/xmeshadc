/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: IntersemaPressure.nc,v 1.1.2.2 2007/04/27 05:49:50 njain Exp $
 */

/*
 *
 * Authors:		Joe Polastre
 *
 */

includes sensorboard;

configuration IntersemaPressure
{
  provides {
    interface ADC as Temperature;
    interface ADC as Pressure;
    interface Calibration;
    interface SplitControl;
  }
}
implementation
{
  components IntersemaPressureM, IntersemaLower, MicaWbSwitch, TimerC;

  SplitControl = IntersemaPressureM;
  Temperature = IntersemaPressureM.Temperature;
  Pressure = IntersemaPressureM.Pressure;
  Calibration = IntersemaPressureM;

  IntersemaPressureM.SwitchControl -> MicaWbSwitch.StdControl;
  IntersemaPressureM.Switch -> MicaWbSwitch.Switch[0];
  IntersemaPressureM.IOSwitch -> MicaWbSwitch.Switch[1];

  IntersemaPressureM.LowerControl -> IntersemaLower.StdControl;

  IntersemaPressureM.LowerPressure -> IntersemaLower.Pressure;
  IntersemaPressureM.LowerTemp -> IntersemaLower.Temp;

  IntersemaPressureM.LowerCalibrate -> IntersemaLower.Calibration;
  IntersemaPressureM.Timer -> TimerC.Timer[unique("Timer")];
  IntersemaPressureM.TimerControl -> TimerC;
}
