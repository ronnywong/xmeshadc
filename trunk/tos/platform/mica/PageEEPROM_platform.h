/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: PageEEPROM_platform.h,v 1.1.4.1 2007/04/26 00:26:10 njain Exp $
 */

#ifndef __TOS_PAGEEEPROM_PLATFORM_H__
#define __TOS_PAGEEEPROM_PLATFORM_H__

// EEPROM characteristics
enum {
  TOS_EEPROM_MAX_PAGES = 2048,
  TOS_EEPROM_PAGE_SIZE = 264,
  TOS_EEPROM_PAGE_SIZE_LOG2 = 8 // For those who want to ignore the last 8 bytes
};

typedef uint16_t eeprompage_t;
typedef uint16_t eeprompageoffset_t; /* 0 to TOS_EEPROM_PAGE_SIZE - 1 */

#endif
