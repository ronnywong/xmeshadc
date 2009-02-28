/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2004 SenseTech Software
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: Detect.nc,v 1.4.2.3 2007/04/26 20:13:51 njain Exp $
 */

/** 
 * Brief description of code module.
 *
 * @author Tim Reilly, Martin Turon, Pi Peng
 */

#include "appFeatures.h" 
includes sensorboardApp;

/**
 * Intruder detection application
 * 
 * @modified  8/18/04
 *
 * @author Tim Reilly
 */
configuration Detect 
{ 
}

implementation
{

	components		Main,
				PIRC,
				SounderC,
				MicIntC,
				MaglibC,
				LEDS_COMPONENT
				TimerC,
				ADCC,
//				SerialIDC,
//				CC1000ControlM,
				QueuedSend,
				MULTIHOPROUTER,
				GenericCommPromiscuous as Comm,
				DetectM,
				XCommandC, Bcast; ;
				
	Main.StdControl -> DetectM;
	Main.StdControl -> Comm;
	Main.StdControl -> TimerC;
	Main.StdControl -> MULTIHOPROUTER.StdControl;
	Main.StdControl -> QueuedSend.StdControl;
	Main.StdControl -> MicIntC;
	Main.StdControl -> PIRC;
	Main.StdControl -> MaglibC;



	LEDS_WIRING(DetectM)

	DetectM.ADC -> ADCC.ADC[9];
	DetectM.ADCControl -> ADCC;

	// Wiring for RF mesh networking.
	DetectM.RouteControl -> MULTIHOPROUTER;
	DetectM.Send -> MULTIHOPROUTER.MhopSend[AM_XMULTIHOP_MSG];
	MULTIHOPROUTER.ReceiveMsg[AM_XMULTIHOP_MSG] ->Comm.ReceiveMsg[AM_XMULTIHOP_MSG];
	DetectM.HealthMsgGet -> MULTIHOPROUTER; 
	DetectM.health_packet -> MULTIHOPROUTER.health_packet;
	
	// Wiring for broadcast commands.
	DetectM.XCommand -> XCommandC;
	DetectM.XEEControl -> XCommandC;
	
	
	DetectM.PIR -> PIRC;
    
	DetectM.Mic -> MicIntC;
	DetectM.Maglib -> MaglibC;
	DetectM.Sounder -> SounderC;
	DetectM.SampleTimer -> TimerC.Timer[unique("Timer")];
	DetectM.PIRTimer -> TimerC.Timer[unique("Timer")];
 	DetectM.HBTimer -> TimerC.Timer[unique("Timer")];
	DetectM.MicInterrupt -> MicIntC.Interrupt;
	DetectM.MicSample -> MicIntC.Sample;
	MicIntC.IntOutput -> DetectM.MicOutput;
}

