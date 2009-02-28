/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: Temp.nc,v 1.1.4.1 2007/04/27 05:34:04 njain Exp $
 */
 
/*
 *
 * Authors:		Jason Hill, David Gay, Philip Levis
 * Date last modified:  6/25/02
 *
 */

/**
 * @author Jason Hill
 * @author David Gay
 * @author Philip Levis
 */


includes sensorboard;
configuration Temp
{
  provides interface ADC as TempADC;
  provides interface StdControl;
}
implementation
{
  components TempM, ADCC;

  StdControl = TempM;
  TempADC = ADCC.ADC[TOS_ADC_TEMP_PORT];
  TempM.ADCControl -> ADCC;
}
