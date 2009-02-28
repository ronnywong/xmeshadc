/*
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: MSP430ClockC.nc,v 1.1.4.1 2007/04/26 22:08:49 njain Exp $
 */

//@author Cory Sharp <cssharp@eecs.berkeley.edu>

configuration MSP430ClockC
{
  provides interface StdControl;
  provides interface MSP430ClockInit;
}
implementation
{
  components MSP430ClockM
           , MSP430TimerC
	   ;

  StdControl = MSP430ClockM;
  MSP430ClockInit = MSP430ClockM;
  
  // CompareB1 is used by RADIO_SFD
  MSP430ClockM.ACLKControl -> MSP430TimerC.ControlB2;
  MSP430ClockM.ACLKCompare -> MSP430TimerC.CompareB2;
}

