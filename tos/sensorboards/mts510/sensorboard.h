/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: sensorboard.h,v 1.1.4.1 2007/04/27 05:55:59 njain Exp $
 */

/**
 * @author Mike Grimmer
 */

#define MAKE_PW1_OUTPUT() sbi(DDRC,1)
#define SET_PW1() cbi(PORTC,1)
#define CLR_PW1() sbi(PORTC,1)

#define MAKE_PWM1B_OUTPUT() sbi(DDRB,6)
#define SET_PWM1B() cbi(PORTB,6)
#define CLR_PWM1B() sbi(PORTB,6)

enum {
  TOSH_ACTUAL_PHOTO_PORT = 7,
  TOSH_ACTUAL_MIC_PORT = 2, 
  TOSH_ACTUAL_ACCEL_X_PORT = 3, 
  TOSH_ACTUAL_ACCEL_Y_PORT = 4, 
};

enum {
  TOS_ADC_PHOTO_PORT = 7,
  TOS_ADC_MIC_PORT = 2,
  TOS_ADC_ACCEL_X_PORT = 3,
  TOS_ADC_ACCEL_Y_PORT = 4,
};

enum {
  TOS_MAG_POT_ADDR = 0,
  TOS_MIC_POT_ADDR = 1
};

TOSH_ALIAS_PIN(PHOTO_CTL, PW0);
TOSH_ALIAS_PIN(ACCEL_CTL, PW0);
TOSH_ALIAS_OUTPUT_ONLY_PIN(MIC_CTL, PW1);


