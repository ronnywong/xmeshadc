/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: TestMTS420cc.nc,v 1.1.2.2 2007/04/26 20:35:23 njain Exp $
 */
 
/** 
 * XSensor single-hop application for MTS420 sensorboard.
 *
 * @author Alan Broad, David M. Doolin, Hu Siquan, Mao Shifeng
 */


#include "appFeatures.h"  
includes sensorboardApp;

configuration TestMTS420cc 
{
// this module does not provide any interface
}
implementation 
{
	components Main, TestMTS420ccM,  SensirionHumidity,
             IntersemaPressure,MicaWbSwitch,GenericComm as Comm,
             TimerC, Voltage, LedsC, Accel, TaosPhoto,
#ifdef MTS420
			 UARTGpsPacket, 
#endif
#if FEATURE_EEPROM_TEST
			MTS420EEPROMC,
#endif
			 ADCC;

	Main.StdControl -> TestMTS420ccM;
	Main.StdControl -> TimerC;
  
	TestMTS420ccM.CommControl -> Comm;
	TestMTS420ccM.Receive -> Comm.ReceiveMsg[AM_XSXMSG];
	TestMTS420ccM.Send -> Comm.SendMsg[AM_XSXMSG];

// Wiring for gps
#ifdef MTS420
  TestMTS420ccM.GpsControl -> UARTGpsPacket;
//TestMTS420ccM.GpsSend -> UARTGpsPacket;
  TestMTS420ccM.GpsReceive -> UARTGpsPacket;
  TestMTS420ccM.GpsCmd -> UARTGpsPacket.GpsCmd;                //UARTGpsPacket.GpsCmd;
#endif  

  // Wiring for Battery Ref
  TestMTS420ccM.BattControl -> Voltage;  
  TestMTS420ccM.ADCBATT -> Voltage;  

// Wiring for Taos light sensor
  TestMTS420ccM.TaosControl -> TaosPhoto;
  TestMTS420ccM.TaosCh0 -> TaosPhoto.ADC[0];
  TestMTS420ccM.TaosCh1 -> TaosPhoto.ADC[1];
  
// Wiring for Accelerometer  
  TestMTS420ccM.AccelControl->Accel.StdControl;
  TestMTS420ccM.AccelCmd -> Accel.AccelCmd;
  TestMTS420ccM.AccelX -> Accel.AccelX;
  TestMTS420ccM.AccelY -> Accel.AccelY;

// Wiring for Sensirion humidity/temperature sensor
  TestMTS420ccM.TempHumControl -> SensirionHumidity;
  TestMTS420ccM.Humidity -> SensirionHumidity.Humidity;
  TestMTS420ccM.Temperature -> SensirionHumidity.Temperature;
  TestMTS420ccM.HumidityError -> SensirionHumidity.HumidityError;
  TestMTS420ccM.TemperatureError -> SensirionHumidity.TemperatureError;

// Wiring for Intersema barometric pressure/temperature sensor
  TestMTS420ccM.IntersemaCal -> IntersemaPressure;
  TestMTS420ccM.PressureControl -> IntersemaPressure;
  TestMTS420ccM.IntersemaPressure -> IntersemaPressure.Pressure;
  TestMTS420ccM.IntersemaTemp -> IntersemaPressure.Temperature;

  TestMTS420ccM.Leds -> LedsC;    
  TestMTS420ccM.Timer -> TimerC.Timer[unique("Timer")];
  
 // Wiring for EEPROM, chrl 20060724 
#if FEATURE_EEPROM_TEST
  TestMTS420ccM.MTS420EEPROMControl -> MTS420EEPROMC.StdControl;
  TestMTS420ccM.MTS420EEPROM -> MTS420EEPROMC.MTS420EEPROM[0x55];
#endif

}
