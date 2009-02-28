/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * Copyright (c) 2004 by Sensicast, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: ConfigInt8.nc,v 1.1.4.1 2007/04/25 23:41:25 njain Exp $
 */


//
// @Author: Michael Newman
//
//

#define ConfigInt8Edit 1
//
// Modification History:
//  12Mar04 MJNewman 1: Created.


interface ConfigInt8
{
  command uint8_t get();
  command result_t set(uint8_t value);
}
