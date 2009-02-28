/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: TestSensor.nc,v 1.3.4.1 2007/04/26 20:29:58 njain Exp $
 */

/** 
 * XSensor single-hop application for MEP510 sensorboard.
 *
 * @author Martin Turon, PiPeng
 */

includes sensorboardApp;

configuration TestSensor { 
// this module does not provide any interface
}
implementation
{
  components Main, TestSensorM, SensirionHumidity, ADCC,
             GenericComm as Comm, LedsC, TimerC;

  Main.StdControl -> TimerC;
  Main.StdControl -> TestSensorM;
  
  TestSensorM.CommControl -> Comm;
  TestSensorM.Receive -> Comm.ReceiveMsg[AM_XSXMSG];
  TestSensorM.Send -> Comm.SendMsg[AM_XSXMSG];
  
  TestSensorM.Leds -> LedsC;
  TestSensorM.Timer -> TimerC.Timer[unique("Timer")];

  TestSensorM.ADCBATT -> ADCC.ADC[BATT_PORT];
  TestSensorM.ADCControl -> ADCC;

  TestSensorM.HumControl -> SensirionHumidity;

  TestSensorM.Humidity -> SensirionHumidity.Humidity;
  TestSensorM.Temperature -> SensirionHumidity.Temperature;
  
  TestSensorM.HumidityError -> SensirionHumidity.HumidityError;
  TestSensorM.TemperatureError -> SensirionHumidity.TemperatureError;
}

