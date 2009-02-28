/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: XMTS510.nc,v 1.3.4.5 2007/04/26 20:23:20 njain Exp $
 */

/** 
 * XSensor multi-hop application for MTS510 sensorboard.
 *
 * @author Martin Turon, Alan Broad, Hu Siquan, Pi Peng
 */

#include "appFeatures.h"
includes sensorboardApp;

configuration XMTS510 {
}
implementation {

  components Main, Photo, Accel, MicC, TimerC,
    GenericCommPromiscuous as Comm,ADCC,Voltage,
	MULTIHOPROUTER,XMTS510M, QueuedSend,

#if FEATURE_UART_SEND
	HPLPowerManagementM,
#endif

	LEDS_COMPONENT
	XCommandC, Bcast; 

    Main.StdControl -> XMTS510M;
    Main.StdControl -> QueuedSend.StdControl;
    Main.StdControl -> MULTIHOPROUTER.StdControl;
    Main.StdControl -> Comm;
    Main.StdControl -> TimerC;

    LEDS_WIRING(XMTS510M)

    XMTS510M.Timer -> TimerC.Timer[unique("Timer")];
    XMTS510M.MicTimer -> TimerC.Timer[unique("Timer")];

    XMTS510M.ADCControl -> ADCC;
    XMTS510M.ADCTEMP -> ADCC.ADC[TEMP_ADC_PORT];
    XMTS510M.MicControl -> MicC;
    XMTS510M.MicADC -> MicC; 
    XMTS510M.Mic -> MicC;

    XMTS510M.PhotoControl -> Photo; 
    XMTS510M.PhotoADC -> Photo; 
    
    XMTS510M.AccelControl->Accel;
    XMTS510M.AccelX -> Accel.AccelX;
    XMTS510M.AccelY -> Accel.AccelY;

    // Wiring for Battery Ref
    XMTS510M.BattControl -> Voltage;  
    XMTS510M.ADCBATT -> Voltage;  
    
    // Wiring for broadcast commands.
    XMTS510M.XCommand -> XCommandC;
    XMTS510M.XEEControl -> XCommandC;
    
    // Wiring for RF mesh networking.
    XMTS510M.RouteControl -> MULTIHOPROUTER;
    XMTS510M.Send -> MULTIHOPROUTER.MhopSend[AM_XMULTIHOP_MSG];
    MULTIHOPROUTER.ReceiveMsg[AM_XMULTIHOP_MSG] ->Comm.ReceiveMsg[AM_XMULTIHOP_MSG];
    XMTS510M.HealthMsgGet -> MULTIHOPROUTER;
    XMTS510M.health_packet -> MULTIHOPROUTER.health_packet;



} 

