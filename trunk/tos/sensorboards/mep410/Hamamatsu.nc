/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: Hamamatsu.nc,v 1.1.4.1 2007/04/27 05:18:25 njain Exp $
 */

/*
 *
 * Authors:		Joe Polastre
 *
 */

includes sensorboard;

configuration Hamamatsu
{
  provides {
    interface ADC[uint8_t id];
    interface SplitControl;
  }
}
implementation
{
  components HamamatsuM, ADCC;

  SplitControl = HamamatsuM;
  ADC = HamamatsuM;

  HamamatsuM.ADCControl -> ADCC;
  HamamatsuM.Hamamatsu1 -> ADCC.ADC[HAMAMATSU1_ADC_PORT];
  HamamatsuM.Hamamatsu2 -> ADCC.ADC[HAMAMATSU2_ADC_PORT];
  HamamatsuM.Hamamatsu3 -> ADCC.ADC[HAMAMATSU3_ADC_PORT];
  HamamatsuM.Hamamatsu4 -> ADCC.ADC[HAMAMATSU4_ADC_PORT];
}
