/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: XMTS101.nc,v 1.3.4.3 2007/04/26 20:15:20 njain Exp $
 */

/** 
 * XSensor multi-hop application for MTS101 sensorboard.
 *
 * @author Martin Turon, Alan Broad, Hu Siquan, Pi Peng
 */
 
#include "appFeatures.h"
includes sensorboardApp;

configuration XMTS101 { 
// this module does not provide any interface
}
implementation
{
  components Main,  TimerC, Voltage, Temp, ADCC, Photo,
    GenericCommPromiscuous as Comm,
    
    MULTIHOPROUTER,XMTS101M, QueuedSend,
#if FEATURE_UART_SEND
	HPLPowerManagementM,
#endif
	LEDS_COMPONENT

	XCommandC, Bcast; 

    Main.StdControl -> XMTS101M;
    Main.StdControl -> QueuedSend.StdControl;
    Main.StdControl -> MULTIHOPROUTER.StdControl;
    Main.StdControl -> Comm;
    Main.StdControl -> TimerC;

    LEDS_WIRING(XMTS101M)

#if FEATURE_UART_SEND
    // Wiring for UART msg.
    XMTS101M.PowerMgrDisable -> HPLPowerManagementM.Disable;
    XMTS101M.PowerMgrEnable -> HPLPowerManagementM.Enable;
    XMTS101M.SendUART -> QueuedSend.SendMsg[AM_XDEBUG_MSG];
    //XMTS310M.SendUART -> Comm.SendMsg[XDEBUGMSG_ID];
#endif

    // Wiring for Battery Ref
    XMTS101M.BattControl -> Voltage;  
    XMTS101M.ADCBATT -> Voltage;  

    XMTS101M.TempControl -> Temp;
    XMTS101M.Temperature -> Temp;

    XMTS101M.PhotoControl -> Photo;
    XMTS101M.Light -> Photo.PhotoADC;
    
    XMTS101M.ADCControl -> ADCC;
    XMTS101M.ADC0    -> ADCC.ADC[TOS_ADC_MAG_X_PORT];
    XMTS101M.ADC1    -> ADCC.ADC[TOS_ADC_MAG_Y_PORT];
    XMTS101M.ADC2    -> ADCC.ADC[TOS_ADC_MIC_PORT];
    XMTS101M.ADC3    -> ADCC.ADC[TOS_ADC_ACCEL_X_PORT];
    XMTS101M.ADC4    -> ADCC.ADC[TOS_ADC_ACCEL_Y_PORT];
    
    
    XMTS101M.Timer -> TimerC.Timer[unique("Timer")];

    // Wiring for broadcast commands.
    XMTS101M.XCommand -> XCommandC;
    XMTS101M.XEEControl -> XCommandC;

    // Wiring for RF mesh networking.
    XMTS101M.RouteControl -> MULTIHOPROUTER;
    XMTS101M.Send -> MULTIHOPROUTER.MhopSend[AM_XMULTIHOP_MSG];
    MULTIHOPROUTER.ReceiveMsg[AM_XMULTIHOP_MSG] ->Comm.ReceiveMsg[AM_XMULTIHOP_MSG];
    XMTS101M.HealthMsgGet -> MULTIHOPROUTER; 
/*#ifdef XMESHSYNC    
    XMTS101M.DownTree -> MULTIHOPROUTER.Receive[0xc];
    MULTIHOPROUTER.ReceiveDownstreamMsg[0xc] -> Comm.ReceiveMsg[0xc];
#endif  */
    XMTS101M.health_packet -> MULTIHOPROUTER.health_packet;

}



