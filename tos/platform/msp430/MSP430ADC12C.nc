/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2004, Technische Universitaet Berlin
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: MSP430ADC12C.nc,v 1.1.4.1 2007/04/26 22:08:06 njain Exp $
 */
 
/*
 * - Revision -------------------------------------------------------------
 * $Revision: 1.1.4.1 $
 * $Date: 2007/04/26 22:08:06 $
 * @author: Jan Hauer <hauer@tkn.tu-berlin.de>
 * ========================================================================
 */

configuration MSP430ADC12C
{
  provides interface StdControl;
  provides interface MSP430ADC12Single[uint8_t id];
  provides interface MSP430ADC12Multiple[uint8_t id];
}

implementation
{
  components MSP430ADC12M, HPLADC12M, MSP430TimerC, RefVoltC;

  StdControl = MSP430ADC12M;
  MSP430ADC12Single = MSP430ADC12M.ADCSingle;
  MSP430ADC12Multiple = MSP430ADC12M.ADCMultiple;
    
  MSP430ADC12M.HPLADC12 -> HPLADC12M;
  MSP430ADC12M.RefVolt -> RefVoltC;

  MSP430ADC12M.TimerA -> MSP430TimerC.TimerA;
  MSP430ADC12M.ControlA0 -> MSP430TimerC.ControlA0;
  MSP430ADC12M.ControlA1 -> MSP430TimerC.ControlA1;
  MSP430ADC12M.CompareA0 -> MSP430TimerC.CompareA0;
  MSP430ADC12M.CompareA1 -> MSP430TimerC.CompareA1;
}

