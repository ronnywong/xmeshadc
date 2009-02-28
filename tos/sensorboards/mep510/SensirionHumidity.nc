/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: SensirionHumidity.nc,v 1.1.4.1 2007/04/27 05:21:22 njain Exp $
 */

/*
 *
 * Authors:		Joe Polastre
 *
 */

includes sensorboard;

configuration SensirionHumidity
{
  provides {
    interface ADC as Humidity;
    interface ADC as Temperature;
    interface ADCError as HumidityError;
    interface ADCError as TemperatureError;
    interface SplitControl;
  }
}
implementation
{
  components SensirionHumidityM, TimerC, TempHum;

  SplitControl = SensirionHumidityM;
  Humidity = SensirionHumidityM.Humidity;
  Temperature = SensirionHumidityM.Temperature;
  HumidityError = SensirionHumidityM.HumidityError;
  TemperatureError = SensirionHumidityM.TemperatureError;

  SensirionHumidityM.TimerControl -> TimerC.StdControl;
  SensirionHumidityM.Timer -> TimerC.Timer[unique("Timer")];

  SensirionHumidityM.SensorControl -> TempHum.StdControl;
  SensirionHumidityM.HumSensor -> TempHum.HumSensor;
  SensirionHumidityM.TempSensor -> TempHum.TempSensor;

  SensirionHumidityM.HumError -> TempHum.HumError;
  SensirionHumidityM.TempError -> TempHum.TempError;
}
