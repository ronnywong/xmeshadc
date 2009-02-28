/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: XSensorMTS450.nc,v 1.3.4.1 2007/04/26 20:36:09 njain Exp $
 */

/** 
 * XSensor single-hop application for MTS450 sensorboard.
 *
 * @author Tang Junhua, Pi Peng
 */


//for debugging using serial port
//includes SOdebug;
//#define SODBGON 1
#include "appFeatures.h"
includes sensorboardApp;
configuration XSensorMTS450{ 
// this module does not provide any interface
}

implementation
{
  components Main, XSensorMTS450M, GenericComm as Comm, LedsC, SensirionHumidity, TimerC, MTS450EEPROMC, MTS450CTSC,Voltage;

    
  
  Main.StdControl -> TimerC;
  Main.StdControl -> XSensorMTS450M;
  
  XSensorMTS450M.CommControl->Comm;
  XSensorMTS450M.Send->Comm.SendMsg[AM_XSXMSG];
  XSensorMTS450M.Receive->Comm.ReceiveMsg[AM_XSXMSG];

  XSensorMTS450M.Leds -> LedsC;

  // test sensiron SHT15 sensor: humidity and temperature
  XSensorMTS450M.ADCControl -> SensirionHumidity;
  XSensorMTS450M.Humidity -> SensirionHumidity.Humidity;
  XSensorMTS450M.Temperature -> SensirionHumidity.Temperature;

  XSensorMTS450M.HumidityError -> SensirionHumidity.HumidityError;
  XSensorMTS450M.TemperatureError -> SensirionHumidity.TemperatureError;

  //test EEPEOM on mts450 board
  XSensorMTS450M.MTS450EEPROMControl -> MTS450EEPROMC.StdControl;
  XSensorMTS450M.MTS450EEPROM -> MTS450EEPROMC.MTS450EEPROM[0x50];

    //test I2C ADS 7828 AD converter using for converting CTS sensor
   XSensorMTS450M.MTS450CTSControl -> MTS450CTSC.StdControl;
   XSensorMTS450M.MTS450CTS -> MTS450CTSC.MTS450CTS[0x4A];
   
   XSensorMTS450M.BattControl -> Voltage;  
   XSensorMTS450M.ADCBATT -> Voltage;  

 
   XSensorMTS450M.Timer -> TimerC.Timer[unique("Timer")];

}

