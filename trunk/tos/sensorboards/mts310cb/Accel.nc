/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: Accel.nc,v 1.1.2.2 2007/04/27 05:37:03 njain Exp $
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
