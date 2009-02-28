/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: MicC.nc,v 1.1.2.2 2007/04/27 05:37:53 njain Exp $
 */

/*
 *
 * Authors:		Alec Woo, David Gay, Philip Levis
 * Date last modified:  6/25/02
 *
 */

/**
 * @author Alec Woo
 * @author David Gay
 * @author Philip Levis
 */


configuration MicC
{
  provides interface ADC as MicADC;
  provides interface StdControl;
  provides interface Mic;
  provides interface MicInterrupt;
}
implementation
{
  components MicM, ADCC, I2CPotC;

  StdControl = MicM;
  MicInterrupt = MicM;
  MicADC = ADCC.ADC[TOS_ADC_MIC_PORT];
  Mic = MicM;
  MicM.ADCControl -> ADCC;
  MicM.PotControl -> I2CPotC;
  MicM.I2CPot -> I2CPotC;
}
