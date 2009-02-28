/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: MaglibC.nc,v 1.3.4.1 2007/04/26 20:14:33 njain Exp $
 */

includes sensorboard;
configuration MaglibC
{
  provides interface StdControl;
  provides interface Maglib;
}
implementation
{
  components MaglibM, TimerC, MagC /*, CC1000RadioM*/;

  StdControl = MaglibM;
  MaglibM.Timer -> TimerC.Timer[unique("Timer")];

  Maglib = MaglibM;
  MaglibM.Mag -> MagC;
  MaglibM.MagX -> MagC.MagX; 
  MaglibM.MagY -> MagC.MagY; 
//  MaglibM.RadioPower->CC1000RadioM;
 
}
