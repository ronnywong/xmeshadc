/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: GpsCmd.nc,v 1.1.4.1 2007/04/27 05:40:06 njain Exp $
 */

interface GpsCmd
{
       command result_t PowerSwitch(uint8_t PowerState);  
       /* 0 => gps power off; 1 => gps power on */

       event result_t PowerSet(uint8_t PowerState);                //notify power is on/off 

       command result_t TxRxSwitch(uint8_t State);  
       /* 0 => gps rx/tx disabled; 1 => gps rx/tx enabled */

       event result_t TxRxSet(uint8_t rtstate);                //notify tx/rx is on/off 


}

