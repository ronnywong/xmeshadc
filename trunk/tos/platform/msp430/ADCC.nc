/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2004, Technische Universitaet Berlin
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: ADCC.nc,v 1.1.4.1 2007/04/26 22:04:02 njain Exp $
 */
 
/*
 * - Description ----------------------------------------------------------
 * Obsolete, use ADCHILC/M instead.
 * Read ADC_README about how to use the provided interfaces, e.g.
 * ADCControl.bind has a slightly different meaning than before.
 * - Revision -------------------------------------------------------------
 * $Revision: 1.1.4.1 $
 * $Date: 2007/04/26 22:04:02 $
 * @author Vlado Handziski <handzisk@tkn.tu-berlin.de>
 * @author Jan Hauer <hauer@tkn.tu-berlin.de>
 * @author: Kevin Klues <klues@tkn.tu-berlin.de>
 * ========================================================================
 */
 
configuration ADCC
{
  provides {
    interface ADC[uint8_t port];
    interface ADCControl;
    interface StdControl;
  }
}
implementation
{
  components ADCM, MSP430ADC12C;
  
  ADC = ADCM.ADC;
  ADCControl = ADCM;
  StdControl = ADCM;
  StdControl = MSP430ADC12C;

  ADCM.MSP430ADC12Single -> MSP430ADC12C.MSP430ADC12Single[unique("MSP430ADC12")];
}
