/*
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: LocalTime.nc,v 1.1.4.1 2007/04/26 22:07:49 njain Exp $
 */


// @author Cory Sharp <cssharp@eecs.berkeley.edu>

interface LocalTime
{
  async command uint32_t read();
}

