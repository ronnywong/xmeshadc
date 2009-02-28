/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: RfmToLeds.nc,v 1.1.4.1 2007/04/26 19:36:24 njain Exp $
 */

/** 
This application will receive and display the packet sent 
from the CntToRfmAndLeds Application.
**/

configuration RfmToLeds {
}
implementation {
  components Main, RfmToInt, IntToLeds;

  Main.StdControl -> IntToLeds.StdControl;
  Main.StdControl -> RfmToInt.StdControl;
  RfmToInt.IntOutput -> IntToLeds.IntOutput;
}
