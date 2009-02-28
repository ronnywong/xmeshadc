/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: XMTS410.nc,v 1.3.4.7 2007/04/26 20:19:51 njain Exp $
 */

/** 
 * XSensor multi-hop application for MTS410 sensorboard.
 *
 * @author PiPeng
 */

#include "appFeatures.h"
includes sensorboardApp;

configuration XMTS410 { 
// this module does not provide any interface
}
implementation
{
  components Main, SensirionHumidity,PIRC,ADCC, MTS410EEPROMC,
             IntersemaPressure,TimerC, Voltage,TaosPhoto,SounderC,Accel,RelayC,             
    	     GenericCommPromiscuous as Comm,

	MULTIHOPROUTER,  XMTS410M,QueuedSend,
#if FEATURE_UART_SEND
	HPLPowerManagementM,
#endif

#if SENSOR_MIC
	MicC,
#endif
	LEDS_COMPONENT

	XCommandC, Bcast; 

    Main.StdControl -> XMTS410M;
    Main.StdControl -> QueuedSend.StdControl;
    Main.StdControl -> MULTIHOPROUTER.StdControl;
    Main.StdControl -> Comm;
    Main.StdControl -> TimerC;

    LEDS_WIRING(XMTS410M)

#if FEATURE_UART_SEND
    // Wiring for UART msg.
    XMTS410M.PowerMgrDisable -> HPLPowerManagementM.Disable;
    XMTS410M.PowerMgrEnable -> HPLPowerManagementM.Enable;
    XMTS410M.SendUART -> QueuedSend.SendMsg[AM_XDEBUG_MSG];
#endif

#if SENSOR_MIC
    XMTS410M.MicControl -> MicC.StdControl;
    XMTS410M.Mic -> MicC;  
#endif
    XMTS410M.PirControl -> PIRC.StdControl;
    XMTS410M.MTS410EEPROMControl -> MTS410EEPROMC.StdControl;
    XMTS410M.MTS410EEPROM -> MTS410EEPROMC.MTS410EEPROM[0x54];

  // Wiring for Battery Ref
    XMTS410M.BattControl -> Voltage;  
    XMTS410M.ADCBATT -> Voltage;  
  
    XMTS410M.ADCControl -> ADCC;
    XMTS410M.ADC5    -> ADCC.ADC[TOS_ADC5_PORT];
    XMTS410M.ADC6    -> ADCC.ADC[TOS_ADC6_PORT];

// Wiring for Accelerometer  
    XMTS410M.AccelControl->Accel.StdControl;
    XMTS410M.AccelX -> Accel.AccelX;
    XMTS410M.AccelY -> Accel.AccelY;
  
// Wiring for Relay  
    XMTS410M.RelayControl->RelayC.RelayControl;
    XMTS410M.relay_normally_open -> RelayC.relay2;
    XMTS410M.relay_normally_closed -> RelayC.relay1;
  
// Wiring for Taos light sensor
    XMTS410M.TaosControl -> TaosPhoto;
    XMTS410M.TaosCh0 -> TaosPhoto.ADC[0];
    XMTS410M.TaosCh1 -> TaosPhoto.ADC[1];
  

// Wiring for Sensirion humidity/temperature sensor
    XMTS410M.TempHumControl -> SensirionHumidity;
    XMTS410M.Humidity -> SensirionHumidity.Humidity;
    XMTS410M.Temperature -> SensirionHumidity.Temperature;
    XMTS410M.HumidityError -> SensirionHumidity.HumidityError;
    XMTS410M.TemperatureError -> SensirionHumidity.TemperatureError;

// Wiring for Intersema barometric pressure/temperature sensor
    XMTS410M.IntersemaCal -> IntersemaPressure;

    XMTS410M.PressureControl -> IntersemaPressure;
    XMTS410M.IntersemaPressure -> IntersemaPressure.Pressure;
    XMTS410M.IntersemaTemp -> IntersemaPressure.Temperature;
  
    XMTS410M.Sounder -> SounderC;
    XMTS410M.PIR -> PIRC;
  
    XMTS410M.Timer -> TimerC.Timer[unique("Timer")];
    XMTS410M.PIRTimer -> TimerC.Timer[unique("Timer")];

    // Wiring for broadcast commands.
    XMTS410M.XCommand -> XCommandC;
    XMTS410M.XEEControl -> XCommandC;

    // Wiring for RF mesh networking.
    XMTS410M.RouteControl -> MULTIHOPROUTER;
    XMTS410M.Send -> MULTIHOPROUTER.MhopSend[AM_XMULTIHOP_MSG];
    MULTIHOPROUTER.ReceiveMsg[AM_XMULTIHOP_MSG] ->Comm.ReceiveMsg[AM_XMULTIHOP_MSG];
    XMTS410M.HealthMsgGet -> MULTIHOPROUTER; 
/*#ifdef XMESHSYNC    
    XMTS410M.DownTree -> MULTIHOPROUTER.Receive[0xc];
    MULTIHOPROUTER.ReceiveDownstreamMsg[0xc] -> Comm.ReceiveMsg[0xc];
#endif  */
    XMTS410M.health_packet -> MULTIHOPROUTER.health_packet;

}



