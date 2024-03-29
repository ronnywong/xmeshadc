/*
 * Copyright (c) 2000-2005 The Regents of the University of California
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: RefVolt.h,v 1.1.4.1 2007/04/26 22:13:22 njain Exp $
 */

#ifndef MSP430REFVOLT_H
#define MSP430REFVOLT_H

// time for generator to become stable
#define STABILIZE_INTERVAL 17

// delay before switching off reference voltage generator after it has been released (in ms)
// this avoids having to wait the 17ms in case the RefVolt is needed again right after it
// has been released.
#define SWITCHOFF_INTERVAL 100

// time to wait until we try again to reset REFON (in ms) when ADC is busy and we cant
// switch it off immediately
#define SWITCHOFF_RETRY 5

typedef enum
{
  REFERENCE_1_5V,     // vref  1.5 V
  REFERENCE_2_5V,     // vref  2.5 V
  REFERENCE_UNSTABLE  // vref unstable or generator off
} RefVolt_t;

#endif
