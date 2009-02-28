/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: TestMTS410.nc,v 1.3.4.1 2007/04/26 20:34:37 njain Exp $
 */

/** 
 * XSensor single-hop application for MTS410 sensorboard.
 *
 * @author PiPeng
 */


#include "appFeatures.h"
includes sensorboardApp;

configuration TestMTS410 { 
// this module does not provide any interface
}
implementation
{
  components Main, TestMTS410M, SensirionHumidity,PIRC,ADCC,
             IntersemaPressure,TimerC, Voltage,TaosPhoto,            
    	     GenericComm as Comm,LedsC,

	MULTIHOPROUTER as MultiHopM, QueuedSend,
#if FEATURE_UART_SEND
	HPLPowerManagementM,
#endif

#if SENSOR_MIC
	MicC,
#endif

	SounderC,Accel,RelayC; 

    Main.StdControl -> TestMTS410M;
    Main.StdControl -> TimerC;

  TestMTS410M.CommControl -> Comm;
  TestMTS410M.Receive -> Comm.ReceiveMsg[AM_XSXMSG];
  TestMTS410M.Send -> Comm.SendMsg[AM_XSXMSG];


#if SENSOR_MIC
    TestMTS410M.MicControl -> MicC.StdControl;
    TestMTS410M.Mic -> MicC;  
#endif
    TestMTS410M.PirControl -> PIRC.StdControl;

  // Wiring for Battery Ref
    TestMTS410M.BattControl -> Voltage;  
    TestMTS410M.ADCBATT -> Voltage;  
  
    TestMTS410M.ADCControl -> ADCC;
    TestMTS410M.ADC5    -> ADCC.ADC[TOS_ADC5_PORT];
    TestMTS410M.ADC6    -> ADCC.ADC[TOS_ADC6_PORT];

// Wiring for Accelerometer  
    TestMTS410M.AccelControl->Accel.StdControl;
    TestMTS410M.AccelX -> Accel.AccelX;
    TestMTS410M.AccelY -> Accel.AccelY;
  
// Wiring for Relay  
    TestMTS410M.RelayControl->RelayC.RelayControl;
    TestMTS410M.relay_normally_open -> RelayC.relay2;
    TestMTS410M.relay_normally_closed -> RelayC.relay1;
  
// Wiring for Taos light sensor
    TestMTS410M.TaosControl -> TaosPhoto;
    TestMTS410M.TaosCh0 -> TaosPhoto.ADC[0];
    TestMTS410M.TaosCh1 -> TaosPhoto.ADC[1];
  

// Wiring for Sensirion humidity/temperature sensor
    TestMTS410M.TempHumControl -> SensirionHumidity;
    TestMTS410M.Humidity -> SensirionHumidity.Humidity;
    TestMTS410M.Temperature -> SensirionHumidity.Temperature;
    TestMTS410M.HumidityError -> SensirionHumidity.HumidityError;
    TestMTS410M.TemperatureError -> SensirionHumidity.TemperatureError;

// Wiring for Intersema barometric pressure/temperature sensor
    TestMTS410M.IntersemaCal -> IntersemaPressure;

    TestMTS410M.PressureControl -> IntersemaPressure;
    TestMTS410M.IntersemaPressure -> IntersemaPressure.Pressure;
    TestMTS410M.IntersemaTemp -> IntersemaPressure.Temperature;
  
    TestMTS410M.Sounder -> SounderC;
    TestMTS410M.PIR -> PIRC;
  
    TestMTS410M.DetectTimer -> TimerC.Timer[unique("Timer")];
    
    
    TestMTS410M.Leds -> LedsC;    
    TestMTS410M.Timer -> TimerC.Timer[unique("Timer")];

}



