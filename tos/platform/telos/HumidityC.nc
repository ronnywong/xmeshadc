/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: HumidityC.nc,v 1.1.4.1 2007/04/26 22:20:48 njain Exp $
 */
 
/*
 *
 * Authors:		Joe Polastre
 *
 * $Id: HumidityC.nc,v 1.1.4.1 2007/04/26 22:20:48 njain Exp $
 */

configuration HumidityC
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
  components HumidityM, TimerC, HumidityProtocolC;

  SplitControl = HumidityM;
  Humidity = HumidityM.Humidity;
  Temperature = HumidityM.Temperature;
  HumidityError = HumidityM.HumidityError;
  TemperatureError = HumidityM.TemperatureError;

  HumidityM.TimerControl -> TimerC.StdControl;
  HumidityM.Timer -> TimerC.Timer[unique("Timer")];

  HumidityM.SensorControl -> HumidityProtocolC.StdControl;
  HumidityM.HumSensor -> HumidityProtocolC.HumSensor;
  HumidityM.TempSensor -> HumidityProtocolC.TempSensor;

  HumidityM.HumError -> HumidityProtocolC.HumError;
  HumidityM.TempError -> HumidityProtocolC.TempError;

}
