/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: Sounder.nc,v 1.1.4.1 2007/04/27 05:46:50 njain Exp $
 */
 
/*
 * Authors:		Mike Grimmer
 * Date last modified:  2-20-04
 * 
 */

interface Sounder
{
  command result_t Beep(uint32_t interval);
  command result_t Off();
}
