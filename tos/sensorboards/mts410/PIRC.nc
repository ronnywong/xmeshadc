/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: PIRC.nc,v 1.1.4.1 2007/04/27 05:45:52 njain Exp $
 */

/*
 *
 * Authors: Mike Grimmer
 * Date last modified:  2-19-04
 *
 */
includes sensorboard;
configuration PIRC
{
 
  provides interface StdControl;
  provides interface PIR;
}
implementation
{
  components PIRM, ADCC,I2CPotC,TimerC;

  StdControl = PIRM;
  PIR        = PIRM;
  PIRM.ADC -> ADCC.ADC[TOS_ADC_PIR_PORT];
  PIRM.ADCControl -> ADCC;
  PIRM.PotControl -> I2CPotC;
  PIRM.I2CPot -> I2CPotC;
  PIRM.SetTimer->TimerC.Timer[unique("Timer")];
}
