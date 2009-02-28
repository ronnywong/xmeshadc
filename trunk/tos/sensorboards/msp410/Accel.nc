/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: Accel.nc,v 1.1.4.1 2007/04/27 05:24:37 njain Exp $
 */
 
 includes sensorboard;
configuration Accel 
{
  provides interface ADC as AccelX;
  provides interface ADC as AccelY;
  provides interface StdControl;
}
implementation
{
  components AccelM, ADCC;

  StdControl = AccelM;
  AccelX = ADCC.ADC[TOS_ADC_ACCEL_X_PORT];
  AccelY = ADCC.ADC[TOS_ADC_ACCEL_Y_PORT];
  AccelM.ADCControl -> ADCC;
}
