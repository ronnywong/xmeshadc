/*
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: MSP430Event.nc,v 1.1.4.1 2007/04/26 22:09:24 njain Exp $
 */

//@author Cory Sharp <cssharp@eecs.berkeley.edu>

interface MSP430Event
{
  async event void fired();
}

