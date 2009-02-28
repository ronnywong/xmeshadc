/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: TestMTS400.nc,v 1.3.4.1 2007/04/26 20:33:51 njain Exp $
 */

/** 
 * XSensor single-hop application for MTS420 sensorboard.
 *
 * @author Alan Broad, David M. Doolin, Hu Siquan, Mao Shifeng
 */


#include "appFeatures.h"  
includes sensorboardApp;

configuration TestMTS400 {
// this module does not provide any interface
}
implementation {
  components Main, TestMTS400M,  SensirionHumidity,
             IntersemaPressure,MicaWbSwitch,GenericComm as Comm,
             TimerC, Voltage, LedsC, Accel, TaosPhoto,
#ifdef MTS420
    UARTGpsPacket, 
#endif             
             ADCC;

  Main.StdControl -> TestMTS400M;
  Main.StdControl -> TimerC;
  
  TestMTS400M.CommControl -> Comm;
  TestMTS400M.Receive -> Comm.ReceiveMsg[AM_XSXMSG];
  TestMTS400M.Send -> Comm.SendMsg[AM_XSXMSG];

// Wiring for gps
#ifdef MTS420
  TestMTS400M.GpsControl -> UARTGpsPacket;
//TestMTS400M.GpsSend -> UARTGpsPacket;
  TestMTS400M.GpsReceive -> UARTGpsPacket;
  TestMTS400M.GpsCmd -> UARTGpsPacket.GpsCmd;                //UARTGpsPacket.GpsCmd;
#endif  
 
  // Wiring for Battery Ref
  TestMTS400M.BattControl -> Voltage;  
  TestMTS400M.ADCBATT -> Voltage;  

// Wiring for Taos light sensor
  TestMTS400M.TaosControl -> TaosPhoto;
  TestMTS400M.TaosCh0 -> TaosPhoto.ADC[0];
  TestMTS400M.TaosCh1 -> TaosPhoto.ADC[1];
  
// Wiring for Accelerometer  
  TestMTS400M.AccelControl->Accel.StdControl;
  TestMTS400M.AccelCmd -> Accel.AccelCmd;
  TestMTS400M.AccelX -> Accel.AccelX;
  TestMTS400M.AccelY -> Accel.AccelY;

// Wiring for Sensirion humidity/temperature sensor
  TestMTS400M.TempHumControl -> SensirionHumidity;
  TestMTS400M.Humidity -> SensirionHumidity.Humidity;
  TestMTS400M.Temperature -> SensirionHumidity.Temperature;
  TestMTS400M.HumidityError -> SensirionHumidity.HumidityError;
  TestMTS400M.TemperatureError -> SensirionHumidity.TemperatureError;

// Wiring for Intersema barometric pressure/temperature sensor
  TestMTS400M.IntersemaCal -> IntersemaPressure;
  TestMTS400M.PressureControl -> IntersemaPressure;
  TestMTS400M.IntersemaPressure -> IntersemaPressure.Pressure;
  TestMTS400M.IntersemaTemp -> IntersemaPressure.Temperature;

  TestMTS400M.Leds -> LedsC;    
  TestMTS400M.Timer -> TimerC.Timer[unique("Timer")];
}
