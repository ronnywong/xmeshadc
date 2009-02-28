/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: XMEP510.nc,v 1.3.4.4 2007/04/26 20:12:48 njain Exp $
 */

/** 
 * XSensor multi-hop application for MEP510 sensorboard.
 *
 * @author Martin Turon, PiPeng
 */


#include "appFeatures.h"

includes sensorboardApp;



configuration XMEP510 { 

// this module does not provide any interface

}

implementation

{

    components Main, SensirionHumidity, TimerC,ADCC,Voltage,
    GenericCommPromiscuous as Comm,
    MULTIHOPROUTER, XMEP510M, QueuedSend,

#if FEATURE_UART_SEND
	HPLPowerManagementM,
#endif

	LEDS_COMPONENT
	XCommandC, Bcast; 

    Main.StdControl -> XMEP510M;    

    Main.StdControl -> QueuedSend.StdControl;
    Main.StdControl -> MULTIHOPROUTER.StdControl;
    Main.StdControl -> Comm;
    Main.StdControl -> TimerC;

    LEDS_WIRING(XMEP510M)

    XMEP510M.Timer -> TimerC.Timer[unique("Timer")];

    XMEP510M.ADCTEMP -> ADCC.ADC[TEMP_ADC_PORT];
    XMEP510M.ADCControl -> ADCC;
    
    // Wiring for Battery Ref
    XMEP510M.BattControl -> Voltage;  
    XMEP510M.ADCBATT -> Voltage;  

  XMEP510M.HumControl -> SensirionHumidity;
  XMEP510M.Humidity -> SensirionHumidity.Humidity;
  XMEP510M.Temperature -> SensirionHumidity.Temperature;  

  XMEP510M.HumidityError -> SensirionHumidity.HumidityError;
  XMEP510M.TemperatureError -> SensirionHumidity.TemperatureError;
   
    // Wiring for broadcast commands.
    XMEP510M.XCommand -> XCommandC;
    XMEP510M.XEEControl -> XCommandC;

    // Wiring for RF mesh networking.

    XMEP510M.RouteControl -> MULTIHOPROUTER;
    XMEP510M.Send -> MULTIHOPROUTER.MhopSend[AM_XMULTIHOP_MSG];
    MULTIHOPROUTER.ReceiveMsg[AM_XMULTIHOP_MSG] ->Comm.ReceiveMsg[AM_XMULTIHOP_MSG];
    XMEP510M.HealthMsgGet -> MULTIHOPROUTER; 

    //XMEP510M.XOTAPLoader -> MULTIHOPROUTER;
    XMEP510M.health_packet -> MULTIHOPROUTER;
}
