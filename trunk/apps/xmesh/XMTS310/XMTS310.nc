/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: XMTS310.nc,v 1.3.4.4 2007/04/26 20:18:03 njain Exp $
 */

/** 
 * XSensor multi-hop application for MTS310 sensorboard.
 *
 * @author Martin Turon, Alan Broad, Hu Siquan, Pi Peng
 */

#include "appFeatures.h"

includes sensorboardApp;

configuration XMTS310 { 
// this module does not provide any interface
}
implementation
{
    components Main,
               TimerC,                              
	             GenericCommPromiscuous as Comm,
	             MULTIHOPROUTER,XMTS310M, QueuedSend,
	             Voltage, MicC, PhotoTemp, Accel, Mag, Sounder, 
	             
	             XCommandC, 
	HPLPowerManagementM,
	LEDS_COMPONENT
	Bcast;

    Main.StdControl -> XMTS310M;
    Main.StdControl -> QueuedSend.StdControl;

    Main.StdControl -> MULTIHOPROUTER.StdControl;
    Main.StdControl -> Comm;
    Main.StdControl -> TimerC;

    LEDS_WIRING(XMTS310M)

    // Wiring for UART msg.
    XMTS310M.PowerMgrDisable -> HPLPowerManagementM.Disable;
    XMTS310M.PowerMgrEnable -> HPLPowerManagementM.Enable;
#if FEATURE_UART_SEND
    XMTS310M.SendUART -> QueuedSend.SendMsg[AM_XDEBUG_MSG];
#endif

    XMTS310M.Timer -> TimerC.Timer[unique("Timer")];

    // Wiring for Battery Ref
    XMTS310M.BattControl -> Voltage;  
    XMTS310M.ADCBATT -> Voltage;  
   
    XMTS310M.TempControl -> PhotoTemp.TempStdControl;
    XMTS310M.Temperature -> PhotoTemp.ExternalTempADC;

    XMTS310M.PhotoControl -> PhotoTemp.PhotoStdControl;
    XMTS310M.Light -> PhotoTemp.ExternalPhotoADC;
    
    XMTS310M.Sounder -> Sounder;
    
    XMTS310M.MicControl -> MicC;
    XMTS310M.MicADC -> MicC;
    XMTS310M.Mic -> MicC;
    
    XMTS310M.AccelControl -> Accel;
    XMTS310M.AccelX -> Accel.AccelX;
    XMTS310M.AccelY -> Accel.AccelY;
    
    XMTS310M.MagControl-> Mag;
    XMTS310M.MagX -> Mag.MagX;
    XMTS310M.MagY -> Mag.MagY;
    
    XMTS310M.XCommand -> XCommandC;  
    XMTS310M.XEEControl -> XCommandC;

    // Wiring for RF mesh networking.
    XMTS310M.RouteControl -> MULTIHOPROUTER;
    XMTS310M.Send -> MULTIHOPROUTER.MhopSend[AM_XMULTIHOP_MSG];
    MULTIHOPROUTER.ReceiveMsg[AM_XMULTIHOP_MSG] ->Comm.ReceiveMsg[AM_XMULTIHOP_MSG];  
    XMTS310M.HealthMsgGet -> MULTIHOPROUTER; 
    XMTS310M.health_packet -> MULTIHOPROUTER;
}

