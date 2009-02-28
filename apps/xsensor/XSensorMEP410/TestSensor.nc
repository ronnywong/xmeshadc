/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: TestSensor.nc,v 1.3.4.1 2007/04/26 20:28:45 njain Exp $
 */
 
/** 
 * XSensor single-hop application for MEP410 sensorboard.
 *
 * @author @author Martin Turon, Pi Peng, Mao Shifeng
 */

#include "appFeatures.h"
includes sensorboardApp;
configuration TestSensor { 
// this module does not provide any interface
}
implementation
{
  components Main, TestSensorM, Accel, Hamamatsu, SensirionHumidity,IntSensirionHumidity,IntersemaPressure,
  			 GenericComm as Comm, Voltage, LedsC, ADCC, TimerC;

  Main.StdControl -> TimerC;
  Main.StdControl -> TestSensorM;
  
  TestSensorM.CommControl -> Comm;
  TestSensorM.Receive -> Comm.ReceiveMsg[AM_XSXMSG];
  TestSensorM.Send -> Comm.SendMsg[AM_XSXMSG];
  
  TestSensorM.Leds -> LedsC;
  TestSensorM.Timer -> TimerC.Timer[unique("Timer")];

  // Wiring for Battery Ref
  TestSensorM.BattControl -> Voltage;  
  TestSensorM.ADCBATT -> Voltage;  

  TestSensorM.AccelControl -> Accel;
  TestSensorM.AccelX -> Accel.ADC[1];
  TestSensorM.AccelY -> Accel.ADC[2];
  
  TestSensorM.PhotoControl -> Hamamatsu;
  TestSensorM.Photo1 -> Hamamatsu.ADC[1];
  TestSensorM.Photo2 -> Hamamatsu.ADC[2];
  TestSensorM.Photo3 -> Hamamatsu.ADC[3];
  TestSensorM.Photo4 -> Hamamatsu.ADC[4];
  
  TestSensorM.HumControl -> SensirionHumidity;
  TestSensorM.Humidity -> SensirionHumidity.Humidity;
  TestSensorM.Temperature -> SensirionHumidity.Temperature;
  TestSensorM.HumidityError -> SensirionHumidity.HumidityError;
  TestSensorM.TemperatureError -> SensirionHumidity.TemperatureError;

  TestSensorM.IntHumControl -> IntSensirionHumidity;
  TestSensorM.IntHumidity -> IntSensirionHumidity.Humidity;
  TestSensorM.IntTemperature -> IntSensirionHumidity.Temperature;
  TestSensorM.IntHumidityError -> IntSensirionHumidity.HumidityError;
  TestSensorM.IntTemperatureError -> IntSensirionHumidity.TemperatureError;
  
  TestSensorM.IntersemaControl -> IntersemaPressure.SplitControl;
  TestSensorM.Pressure -> IntersemaPressure.Pressure;
  TestSensorM.IntersemaTemperature -> IntersemaPressure.Temperature;
  TestSensorM.PressureError -> IntersemaPressure.PressureError;
  TestSensorM.IntersemaTemperatureError -> IntersemaPressure.TemperatureError;
  TestSensorM.Calibration -> IntersemaPressure;   
  
}

