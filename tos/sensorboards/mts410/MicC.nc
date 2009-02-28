/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: MicC.nc,v 1.1.4.1 2007/04/27 05:45:27 njain Exp $
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
  provides interface StdControl;
  provides interface Mic;
}
implementation
{
  components MicM, ADCC, I2CPotC,TimerC;

  StdControl = MicM;
  Mic = MicM;
  MicM.ADCControl -> ADCC;
  MicM.ADC -> ADCC.ADC[TOS_ADC_MIC_PORT];
  MicM.PotControl -> I2CPotC;
  MicM.I2CPot -> I2CPotC;
  MicM.SetTimer->TimerC.Timer[unique("Timer")];
}
