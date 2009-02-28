/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: XMEP410.nc,v 1.3.4.3 2007/04/26 20:11:44 njain Exp $
 */

/** 
 * XSensor multi-hop application for MEP410 sensorboard.
 *
 * @author @author Martin Turon, Pi Peng, Mao Shifeng
 */



#include "appFeatures.h"

includes sensorboardApp;

configuration XMEP410 { 
// this module does not provide any interface
}

implementation
{
  components Main,  Accel, Hamamatsu, SensirionHumidity,IntSensirionHumidity,IntersemaPressure,
  			 Voltage, ADCC, TimerC,

    GenericCommPromiscuous as Comm,
    MULTIHOPROUTER,XMEP410M, QueuedSend,
#if FEATURE_UART_SEND
	HPLPowerManagementM,
#endif
	LEDS_COMPONENT
	XCommandC, Bcast; 

    Main.StdControl -> XMEP410M;
    Main.StdControl -> QueuedSend.StdControl;
    Main.StdControl -> MULTIHOPROUTER.StdControl;
    Main.StdControl -> Comm;
    Main.StdControl -> TimerC;

    LEDS_WIRING(XMEP410M)  

  XMEP410M.Timer -> TimerC.Timer[unique("Timer")];
  
  // Wiring for Battery Ref
  XMEP410M.BattControl -> Voltage;  
  XMEP410M.ADCBATT -> Voltage;  

  XMEP410M.AccelControl -> Accel;
  XMEP410M.AccelX -> Accel.ADC[1];
  XMEP410M.AccelY -> Accel.ADC[2];  

  XMEP410M.PhotoControl -> Hamamatsu;
  XMEP410M.Photo1 -> Hamamatsu.ADC[1];
  XMEP410M.Photo2 -> Hamamatsu.ADC[2];
  XMEP410M.Photo3 -> Hamamatsu.ADC[3];
  XMEP410M.Photo4 -> Hamamatsu.ADC[4];  

  XMEP410M.HumControl -> SensirionHumidity;
  XMEP410M.Humidity -> SensirionHumidity.Humidity;
  XMEP410M.Temperature -> SensirionHumidity.Temperature;
  XMEP410M.HumidityError -> SensirionHumidity.HumidityError;
  XMEP410M.TemperatureError -> SensirionHumidity.TemperatureError;

  XMEP410M.IntHumControl -> IntSensirionHumidity;
  XMEP410M.IntHumidity -> IntSensirionHumidity.Humidity;
  XMEP410M.IntTemperature -> IntSensirionHumidity.Temperature;
  XMEP410M.IntHumidityError -> IntSensirionHumidity.HumidityError;
  XMEP410M.IntTemperatureError -> IntSensirionHumidity.TemperatureError;  

  XMEP410M.IntersemaControl -> IntersemaPressure.SplitControl;
  XMEP410M.Pressure -> IntersemaPressure.Pressure;
  XMEP410M.IntersemaTemperature -> IntersemaPressure.Temperature;
  XMEP410M.PressureError -> IntersemaPressure.PressureError;
  XMEP410M.IntersemaTemperatureError -> IntersemaPressure.TemperatureError;
  XMEP410M.Calibration -> IntersemaPressure;   
    
    // Wiring for broadcast commands.
    XMEP410M.XCommand -> XCommandC;
    XMEP410M.XEEControl -> XCommandC;
    
    // Wiring for RF mesh networking.
    XMEP410M.RouteControl -> MULTIHOPROUTER;
    XMEP410M.Send -> MULTIHOPROUTER.MhopSend[AM_XMULTIHOP_MSG];
    MULTIHOPROUTER.ReceiveMsg[AM_XMULTIHOP_MSG] ->Comm.ReceiveMsg[AM_XMULTIHOP_MSG];
    XMEP410M.HealthMsgGet -> MULTIHOPROUTER;
    XMEP410M.health_packet -> MULTIHOPROUTER.health_packet;

}



