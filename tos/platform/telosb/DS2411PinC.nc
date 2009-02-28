/*
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: DS2411PinC.nc,v 1.1.4.1 2007/04/26 22:24:18 njain Exp $
 */


//@author Cory Sharp <cssharp@eecs.berkeley.edu>

configuration DS2411PinC
{
  provides interface DS2411Pin;
}
implementation
{
  components DS2411PinM, MSP430GeneralIOC;

  DS2411Pin = DS2411PinM;
  DS2411PinM.MSP430Pin -> MSP430GeneralIOC.Port24;
}

