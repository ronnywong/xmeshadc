/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: IntTempHum.nc,v 1.1.4.1 2007/04/27 05:19:32 njain Exp $
 */

/*
 *
 * Authors:		Mohammad Rahmim, Joe Polastre
 *
 */

configuration IntTempHum
{
  provides {
    interface StdControl;
    interface ADC as TempSensor;
    interface ADC as HumSensor;
    interface ADCError as TempError;
    interface ADCError as HumError;
  }
}

implementation
{
  components IntTempHumM, TimerC;
  StdControl =  IntTempHumM.StdControl;
  TempSensor = IntTempHumM.TempSensor;
  HumSensor = IntTempHumM.HumSensor;
  TempError = IntTempHumM.TempError;
  HumError = IntTempHumM.HumError;

  IntTempHumM.TimerControl -> TimerC;
  IntTempHumM.Timer -> TimerC.Timer[unique("Timer")];
}
