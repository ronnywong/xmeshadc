/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2004, Technische Universitaet Berlin
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: InternalTempC.nc,v 1.1.4.1 2007/04/26 22:07:06 njain Exp $
 */
 
/* - Revision -------------------------------------------------------------
 * $Revision: 1.1.4.1 $
 * $Date: 2007/04/26 22:07:06 $
 * @author Jan Hauer <hauer@tkn.tu-berlin.de>
 * ========================================================================
 */

includes InternalTemp;
configuration InternalTempC
{
  provides interface ADC as InternalTempADC;
  provides interface ADCSingle;
  provides interface ADCMultiple;
  provides interface StdControl;
}
implementation
{
  components InternalTempM, ADCC, MSP430ADC12C;
  
  StdControl = InternalTempM;
  StdControl = ADCC;
  StdControl = MSP430ADC12C;
  ADCSingle = InternalTempM;
  ADCMultiple = InternalTempM;
  InternalTempADC = ADCC.ADC[TOS_ADC_INTERNAL_TEMP_PORT];
  
  InternalTempM.ADCControl -> ADCC;
  InternalTempM.MSP430ADC12Single -> MSP430ADC12C.MSP430ADC12Single[unique("MSP430ADC12")];
  InternalTempM.MSP430ADC12Multiple -> MSP430ADC12C.MSP430ADC12Multiple[unique("MSP430ADC12")];
}
