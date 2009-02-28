/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: XMDA300_D.nc,v 1.1.2.2 2007/04/26 20:08:16 njain Exp $
 */

/** 
 * XSensor multi-hop application for MDA300 sensorboard.
 *
 * @author Martin Turon, Alan Broad, Hu Siquan, Pi Peng
 */

// include local hardware defs for this sensor board app
includes sensorboardApp;
#include "appFeatures.h"
includes sensorboardApp;
configuration XMDA300_D { 
// this module does not provide any interface
}

implementation {
    
    components Main,  
    GenericCommPromiscuous as Comm,
    MULTIHOPROUTER,XMDA300M, QueuedSend,
#if FEATURE_UART_SEND
	HPLPowerManagementM,
#endif
	LEDS_COMPONENT
	XCommandC, Bcast, 
        SamplerC,TimerC;
  
    Main.StdControl -> XMDA300M;
    
    Main.StdControl -> QueuedSend.StdControl;
    Main.StdControl -> MULTIHOPROUTER.StdControl;
    Main.StdControl -> Comm;
    Main.StdControl -> TimerC;
    LEDS_WIRING(XMDA300M)
  
#if FEATURE_UART_SEND
    // Wiring for UART msg.
    XMDA300M.PowerMgrDisable -> HPLPowerManagementM.Disable;
    XMDA300M.PowerMgrEnable -> HPLPowerManagementM.Enable;
    XMDA300M.SendUART -> QueuedSend.SendMsg[AM_XDEBUG_MSG];
#endif
   
    XMDA300M.Timer -> TimerC.Timer[unique("Timer")];
    
    //Sampler Communication
    
    XMDA300M.SamplerControl -> SamplerC.SamplerControl;
    
    XMDA300M.Sample -> SamplerC.Sample;
 
    //support for plug and play.
    
    XMDA300M.PlugPlay -> SamplerC.PlugPlay;
    
    //relays
    
    XMDA300M.relay_normally_closed -> SamplerC.relay_normally_closed;
    
    XMDA300M.relay_normally_open -> SamplerC.relay_normally_open;
    
    
    // Wiring for broadcast commands.
    XMDA300M.XCommand -> XCommandC;
    XMDA300M.XEEControl -> XCommandC;
	
    // Wiring for RF mesh networking.
    XMDA300M.RouteControl -> MULTIHOPROUTER;
    XMDA300M.Send -> MULTIHOPROUTER.MhopSend[AM_XMULTIHOP_MSG];
    MULTIHOPROUTER.ReceiveMsg[AM_XMULTIHOP_MSG] ->Comm.ReceiveMsg[AM_XMULTIHOP_MSG];
    XMDA300M.HealthMsgGet -> MULTIHOPROUTER.HealthMsgGet;
/*
#ifdef XMESHSYNC    
    XMDA300M.DownTree -> MULTIHOPROUTER.Receive[0xc];
#endif  */
    XMDA300M.health_packet -> MULTIHOPROUTER.health_packet;
}
