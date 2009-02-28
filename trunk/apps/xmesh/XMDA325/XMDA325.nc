/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: XMDA325.nc,v 1.4.4.3 2007/04/26 20:09:56 njain Exp $
 */
 
/** 
 * XSensor multi-hop application for MDA325 sensorboard.
 *
 * @author PiPeng
 */


// include local hardware defs for this sensor board app
includes sensorboardApp;
#include "appFeatures.h"
includes sensorboardApp;
configuration XMDA325 { 
// this module does not provide any interface
}

implementation {
    
    components Main,  
    GenericCommPromiscuous as Comm,
    MULTIHOPROUTER,XMDA325M, QueuedSend,
#if FEATURE_UART_SEND
	HPLPowerManagementM,
#endif
	LEDS_COMPONENT
	XCommandC, Bcast, 
    SamplerC,TimerC;
  
    Main.StdControl -> XMDA325M;
    
    Main.StdControl -> QueuedSend.StdControl;
    Main.StdControl -> MULTIHOPROUTER.StdControl;
    Main.StdControl -> Comm;
    Main.StdControl -> TimerC;
    LEDS_WIRING(XMDA325M)
  
#if FEATURE_UART_SEND
    // Wiring for UART msg.
    XMDA325M.PowerMgrDisable -> HPLPowerManagementM.Disable;
    XMDA325M.PowerMgrEnable -> HPLPowerManagementM.Enable;
    XMDA325M.SendUART -> QueuedSend.SendMsg[AM_XDEBUG_MSG];
    //XMDA325M.SendUART -> Comm.SendMsg[XDEBUGMSG_ID];
#endif
   
    XMDA325M.Timer -> TimerC.Timer[unique("Timer")];
    XMDA325M.TO_Timer -> TimerC.Timer[unique("Timer")];
    
    //Sampler Communication
    
    XMDA325M.SamplerControl -> SamplerC.SamplerControl;
    
    XMDA325M.Sample -> SamplerC.Sample;
 
    //support for plug and play.
    
    XMDA325M.PlugPlay -> SamplerC.PlugPlay;
    
    
    // Wiring for broadcast commands.
    XMDA325M.XCommand -> XCommandC;
    XMDA325M.XEEControl -> XCommandC;
	
    // Wiring for RF mesh networking.
    XMDA325M.RouteControl -> MULTIHOPROUTER;
    XMDA325M.Send -> MULTIHOPROUTER.MhopSend[AM_XMULTIHOP_MSG];
    MULTIHOPROUTER.ReceiveMsg[AM_XMULTIHOP_MSG] ->Comm.ReceiveMsg[AM_XMULTIHOP_MSG];
    XMDA325M.HealthMsgGet -> MULTIHOPROUTER;
/*#ifdef XMESHSYNC    
    XMDA325M.DownTree -> MULTIHOPROUTER.Receive[0xc];
    MULTIHOPROUTER.ReceiveDownstreamMsg[0xc] -> Comm.ReceiveMsg[0xc];
#endif  */
   XMDA325M.health_packet -> MULTIHOPROUTER.health_packet;
    
}
