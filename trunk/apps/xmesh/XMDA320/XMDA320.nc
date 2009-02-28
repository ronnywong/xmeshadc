/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: XMDA320.nc,v 1.4.4.4 2007/04/26 20:09:01 njain Exp $
 */

/** 
 * XSensor multi-hop application for MDA320 sensorboard.
 *
 * @author Pi Peng
 */

// include local hardware defs for this sensor board app
includes sensorboardApp;
#include "appFeatures.h"

configuration XMDA320 { 
// this module does not provide any interface
}

implementation {
    
    components Main,  
    GenericCommPromiscuous as Comm,
    MULTIHOPROUTER,XMDA320M, QueuedSend,
#if FEATURE_UART_SEND
	HPLPowerManagementM,
#endif
	LEDS_COMPONENT
	XCommandC, Bcast, 
    SamplerC,TimerC;
  
    Main.StdControl -> XMDA320M;
    
    Main.StdControl -> QueuedSend.StdControl;
    Main.StdControl -> MULTIHOPROUTER.StdControl;
    Main.StdControl -> Comm;
    Main.StdControl -> TimerC;
    LEDS_WIRING(XMDA320M)
  
#if FEATURE_UART_SEND
    // Wiring for UART msg.
    XMDA320M.PowerMgrDisable -> HPLPowerManagementM.Disable;
    XMDA320M.PowerMgrEnable -> HPLPowerManagementM.Enable;
    XMDA320M.SendUART -> QueuedSend.SendMsg[AM_XDEBUG_MSG];
    //XMTS310M.SendUART -> Comm.SendMsg[XDEBUGMSG_ID];
#endif
   
    XMDA320M.Timer -> TimerC.Timer[unique("Timer")];
    XMDA320M.TO_Timer -> TimerC.Timer[unique("Timer")];
    
    //Sampler Communication
    
    XMDA320M.SamplerControl -> SamplerC.SamplerControl;
    
    XMDA320M.Sample -> SamplerC.Sample;
 
    //support for plug and play.
    
    XMDA320M.PlugPlay -> SamplerC.PlugPlay;
    
    
    // Wiring for broadcast commands.
    XMDA320M.XCommand -> XCommandC;
    XMDA320M.XEEControl -> XCommandC;
	
    // Wiring for RF mesh networking.
    XMDA320M.RouteControl -> MULTIHOPROUTER;
    XMDA320M.Send -> MULTIHOPROUTER.MhopSend[AM_XMULTIHOP_MSG];
    MULTIHOPROUTER.ReceiveMsg[AM_XMULTIHOP_MSG] ->Comm.ReceiveMsg[AM_XMULTIHOP_MSG];
    XMDA320M.HealthMsgGet -> MULTIHOPROUTER;
/*#ifdef XMESHSYNC    
    XMDA320M.DownTree -> MULTIHOPROUTER.Receive[0xc];
    MULTIHOPROUTER.ReceiveDownstreamMsg[0xc] -> Comm.ReceiveMsg[0xc];
#endif  */
   XMDA320M.health_packet -> MULTIHOPROUTER.health_packet;
    
}
