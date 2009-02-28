/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2004, Technische Universitaet Berlin
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: InternalVoltageC.nc,v 1.1.4.1 2007/04/26 22:07:32 njain Exp $
 */
 
/* - Revision -------------------------------------------------------------
 * $Revision: 1.1.4.1 $
 * $Date: 2007/04/26 22:07:32 $
 * @author Jan Hauer <hauer@tkn.tu-berlin.de>
 * ========================================================================
 */
includes InternalVoltage;
configuration InternalVoltageC
{
  provides interface ADC as InternalVoltageADC;
  provides interface ADCSingle;
  provides interface ADCMultiple;
  provides interface StdControl;
}
implementation
{
  components InternalVoltageM, ADCC, MSP430ADC12C;
  
  StdControl = InternalVoltageM;
  StdControl = ADCC;
  StdControl = MSP430ADC12C;
  ADCSingle = InternalVoltageM;
  ADCMultiple = InternalVoltageM;
  InternalVoltageADC = ADCC.ADC[TOS_ADC_INTERNAL_VOLTAGE_PORT];
  
  InternalVoltageM.ADCControl -> ADCC;
  InternalVoltageM.MSP430ADC12Single -> MSP430ADC12C.MSP430ADC12Single[unique("MSP430ADC12")];
  InternalVoltageM.MSP430ADC12Multiple -> MSP430ADC12C.MSP430ADC12Multiple[unique("MSP430ADC12")];
}

