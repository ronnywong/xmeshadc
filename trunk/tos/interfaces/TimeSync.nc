// $Id: TimeSync.nc,v 1.1.4.1 2007/04/25 23:31:57 njain Exp $

/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: TimeSync.nc,v 1.1.4.1 2007/04/25 23:31:57 njain Exp $
 */



/*
 *
 * Authors:		Su Ping <sping@intel-research.net>
 * Date last modified:  9/19/02
 *
 */

/**
 * @author Su Ping <sping@intel-research.net>
 */


interface TimeSync
{

    /** 
     * This command broadcast a time sync message to the network
     */
    command result_t sendSync();

    /**
     *  set time sync interval: Every n seconds the master will do 
     *  a time sync update
     **/ 
    command result_t setInterval( uint32_t n );

    /**
     * set time sync state. Multihop routing module can use this command to 
     * inform time sync that it has children and responsible to sync with them
     *  See TimeSyncMsg.h for defined states
     **/

    command result_t setState(uint8_t state );

    // command skewEstimate();
    // command update()
    // No benifit to expose those command to external user.
    // keep them as module static functions.
}
