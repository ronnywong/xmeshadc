/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: RadioTiming.nc,v 1.1.4.1 2007/04/26 00:26:29 njain Exp $
 */
 
interface RadioTiming
{
  async command uint16_t getTiming();
  async command uint16_t currentTime();
}

    
