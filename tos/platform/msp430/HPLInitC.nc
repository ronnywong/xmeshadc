/*
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: HPLInitC.nc,v 1.1.4.1 2007/04/26 22:05:18 njain Exp $
 */
 
//@author Cory Sharp <cssharp@eecs.berkeley.edu>

configuration HPLInitC
{
  provides command result_t init();
}
implementation
{
  components HPLInitM
           , MSP430ClockC
	   ;

  init = HPLInitM.init;

  HPLInitM.MSP430ClockControl -> MSP430ClockC.StdControl;
}

