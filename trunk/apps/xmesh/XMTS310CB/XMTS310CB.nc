/// $Id: XMTS310CB.nc,v 1.1.2.1 2007/04/24 06:37:09 mturon Exp $ 

/*
 * Copyright (c) 2005-2006 Crossbow Technology, Inc.
 * All rights reserved.
 *
 * Use, copy, modification, reproduction and distribution of 
 * this software and documentation are governed by the 
 * Crossbow Technology End User License Agreement.  
 * To obtain a copy of this Agreement, please contact 
 * Crossbow Technology, 4145 N. First St., San Jose, CA 95134.
 */ 

/** 
 * XSensor multi-hop application for MTS310 sensorboard.
 *
 * @author Martin Turon, Alan Broad, Hu Siquan, Pi Peng
 */

#include "appFeatures.h"

includes sensorboardApp;

configuration XMTS310CB { 
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

