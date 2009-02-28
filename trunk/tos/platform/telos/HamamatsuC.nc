/*
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: HamamatsuC.nc,v 1.1.4.1 2007/04/26 22:20:29 njain Exp $
 */

/*
 *
 * Authors:		Joe Polastre
 *
 * $Id: HamamatsuC.nc,v 1.1.4.1 2007/04/26 22:20:29 njain Exp $
 */

includes Hamamatsu;

configuration HamamatsuC
{
  provides {
    interface ADC as PAR;
    interface ADC as TSR;
    interface StdControl;
  }
}
implementation
{
  components HamamatsuM, ADCC;

  StdControl = ADCC;
  StdControl = HamamatsuM;

  PAR = ADCC.ADC[TOS_ADC_PAR_PORT];
  TSR = ADCC.ADC[TOS_ADC_TSR_PORT];

  HamamatsuM.ADCControl -> ADCC;

}
