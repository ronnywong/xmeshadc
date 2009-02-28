/*
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: Hamamatsu.h,v 1.1.4.1 2007/04/26 22:20:19 njain Exp $
 */


//@author Cory Sharp <cssharp@eecs.berkeley.edu>

#ifndef _H_Hamamatsu_h
#define _H_Hamamatsu_h

#include "MSP430ADC12.h"

// PAR, Photosynthetically Active Radiation
enum
{
  TOS_ADC_PAR_PORT = unique("ADCPort"),

  TOSH_ACTUAL_ADC_PAR_PORT = ASSOCIATE_ADC_CHANNEL(
    INPUT_CHANNEL_A4, 
    REFERENCE_VREFplus_AVss, 
    REFVOLT_LEVEL_1_5
  )
};

// TSR, Total Solar Radiation
enum
{
  TOS_ADC_TSR_PORT = unique("ADCPort"),

  TOSH_ACTUAL_ADC_TSR_PORT = ASSOCIATE_ADC_CHANNEL(
    INPUT_CHANNEL_A5, 
    REFERENCE_VREFplus_AVss,
    REFVOLT_LEVEL_1_5
  )
};

#endif//_H_Hamamatsu_h

