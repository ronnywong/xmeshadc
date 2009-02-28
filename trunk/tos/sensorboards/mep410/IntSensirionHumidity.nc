/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: IntSensirionHumidity.nc,v 1.1.4.1 2007/04/27 05:19:15 njain Exp $
 */

/*
 *
 * Authors:		Joe Polastre
 *
 */

includes sensorboard;

configuration IntSensirionHumidity
{
  provides {
    interface SplitControl;
    interface ADC as Humidity;
    interface ADC as Temperature;
    interface ADCError as HumidityError;
    interface ADCError as TemperatureError;
  }
}

implementation
{
  components IntSensirionHumidityM, TimerC, IntTempHum;

  SplitControl = IntSensirionHumidityM;
  Humidity = IntSensirionHumidityM.Humidity;
  Temperature = IntSensirionHumidityM.Temperature;
  HumidityError = IntSensirionHumidityM.HumidityError;
  TemperatureError = IntSensirionHumidityM.TemperatureError;

  IntSensirionHumidityM.TimerControl -> TimerC.StdControl;
  IntSensirionHumidityM.Timer -> TimerC.Timer[unique("Timer")];

  IntSensirionHumidityM.SensorControl -> IntTempHum.StdControl;
  IntSensirionHumidityM.HumSensor -> IntTempHum.HumSensor;
  IntSensirionHumidityM.TempSensor -> IntTempHum.TempSensor;

  IntSensirionHumidityM.HumError -> IntTempHum.HumError;
  IntSensirionHumidityM.TempError -> IntTempHum.TempError;
}
