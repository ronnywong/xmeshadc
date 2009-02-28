/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: ByteEEPROM_platform.h,v 1.1.4.1 2007/04/26 00:23:04 njain Exp $
 */

enum {
  TOS_BYTEEEPROM_PAGESIZE = 1 << TOS_EEPROM_PAGE_SIZE_LOG2,
  TOS_BYTEEEPROM_LASTBYTE = (long)TOS_EEPROM_MAX_PAGES << TOS_EEPROM_PAGE_SIZE_LOG2
};
