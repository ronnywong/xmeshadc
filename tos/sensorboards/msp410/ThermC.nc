/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: ThermC.nc,v 1.1.4.1 2007/04/27 05:30:21 njain Exp $
 */

/*
 *
 * Authors: Mike Grimmer
 * Date last modified:  2-19-04
 *
 */
includes sensorboard;
configuration ThermC
{
  provides interface ADC as ThermADC;
  provides interface StdControl;
  provides interface Therm;
}
implementation
{
  components ThermM, ADCC;

  StdControl = ThermM;
  ThermADC = ADCC.ADC[TOS_ADC_PHOTO_PORT];
  Therm = ThermM;
  ThermM.ADCControl -> ADCC;
}
