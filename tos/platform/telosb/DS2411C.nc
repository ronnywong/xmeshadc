/*
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: DS2411C.nc,v 1.1.4.1 2007/04/26 22:23:50 njain Exp $
 */


//@author Cory Sharp <cssharp@eecs.berkeley.edu>

configuration DS2411C
{
  provides interface DS2411;
}
implementation
{
  components DS2411M, DS2411PinC;
  DS2411 = DS2411M;
  DS2411M.DS2411Pin -> DS2411PinC.DS2411Pin;
}

