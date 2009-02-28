/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: MicC.nc,v 1.1.4.1 2007/04/27 05:27:00 njain Exp $
 */

/*
 *
 * Authors: Mike Grimmer
 * Date last modified:  2-19-04
 *
 */
includes sensorboard;
configuration MicC
{
  provides interface ADC as MicADC;
  provides interface StdControl;
  provides interface Mic;
}
implementation
{
  components MicM, ADCC, I2CPotC;

  StdControl = MicM;
  MicADC = ADCC.ADC[TOS_ADC_MIC_PORT];
  Mic = MicM;
  MicM.ADCControl -> ADCC;
  MicM.PotControl -> I2CPotC;
  MicM.I2CPot -> I2CPotC;
}
