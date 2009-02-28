/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: XMTS400.nc,v 1.1.2.2 2007/04/26 20:18:57 njain Exp $
 */

/** 
 * XSensor multi-hop application for MTS420 sensorboard.
 *
 * @author Alan Broad, David M. Doolin, Hu Siquan, Mao Shifeng
 */
 
#include "appFeatures.h" 
includes sensorboardApp;

configuration XMTS400 {
// this module does not provide any interface
}
implementation {
//#include "NMEA.h" 
    components Main,   SensirionHumidity,
    IntersemaPressure,MicaWbSwitch,
    GenericCommPromiscuous as Comm,
    MULTIHOPROUTER,XMTS400M, QueuedSend,
    ADCC, Voltage,Accel, TaosPhoto,
    XCommandC, Bcast, 
#if FEATURE_UART_SEND
	HPLPowerManagementM,
#endif
	LEDS_COMPONENT

    TimerC;

  Main.StdControl -> XMTS400M;
  Main.StdControl -> QueuedSend.StdControl;
  Main.StdControl -> MULTIHOPROUTER.StdControl;
  Main.StdControl -> Comm;
  Main.StdControl -> TimerC;

  XMTS400M.ADCControl -> ADCC;


    LEDS_WIRING(XMTS400M)
	XMTS400M.XCommand -> XCommandC; 
  XMTS400M.XEEControl -> XCommandC;
#if FEATURE_UART_SEND
    // Wiring for UART msg.
    XMTS400M.PowerMgrDisable -> HPLPowerManagementM.Disable;
    XMTS400M.PowerMgrEnable -> HPLPowerManagementM.Enable;
    XMTS400M.SendUART -> QueuedSend.SendMsg[AM_XDEBUG_MSG];
#endif

  
  // Wiring for Battery Ref
  XMTS400M.BattControl -> Voltage;  
  XMTS400M.ADCBATT -> Voltage;  

// Wiring for Taos light sensor
  XMTS400M.TaosControl -> TaosPhoto;
  XMTS400M.TaosCh0 -> TaosPhoto.ADC[0];
  XMTS400M.TaosCh1 -> TaosPhoto.ADC[1];
  
// Wiring for Accelerometer  
  XMTS400M.AccelControl->Accel.StdControl;
  XMTS400M.AccelCmd -> Accel.AccelCmd;
  XMTS400M.AccelX -> Accel.AccelX;
  XMTS400M.AccelY -> Accel.AccelY;

// Wiring for Sensirion humidity/temperature sensor
  XMTS400M.TempHumControl -> SensirionHumidity;
  XMTS400M.Humidity -> SensirionHumidity.Humidity;
  XMTS400M.Temperature -> SensirionHumidity.Temperature;
  XMTS400M.HumidityError -> SensirionHumidity.HumidityError;
  XMTS400M.TemperatureError -> SensirionHumidity.TemperatureError;

// Wiring for Intersema barometric pressure/temperature sensor
  XMTS400M.IntersemaCal -> IntersemaPressure;
  XMTS400M.PressureControl -> IntersemaPressure;
  XMTS400M.IntersemaPressure -> IntersemaPressure.Pressure;
  XMTS400M.IntersemaTemp -> IntersemaPressure.Temperature;
  
//  XMTS400M.SendMsg -> QueuedSend.SendMsg[XDEBUGMSG_ID];
  XMTS400M.RouteControl -> MULTIHOPROUTER;
  XMTS400M.Send -> MULTIHOPROUTER.MhopSend[AM_XMULTIHOP_MSG];

  MULTIHOPROUTER.ReceiveMsg[AM_XMULTIHOP_MSG] -> Comm.ReceiveMsg[AM_XMULTIHOP_MSG];
  XMTS400M.HealthMsgGet -> MULTIHOPROUTER; 
/*#ifdef XMESHSYNC    
    XMTS400M.DownTree -> MULTIHOPROUTER.Receive[0xc];
    MULTIHOPROUTER.ReceiveDownstreamMsg[0xc] -> Comm.ReceiveMsg[0xc];
#endif   */
  
  XMTS400M.Timer -> TimerC.Timer[unique("Timer")];
  XMTS400M.TO_Timer -> TimerC.Timer[unique("Timer")];
  XMTS400M.health_packet -> MULTIHOPROUTER.health_packet;

}
