/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: sensorboard.h,v 1.1.2.2 2007/04/27 05:08:09 njain Exp $
 */

/*
 *
 * Authors:		PIPENG
 * Date last modified:  8/6/05
 *
 */

/**
 * @author pipeng
 */


enum {
  TOSH_ACTUAL_PHOTO_PORT = 1,
  TOSH_ACTUAL_TEMP_PORT = 1, 
};

enum {
  TOS_ADC_PHOTO_PORT = 1,
  TOS_ADC_TEMP_PORT = 2,
};



TOSH_ALIAS_PIN(PHOTO_CTL, INT1);             
TOSH_ALIAS_PIN(TEMP_CTL, PW0);              







