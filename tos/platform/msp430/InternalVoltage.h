/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2004, Technische Universitaet Berlin
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: InternalVoltage.h,v 1.1.4.1 2007/04/26 22:07:23 njain Exp $
 */

/*
 * - Revision -------------------------------------------------------------
 * $Revision: 1.1.4.1 $
 * $Date: 2007/04/26 22:07:23 $
 * @author Jan Hauer <hauer@tkn.tu-berlin.de>
 * ========================================================================
 */


#ifndef INTERNAL_VOLTAGE_H 
#define INTERNAL_VOLTAGE_H

#include "MSP430ADC12.h"

enum
{
  TOS_ADC_INTERNAL_VOLTAGE_PORT = unique("ADCPort"),
  TOSH_ACTUAL_ADC_INTERNAL_VOLTAGE_PORT = ASSOCIATE_ADC_CHANNEL( 
           INTERNAL_VOLTAGE, 
           REFERENCE_VREFplus_AVss, 
           REFVOLT_LEVEL_1_5), 
}; 

#define MSP430ADC12_INTERNAL_VOLTAGE ADC12_SETTINGS( \
           INTERNAL_VOLTAGE, REFERENCE_VREFplus_AVss, SAMPLE_HOLD_4_CYCLES, \
           SHT_SOURCE_ACLK, SHT_CLOCK_DIV_1, SAMPCON_SOURCE_SMCLK, \
           SAMPCON_CLOCK_DIV_1, REFVOLT_LEVEL_1_5) 

#endif


