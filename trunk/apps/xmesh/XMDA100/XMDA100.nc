/// $Id: XMDA100.nc,v 1.3.4.3 2007/04/26 20:06:18 njain Exp $ 

/*

 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: XMDA100.nc,v 1.3.4.3 2007/04/26 20:06:18 njain Exp $
 */


/** 
 * XSensor multi-hop application for MDA100 sensorboard.
 *
 * @author Pi Peng, Ning Xu
 */
 
/*
 *
 * Description:
 * 
 * Ported to XMesh2 by Ning Xu 
 * Date: 11/15/05
 *
*/
#include "appFeatures.h"
includes sensorboardApp;

configuration XMDA100 { 
// this module does not provide any interface
}
implementation
{
  components Main,
             TimerC,
             Voltage, PhotoTemp, ADCC,
             GenericCommPromiscuous as Comm,
	     MULTIHOPROUTER, XMDA100M,QueuedSend,
#if FEATURE_UART_SEND
	HPLPowerManagementM,
#endif
             LEDS_COMPONENT
        
	           XCommandC, Bcast; 

    Main.StdControl -> XMDA100M;
    Main.StdControl -> QueuedSend.StdControl;
    Main.StdControl -> MULTIHOPROUTER.StdControl;
    Main.StdControl -> Comm;
    Main.StdControl -> TimerC;

    LEDS_WIRING(XMDA100M)

#if FEATURE_UART_SEND
    // Wiring for UART msg.
    XMDA100M.PowerMgrDisable -> HPLPowerManagementM.Disable;
    XMDA100M.PowerMgrEnable -> HPLPowerManagementM.Enable;
    XMDA100M.SendUART -> QueuedSend.SendMsg[AM_XDEBUG_MSG];
#endif

    // Wiring for Battery Ref
    XMDA100M.BattControl -> Voltage;  
    XMDA100M.ADCBATT -> Voltage;  

    XMDA100M.TempControl -> PhotoTemp.TempStdControl;
    XMDA100M.Temperature -> PhotoTemp.ExternalTempADC; 

    XMDA100M.PhotoControl -> PhotoTemp.PhotoStdControl; 
    XMDA100M.Light -> PhotoTemp.ExternalPhotoADC; 
    
    XMDA100M.ADCControl -> ADCC;
    XMDA100M.ADC2    -> ADCC.ADC[TOS_ADC2_PORT];
    XMDA100M.ADC3    -> ADCC.ADC[TOS_ADC3_PORT];
    XMDA100M.ADC4    -> ADCC.ADC[TOS_ADC4_PORT];
    XMDA100M.ADC5    -> ADCC.ADC[TOS_ADC5_PORT];
    XMDA100M.ADC6    -> ADCC.ADC[TOS_ADC6_PORT];
    
    
    XMDA100M.Timer -> TimerC.Timer[unique("Timer")];

    // Wiring for broadcast commands.
    XMDA100M.XCommand -> XCommandC;
    XMDA100M.XEEControl -> XCommandC;

    // Wiring for RF mesh networking.
    XMDA100M.RouteControl -> MULTIHOPROUTER;
    XMDA100M.Send -> MULTIHOPROUTER.MhopSend[AM_XMULTIHOP_MSG];
    MULTIHOPROUTER.ReceiveMsg[AM_XMULTIHOP_MSG] ->Comm.ReceiveMsg[AM_XMULTIHOP_MSG];
    XMDA100M.HealthMsgGet -> MULTIHOPROUTER; 
    XMDA100M.health_packet -> MULTIHOPROUTER.health_packet;

}



