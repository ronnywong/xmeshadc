/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: XMTS300.nc,v 1.1.2.3 2007/04/26 20:17:09 njain Exp $
 */

/** 
 * XSensor multi-hop application for MTS310 sensorboard.
 *
 * @author Martin Turon, Alan Broad, Hu Siquan, Pi Peng
 */

#include "appFeatures.h"

includes sensorboardApp;

configuration XMTS300 { 
// this module does not provide any interface
}
implementation
{
    components Main,
               TimerC,                              
	             GenericCommPromiscuous as Comm,
	             MULTIHOPROUTER,XMTS300M, QueuedSend,
	             Voltage, MicC, PhotoTemp, Accel, Mag, Sounder, 
	             
	             XCommandC, 

	HPLPowerManagementM,

	LEDS_COMPONENT
	Bcast;

    Main.StdControl -> XMTS300M;
    Main.StdControl -> QueuedSend.StdControl;

    Main.StdControl -> MULTIHOPROUTER.StdControl;
    Main.StdControl -> Comm;
    Main.StdControl -> TimerC;

    LEDS_WIRING(XMTS300M)

    XMTS300M.PowerMgrDisable -> HPLPowerManagementM.Disable;
    XMTS300M.PowerMgrEnable -> HPLPowerManagementM.Enable;
#if FEATURE_UART_SEND
    XMTS300M.SendUART -> QueuedSend.SendMsg[AM_XDEBUG_MSG];
#endif

    XMTS300M.Timer -> TimerC.Timer[unique("Timer")];

    // Wiring for Battery Ref
    XMTS300M.BattControl -> Voltage;  
    XMTS300M.ADCBATT -> Voltage;  
   
    XMTS300M.TempControl -> PhotoTemp.TempStdControl;
    XMTS300M.Temperature -> PhotoTemp.ExternalTempADC;

    XMTS300M.PhotoControl -> PhotoTemp.PhotoStdControl;
    XMTS300M.Light -> PhotoTemp.ExternalPhotoADC;
    
    XMTS300M.Sounder -> Sounder;
    
    XMTS300M.MicControl -> MicC;
    XMTS300M.MicADC -> MicC;
    XMTS300M.Mic -> MicC;
    
    XMTS300M.AccelControl -> Accel;
    XMTS300M.AccelX -> Accel.AccelX;
    XMTS300M.AccelY -> Accel.AccelY;
    
    XMTS300M.MagControl-> Mag;
    XMTS300M.MagX -> Mag.MagX;
    XMTS300M.MagY -> Mag.MagY;
    
    XMTS300M.XCommand -> XCommandC;  
    XMTS300M.XEEControl -> XCommandC;

    // Wiring for RF mesh networking.
    XMTS300M.RouteControl -> MULTIHOPROUTER;
    XMTS300M.Send -> MULTIHOPROUTER.MhopSend[AM_XMULTIHOP_MSG];
    MULTIHOPROUTER.ReceiveMsg[AM_XMULTIHOP_MSG] ->Comm.ReceiveMsg[AM_XMULTIHOP_MSG];  
    XMTS300M.HealthMsgGet -> MULTIHOPROUTER; 
    XMTS300M.health_packet -> MULTIHOPROUTER;
}

