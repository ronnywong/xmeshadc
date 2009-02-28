/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: WatchDogM.nc,v 1.1.4.1 2007/04/26 00:11:52 njain Exp $
 */

/*
 * Authors:		Su Ping  <sping@intel-research.net>
 *
 */



/**
 * The Watch dog interface. 
 * When enabled, the watch dog will reset a mote at a specified time
 * @author Su Ping <sping@intel-research.net>
 **/
includes TosTime;
module WatchDogM {
    provides interface WatchDog;
    uses {
        interface AbsoluteTimer as AbsoluteTimer2;
        interface Random;
        interface TimeUtil;
    }
}

implementation {

    command result_t WatchDog.set(tos_time_t t ) {
        uint16_t delta = call Random.rand();
        delta = (delta>>8)|(delta & 0xFF); 
        // add a random delay ranging from 0 to 512 seconds
        t = call TimeUtil.addUint32(t, delta<<10);
        return call AbsoluteTimer2.set(t);
        
    }

    command result_t WatchDog.cancel() {
        
        return  call AbsoluteTimer2.cancel();
    }
    
    /** AbsoluteTimer event. Enable watch dog timer and 
     *  set its timeout period 34 ms
     **/  
    event result_t AbsoluteTimer2.fired() {
        TOSH_CLR_YELLOW_LED_PIN();
        wdt_enable(1);
        return SUCCESS ;
    }
}

