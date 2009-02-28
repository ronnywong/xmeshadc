/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: XMTS420CC.nc,v 1.1.2.2 2007/04/26 20:20:37 njain Exp $
 */

/**
 * XSensor multi-hop application for MTS420 sensorboard.
 *
 * @author Alan Broad, David M. Doolin, Hu Siquan, Mao Shifeng
 */

#include "appFeatures.h"
includes sensorboardApp;

configuration XMTS420CC 
{
// this module does not provide any interface
}
implementation 
{
	components Main,   SensirionHumidity,
	IntersemaPressure,MicaWbSwitch,
	GenericCommPromiscuous as Comm,
	MULTIHOPROUTER,XMTS420M, QueuedSend,
	ADCC, Voltage,Accel, TaosPhoto,
	XCommandC, Bcast,
#if FEATURE_UART_SEND
	HPLPowerManagementM,
#endif
#ifdef MTS420
	UARTGpsPacket,
#endif
	LEDS_COMPONENT
	TimerC;

	Main.StdControl -> XMTS420M;
	Main.StdControl -> QueuedSend.StdControl;
	Main.StdControl -> MULTIHOPROUTER.StdControl;
	Main.StdControl -> Comm;
	Main.StdControl -> TimerC;

	LEDS_WIRING(XMTS420M)
	XMTS420M.ADCControl -> ADCC;

#if FEATURE_UART_SEND
    // Wiring for UART msg.
	XMTS420M.PowerMgrDisable -> HPLPowerManagementM.Disable;
	XMTS420M.PowerMgrEnable -> HPLPowerManagementM.Enable;
	XMTS420M.SendUART -> QueuedSend.SendMsg[AM_XDEBUG_MSG];
#endif

  // Wiring for Battery Ref
	XMTS420M.BattControl -> Voltage;
	XMTS420M.ADCBATT -> Voltage;

// Wiring for Taos light sensor
	XMTS420M.TaosControl -> TaosPhoto;
	XMTS420M.TaosCh0 -> TaosPhoto.ADC[0];
	XMTS420M.TaosCh1 -> TaosPhoto.ADC[1];

// Wiring for Accelerometer
	XMTS420M.AccelControl->Accel.StdControl;
	XMTS420M.AccelCmd -> Accel.AccelCmd;
	XMTS420M.AccelX -> Accel.AccelX;
	XMTS420M.AccelY -> Accel.AccelY;

// Wiring for Sensirion humidity/temperature sensor
	XMTS420M.TempHumControl -> SensirionHumidity;
	XMTS420M.Humidity -> SensirionHumidity.Humidity;
	XMTS420M.Temperature -> SensirionHumidity.Temperature;
	XMTS420M.HumidityError -> SensirionHumidity.HumidityError;
	XMTS420M.TemperatureError -> SensirionHumidity.TemperatureError;

// Wiring for Intersema barometric pressure/temperature sensor
	XMTS420M.IntersemaCal -> IntersemaPressure;
	XMTS420M.PressureControl -> IntersemaPressure;
	XMTS420M.IntersemaPressure -> IntersemaPressure.Pressure;
	XMTS420M.IntersemaTemp -> IntersemaPressure.Temperature;
	
// wiring for timers
	XMTS420M.Timer -> TimerC.Timer[unique("Timer")];
#ifdef MTS420
	XMTS420M.GpsTimer -> TimerC.Timer[unique("Timer")];
#endif

#ifdef MTS420
// Wiring for gps
	XMTS420M.GpsControl -> UARTGpsPacket;
// XMTS420M.GpsSend -> UARTGpsPacket;
	XMTS420M.GpsReceive -> UARTGpsPacket;
	XMTS420M.GpsCmd -> UARTGpsPacket.GpsCmd;
#endif

// wiring for Xmesh components
	XMTS420M.XCommand -> XCommandC;
	XMTS420M.XEEControl -> XCommandC;
	XMTS420M.RouteControl -> MULTIHOPROUTER;
	XMTS420M.Send -> MULTIHOPROUTER.MhopSend[AM_XMULTIHOP_MSG];

	MULTIHOPROUTER.ReceiveMsg[AM_XMULTIHOP_MSG] -> Comm.ReceiveMsg[AM_XMULTIHOP_MSG];
	XMTS420M.HealthMsgGet -> MULTIHOPROUTER;

	XMTS420M.health_packet -> MULTIHOPROUTER.health_packet;
}
