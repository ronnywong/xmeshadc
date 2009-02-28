/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: MagC.nc,v 1.1.4.1 2007/04/27 05:26:10 njain Exp $
 */
 
 /*
 *
 * Authors: Mike Grimmer
 * Date last modified:  2-19-04
 *
 */
includes sensorboard;
configuration MagC
{
  provides interface ADC as MagX;
  provides interface ADC as MagY;

  provides interface StdControl;
  provides interface Mag;
}
implementation
{
  components MagM, ADCC, I2CPotC;

  StdControl = MagM;
  MagX = ADCC.ADC[TOS_ADC_MAG_X_PORT];
  MagY = ADCC.ADC[TOS_ADC_MAG_Y_PORT];
  Mag = MagM;
  MagM.ADCControl -> ADCC;
  MagM.PotControl -> I2CPotC;
  MagM.I2CPot -> I2CPotC;
}
