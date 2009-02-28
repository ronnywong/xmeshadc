/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: MainM.nc,v 1.1.4.1 2007/04/26 22:13:11 njain Exp $
 */

/*
 *
 * Authors:		Jason Hill, David Gay, Philip Levis
 * Date last modified:  $Id: MainM.nc,v 1.1.4.1 2007/04/26 22:13:11 njain Exp $
 *
 */

/**
 * @author Jason Hill
 * @author David Gay
 * @author Philip Levis
 */


module MainM
{
  uses command result_t hardwareInit();
  uses interface StdControl;
}
implementation
{
  int main() __attribute__ ((C, spontaneous))
  {
    call hardwareInit();
    TOSH_sched_init();
    
    call StdControl.init();
    call StdControl.start();
    __nesc_enable_interrupt();

    for(;;) { TOSH_run_task(); }
  }
}

