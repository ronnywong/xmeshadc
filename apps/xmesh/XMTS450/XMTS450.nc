/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: XMTS450.nc,v 1.4.4.3 2007/04/26 20:22:25 njain Exp $
 */

/** 
 * XSensor multi-hop application for MTS450 sensorboard.
 *
 * @author Tang Junhua, Pi Peng
 */


#include "appFeatures.h"

includes sensorboardApp;

configuration XMTS450 { 
// this module does not provide any interface
}
implementation
{
    components Main, TimerC, 
	GenericCommPromiscuous as Comm,
	MULTIHOPROUTER, XMTS450M, QueuedSend,
	Voltage, XCommandC, SensirionHumidity, MTS450EEPROMC, MTS450CTSC,
	 
#if FEATURE_UART_SEND
	HPLPowerManagementM,
#endif

	LEDS_COMPONENT

	Bcast;

    Main.StdControl -> XMTS450M;
    Main.StdControl -> QueuedSend.StdControl;



    Main.StdControl -> MULTIHOPROUTER.StdControl;
    Main.StdControl -> Comm;
    Main.StdControl -> TimerC;

    LEDS_WIRING(XMTS450M)

#if FEATURE_UART_SEND
    // Wiring for UART msg.
    XMTS450M.PowerMgrDisable -> HPLPowerManagementM.Disable;
    XMTS450M.PowerMgrEnable -> HPLPowerManagementM.Enable;
    XMTS450M.SendUART -> QueuedSend.SendMsg[AM_XDEBUG_MSG];
    //XMTS310M.SendUART -> Comm.SendMsg[XDEBUGMSG_ID];
#endif

    XMTS450M.Timer -> TimerC.Timer[unique("Timer")];

    // Wiring for Battery Ref
    XMTS450M.BattControl -> Voltage;  
    XMTS450M.ADCBATT -> Voltage;  
   
    XMTS450M.ADCControl -> SensirionHumidity;
    XMTS450M.Humidity -> SensirionHumidity.Humidity;
    XMTS450M.Temperature -> SensirionHumidity.Temperature;

    XMTS450M.HumidityError -> SensirionHumidity.HumidityError;
    XMTS450M.TemperatureError -> SensirionHumidity.TemperatureError;

    //test EEPEOM on mts450 board
    XMTS450M.MTS450EEPROMControl -> MTS450EEPROMC.StdControl;
    XMTS450M.MTS450EEPROM -> MTS450EEPROMC.MTS450EEPROM[0x50];

    //test I2C ADS 7828 AD converter using for converting CTS sensor
    XMTS450M.MTS450CTSControl -> MTS450CTSC.StdControl;
    XMTS450M.MTS450CTS -> MTS450CTSC.MTS450CTS[0x4A];

	XMTS450M.XCommand -> XCommandC;  
	XMTS450M.XEEControl -> XCommandC;

    // Wiring for RF mesh networking.
    XMTS450M.RouteControl -> MULTIHOPROUTER;
    XMTS450M.Send -> MULTIHOPROUTER.MhopSend[AM_XMULTIHOP_MSG];
    MULTIHOPROUTER.ReceiveMsg[AM_XMULTIHOP_MSG] ->Comm.ReceiveMsg[AM_XMULTIHOP_MSG];
    XMTS450M.HealthMsgGet -> MULTIHOPROUTER;
    XMTS450M.health_packet -> MULTIHOPROUTER.health_packet;    
   
}

