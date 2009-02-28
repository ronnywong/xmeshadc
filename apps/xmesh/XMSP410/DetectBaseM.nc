/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2004 SenseTech Software
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: DetectBaseM.nc,v 1.1.4.1 2007/04/26 20:14:08 njain Exp $
 */
 
/******************************************************************************
 *	Mobile Pipeline Intrusion Detection System (MPIDS)
 *
 *	Authors:	Tim Reilly
 *****************************************************************************/
 
includes msg;
includes global;

/**
 * Intruder detection module implementation
 * 
 * @modified  8/18/04

 * @author Tim Reilly
 */

includes sensorboard;
module DetectBaseM
{
    provides {
	interface StdControl;
    }
    
    uses {
	interface Leds;
	interface Send;
	interface RouteControl;
	interface CC1000Control as RadioControl;
        interface Timer as SampleTimer;
    }
}

implementation
{
#include "SODebug.h"
    
    TOS_Msg    msg_buf_radio;
    TOS_MsgPtr msg_radio;
    bool       sending_packet;
    bool       bLedsOn;
    uint16_t    OneShotTime;
    /**
     * Initialize components.
     *
     * @return SUCCESS
     */
    command result_t StdControl.init() {
	
	atomic msg_radio = &msg_buf_radio;
	sending_packet = FALSE;
	
	return SUCCESS;
    }
    
    /**
     * Start components.
     *
     * @return SUCCESS
     */
    command result_t StdControl.start() {
	
//		call RadioControl.SetRFPower(RADIO_POWER);
	
	if (TOS_LOCAL_ADDRESS == BASE_STATION){
	    OneShotTime = 100;
	    bLedsOn = FALSE; 
	    call SampleTimer.start(TIMER_ONE_SHOT,OneShotTime);
	}
	return SUCCESS;
    }
    
    /**
     * Stop components.
     *
     * @return SUCCESS
     */
    command result_t StdControl.stop() {
	return SUCCESS;
    }
    
    
    task void TimerTask() {
	call SampleTimer.start(TIMER_ONE_SHOT,OneShotTime);
    }
    
    event result_t SampleTimer.fired() {
	if (bLedsOn){
	    call Leds.redOff();
	    call Leds.greenOff();
	    call Leds.yellowOff(); 
	    bLedsOn = FALSE;
	    OneShotTime = 2000;
	}
	else {
	    call Leds.redOn();
	    call Leds.greenOn();
	    call Leds.yellowOn();
	    bLedsOn = TRUE; 
	    OneShotTime = 20;
	}
	post TimerTask();
    }
    
    event result_t Send.sendDone(TOS_MsgPtr msg, result_t success) {
	return success;
    }   
}
