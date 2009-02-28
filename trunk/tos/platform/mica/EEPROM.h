/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: EEPROM.h,v 1.1.4.1 2007/04/26 00:23:44 njain Exp $
 */

/*
 *
 * Authors:		David Gay, Philip Levis
 * Date last modified:  6/25/02
 *
 */

/**
 * @author David Gay
 * @author Philip Levis
 */


#ifndef TOS_EEPROM_H
#define TOS_EEPROM_H

// EEPROM characteristics
enum {
  TOS_EEPROM_LOG2_LINE_SIZE = 4,
  TOS_EEPROM_LINE_SIZE = 1 << TOS_EEPROM_LOG2_LINE_SIZE,
  TOS_EEPROM_MAX_LINES = 0x80000 >> TOS_EEPROM_LOG2_LINE_SIZE,
  TOS_EEPROM_BYTE_ADDR_BYTE_MASK = 0xf,
  TOS_EEPROM_MAX_BYTES = 0x80000
};

// EEPROM allocation
enum {
  EEPROM_LOGGER_APPEND_START = 16,
  EEPROM_LOGGER_APPEND_END = TOS_EEPROM_MAX_LINES
};

// EEPROM component IDs
enum {
  BYTE_EEPROM_EEPROM_ID
};

#endif
