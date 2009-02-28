/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: ParamOpI.nc,v 1.1.4.1 2007/04/25 23:26:57 njain Exp $
 */
interface ParamOpI
{
    command uint16_t nodeid();
    command uint8_t groupid();
    command uint8_t rfpower();
    command uint8_t channel();    
}	
