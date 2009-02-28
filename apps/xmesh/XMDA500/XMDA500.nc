/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: XMDA500.nc,v 1.3.4.4 2007/04/26 20:10:50 njain Exp $
 */

/** 
 * XSensor multi-hop application for MDA500 sensorboard.
 *
 * @author Martin Turon, Alan Broad, Hu Siquan, Pi Peng
 */

#include "appFeatures.h"



includes sensorboardApp;

configuration XMDA500 { 

// this module does not provide any interface

}

implementation

{

  components Main, TimerC, ADCC,

    GenericCommPromiscuous as Comm,Voltage,
    
    MULTIHOPROUTER, XMDA500M, QueuedSend,

#if FEATURE_UART_SEND

	HPLPowerManagementM,

#endif

	LEDS_COMPONENT


	XCommandC, Bcast; 





    Main.StdControl -> XMDA500M;
    

    Main.StdControl -> QueuedSend.StdControl;

    Main.StdControl -> MULTIHOPROUTER.StdControl;

    Main.StdControl -> Comm;

    Main.StdControl -> TimerC;




    LEDS_WIRING(XMDA500M)



    XMDA500M.ADCControl -> ADCC;

    XMDA500M.ADCTEMP -> ADCC.ADC[TEMP_ADC_PORT];

    XMDA500M.ADC2    -> ADCC.ADC[ADC2_PORT];

    XMDA500M.ADC3    -> ADCC.ADC[ADC3_PORT];

    XMDA500M.ADC4    -> ADCC.ADC[ADC4_PORT];

    XMDA500M.ADC5    -> ADCC.ADC[ADC5_PORT];

    XMDA500M.ADC6    -> ADCC.ADC[ADC6_PORT];

    XMDA500M.ADC7    -> ADCC.ADC[ADC7_PORT];

      
    // Wiring for Battery Ref
    XMDA500M.BattControl -> Voltage;  
    XMDA500M.ADCBATT -> Voltage;  

      

    XMDA500M.Timer -> TimerC.Timer[unique("Timer")];


    // Wiring for broadcast commands.
    XMDA500M.health_packet -> MULTIHOPROUTER.health_packet;
    XMDA500M.XCommand -> XCommandC;
    XMDA500M.XEEControl -> XCommandC;

    // Wiring for RF mesh networking.

    XMDA500M.RouteControl -> MULTIHOPROUTER;

    XMDA500M.Send -> MULTIHOPROUTER.MhopSend[AM_XMULTIHOP_MSG];
    MULTIHOPROUTER.ReceiveMsg[AM_XMULTIHOP_MSG] ->Comm.ReceiveMsg[AM_XMULTIHOP_MSG];
    XMDA500M.HealthMsgGet -> MULTIHOPROUTER;
    

}



