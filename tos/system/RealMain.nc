/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: RealMain.nc,v 1.2.4.1 2007/04/27 06:02:58 njain Exp $
 */


/*
 *
 * Authors:		Jason Hill, David Gay, Philip Levis
 * Date last modified:  $Id: RealMain.nc,v 1.2.4.1 2007/04/27 06:02:58 njain Exp $
 *
 */

/**
 * @author Jason Hill
 * @author David Gay
 * @author Philip Levis
 */


module RealMain {
  uses {
    command result_t hardwareInit();
    interface StdControl;
    interface Pot;
  }
}
implementation
{
  int main() __attribute__ ((C, spontaneous)) {

// reference to the parameters defined in the make system and force to export them into Symbol table
    uint8_t local_symbol_ref;    

    local_symbol_ref = TOS_PLATFORM;
		local_symbol_ref = TOS_BASE_STATION;
		local_symbol_ref = TOS_DATA_LENGTH;     
#ifdef ROUTE_PROTOCOL    
    local_symbol_ref = TOS_ROUTE_PROTOCOL;
#endif
#ifdef CPU_CLK
    local_symbol_ref = TOS_CPU_CLK;  
#endif    
#ifdef CPU_PWRMGMT
    local_symbol_ref = TOS_CPU_PWRMGMT;
#endif
  	
    call hardwareInit();
    call Pot.init(10);
    TOSH_sched_init();
    
    call StdControl.init();
    call StdControl.start();
    __nesc_enable_interrupt();

    while(1) {
       TOSH_run_task();
    }
  }
}
