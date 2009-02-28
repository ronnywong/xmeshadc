/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: ADCC.nc,v 1.1.2.2 2007/04/26 00:03:47 njain Exp $
 */

configuration ADCC
{
  provides {
    interface ADC[uint8_t port];
    interface ADC as CalADC[uint8_t port];
    interface ADCControl;
  }
}
implementation
{
  components Main, ADCREFM as ADCM, HPLADCM, TimerC;

  Main.StdControl -> TimerC;

  ADC = ADCM.ADC;
  CalADC = ADCM.CalADC;
  ADCControl = ADCM;

  ADCM.Timer -> TimerC.Timer[unique("Timer")];
  ADCM.HPLADC -> HPLADCM;

}


