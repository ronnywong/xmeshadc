/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2004, Technische Universitaet Berlin
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: InternalTemp.h,v 1.1.4.1 2007/04/26 22:06:57 njain Exp $
 */

/*
 * - Revision -------------------------------------------------------------
 * $Revision: 1.1.4.1 $
 * $Date: 2007/04/26 22:06:57 $
 * @author Jan Hauer <hauer@tkn.tu-berlin.de>
 * ========================================================================
 */


#ifndef INTERNAL_TEMP_H 
#define INTERNAL_TEMP_H

#include "MSP430ADC12.h"

enum
{
  TOS_ADC_INTERNAL_TEMP_PORT = unique("ADCPort"),
  TOSH_ACTUAL_ADC_INTERNAL_TEMPERATURE_PORT = ASSOCIATE_ADC_CHANNEL( 
           INTERNAL_TEMPERATURE, 
           REFERENCE_VREFplus_AVss, 
           REFVOLT_LEVEL_1_5), 
};

#define MSP430ADC12_INTERNAL_TEMPERATURE ADC12_SETTINGS( \
           INTERNAL_TEMPERATURE, REFERENCE_VREFplus_AVss, SAMPLE_HOLD_4_CYCLES, \
           SHT_SOURCE_ACLK, SHT_CLOCK_DIV_1, SAMPCON_SOURCE_SMCLK, \
           SAMPCON_CLOCK_DIV_1, REFVOLT_LEVEL_1_5) 


#endif

