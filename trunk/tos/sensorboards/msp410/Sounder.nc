/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: Sounder.nc,v 1.1.4.1 2007/04/27 05:29:47 njain Exp $
 */

/*
 * Authors:		Mike Grimmer
 * Date last modified:  2-20-04
 * 
 */

interface Sounder
{
  command result_t twoTone(uint16_t first, uint16_t second, uint16_t interval);
  command result_t setInterval(uint16_t val);
  command result_t Beep(uint16_t interval);
  command result_t Off();
}
