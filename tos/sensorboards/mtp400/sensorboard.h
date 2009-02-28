/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: sensorboard.h,v 1.1.4.1 2007/04/26 21:32:46 njain Exp $
 */

/**
 *
 * driver for ADS8344 on mtp400ca
 *
 */




  enum { CH1 = 0, // CH1
         CH2,    // CH2
         CH3,    // CH3
        };
        

     
/* 
TOSH_ALIAS_OUTPUT_ONLY_PIN(ACCEL_LOW_CLK, PW0);
TOSH_ALIAS_OUTPUT_ONLY_PIN(ACCEL_LOW_CS, PW1);
TOSH_ALIAS_OUTPUT_ONLY_PIN(ACCEL_HIGH_CLK, PW2);
TOSH_ALIAS_OUTPUT_ONLY_PIN(ACCEL_HIGH_CS, PW3);

TOSH_ALIAS_OUTPUT_ONLY_PIN(TEMP_CS, PW4);
TOSH_ALIAS_OUTPUT_ONLY_PIN(TEMP_SCK, PW6);


TOSH_ALIAS_PIN(ACCEL_LOW_VERTICAL, INT0);
TOSH_ALIAS_PIN(ACCEL_LOW_HORIZONTAL, INT1);
TOSH_ALIAS_PIN(ACCEL_HIGH_HORIZONTAL, INT2);
TOSH_ALIAS_PIN(ACCEL_HIGH_VERTICAL, INT3);

TOSH_ALIAS_PIN(TEMP_SIO, PW5);

*/

