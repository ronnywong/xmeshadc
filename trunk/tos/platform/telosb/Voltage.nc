/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: Voltage.nc,v 1.1.4.1 2007/04/26 22:25:53 njain Exp $
 */

includes InternalVoltage;
configuration Voltage
{
  provides interface ADC;
  provides interface StdControl;
}
implementation
{
  components VoltageM, ADCC;

  StdControl = VoltageM;
  ADC = ADCC.ADC[TOS_ADC_INTERNAL_VOLTAGE_PORT];
  VoltageM.ADCControl -> ADCC;
}
