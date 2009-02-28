/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * Copyright (c) 2004 by Sensicast, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: ConfigInt16.nc,v 1.1.4.1 2007/04/25 23:41:16 njain Exp $
 */


//
// @Author: Michael Newman
//
//

#define ConfigInt16Edit 1
//
// Modification History:
//  13Jan04 MJNewman 1: Created.


interface ConfigInt16
{
  command uint16_t get();
  command result_t set(uint16_t value);
}
