/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: sensorboard.h,v 1.1.4.1 2007/04/27 05:34:21 njain Exp $
 */

/*
 *
 * Authors:		Alec Woo, David Gay, Philip Levis
 * Date last modified:  6/25/02
 *
 */

/* The basic sensor board */

/**
 * @author Alec Woo
 * @author David Gay
 * @author Philip Levis
 */


TOSH_ALIAS_OUTPUT_ONLY_PIN(PHOTO_CTL, PW1); 
TOSH_ALIAS_OUTPUT_ONLY_PIN(TEMP_CTL, PW2);
#if defined (__AVR_ATmega163__)
enum {
  TOSH_ACTUAL_PHOTO_PORT = 1,
  TOSH_ACTUAL_TEMP_PORT = 2,
};
#elif defined (__AVR_AT90S8535__)
enum {
  TOSH_ACTUAL_PHOTO_PORT = 1,
  TOSH_ACTUAL_TEMP_PORT = 2
};
/* no way to get voltage in RENE 1 */
#else
enum {
  TOSH_ACTUAL_PHOTO_PORT = 6,
  TOSH_ACTUAL_TEMP_PORT = 5,
};
#endif

/* These are the end-user values */
enum {
  TOS_ADC_PHOTO_PORT = 1,
  TOS_ADC_TEMP_PORT = 2,
};
