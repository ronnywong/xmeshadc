/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: Mag.nc,v 1.1.4.1 2007/04/27 05:26:01 njain Exp $
 */
 
/*
 * Authors:		Mike Grimmer
 * Date last modified:  2-20-04
 * 
 */

interface Mag
{

  command result_t On();
  command result_t Off();
  command result_t SetReset();

  command result_t DCAdjustX(uint8_t val);
  command result_t DCAdjustY(uint8_t val);

  event result_t DCAdjustXdone(result_t ok);
  event result_t DCAdjustYdone(result_t ok);

}
