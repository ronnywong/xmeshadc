/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: ADCC.nc,v 1.1.4.1 2007/04/27 05:58:55 njain Exp $
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


configuration ADCC
{
  provides {
    interface ADC[uint8_t port];
    interface ADCControl;
  }
}
implementation
{
  components ADCM, HPLADCC;

  ADC = ADCM;
  ADCControl = ADCM;
  ADCM.HPLADC -> HPLADCC;
}
