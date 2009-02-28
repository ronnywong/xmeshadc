/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: I2CSwitchCmds.nc,v 1.1.2.2 2007/04/27 05:49:25 njain Exp $
 */

interface I2CSwitchCmds
{
       command result_t PowerSwitch(uint8_t PowerState);  
       /* 0 =>  power off; 1 =>  power on */

//notify that I2C power switch has been set.
//PowerState = 0 => power is off; PowerState = 1 => power is on
       event result_t SwitchesSet(uint8_t PowerState);                //notify that I2C switches are set 
}

