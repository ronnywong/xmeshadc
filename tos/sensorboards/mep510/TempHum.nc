/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: TempHum.nc,v 1.1.4.1 2007/04/27 05:21:39 njain Exp $
 */

/*
 *
 * Authors:		Mohammad Rahmim, Joe Polastre
 *
 */

includes sensorboard;
configuration TempHum {
  provides {
    interface StdControl;
    interface ADC as TempSensor;
    interface ADC as HumSensor;
    interface ADCError as TempError;
    interface ADCError as HumError;
  }
}
implementation {
  components TempHumM, TimerC;
  StdControl =  TempHumM.StdControl;
  TempSensor = TempHumM.TempSensor;
  HumSensor = TempHumM.HumSensor;
  TempError = TempHumM.TempError;
  HumError = TempHumM.HumError;

  TempHumM.TimerControl -> TimerC;
  TempHumM.Timer -> TimerC.Timer[unique("Timer")];
}

