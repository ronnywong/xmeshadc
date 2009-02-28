/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: Accel.nc,v 1.1.4.1 2007/04/27 05:17:51 njain Exp $
 */

/*
 *
 * Authors:		Joe Polastre
 *
 */

includes sensorboard;

configuration Accel
{
  provides {
    interface ADC[uint8_t id];
    interface SplitControl;
  }
}
implementation
{
  components AccelM, ADCC, TimerC;

  SplitControl = AccelM;
  ADC = AccelM;

  AccelM.ADCControl -> ADCC;
  AccelM.Accel1 -> ADCC.ADC[ACCELX_ADC_PORT];
  AccelM.Accel2 -> ADCC.ADC[ACCELY_ADC_PORT];

  AccelM.TimerControl -> TimerC.StdControl;
  AccelM.Timer -> TimerC.Timer[unique("Timer")];
}
