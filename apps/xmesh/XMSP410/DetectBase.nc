/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2004 SenseTech Software
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: DetectBase.nc,v 1.1.4.2 2007/04/26 20:14:00 njain Exp $
 */
 
/******************************************************************************
 *	Mobile Pipeline Intrusion Detection System (MPIDS)
 *
 *	Authors:	Tim Reilly
 *****************************************************************************/
 
includes msg;
includes global;

/**
 * Intruder detection application
 * 
 * @modified  8/18/04
 *
 * @author Tim Reilly
 */
configuration DetectBase 
{ 
}

implementation
{    
    components	Main,
	DetectBaseM,
	LedsC as Leds, 
	TimerC,
	CC1000ControlM,
	QueuedSend,
	MULTIHOPROUTER,
	GenericCommPromiscuous as Comm;
    
    Main.StdControl -> DetectBaseM;
    Main.StdControl -> Comm;
    Main.StdControl -> TimerC;
    Main.StdControl -> MULTIHOPROUTER;
    Main.StdControl -> QueuedSend.StdControl;
    
    DetectBaseM.Leds -> Leds;
    
    
    DetectBaseM.RouteControl -> MULTIHOPROUTER;
    DetectBaseM.Send -> MULTIHOPROUTER.Send[XMULTIHOPMSG_ID];
    MULTIHOPROUTER.ReceiveMsg[XMULTIHOPMSG_ID] -> Comm.ReceiveMsg[XMULTIHOPMSG_ID];
    
    DetectBaseM.RadioControl -> CC1000ControlM;	
    
    DetectBaseM.SampleTimer -> TimerC.Timer[unique("Timer")];
}

