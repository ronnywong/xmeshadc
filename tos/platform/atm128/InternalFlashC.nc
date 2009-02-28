/*
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: InternalFlashC.nc,v 1.1.4.1 2007/04/26 00:11:20 njain Exp $
 */

/**
 * InternalFlashC.nc - Internal flash implementation for the avr
 * platform.
 *
 * Valid address range is 0x0 - 0xFFF.
 *
 * @author Jonathan Hui <jwhui@cs.berkeley.edu>
 */

includes InternalFlash;

module InternalFlashC {
  provides interface InternalFlash;
}

implementation {

  enum {
    IFLASH_BOUND_LOW  = 0x000,
    IFLASH_BOUND_HIGH = 0xfff,
  };

  command result_t InternalFlash.write(void* addr, void* buf, uint16_t size) {

    uint8_t *addrPtr = (uint8_t*)addr;
    uint8_t *bufPtr = (uint8_t*)buf;
    uint16_t i;

    if ((uint16_t)addr < IFLASH_BOUND_LOW || IFLASH_BOUND_HIGH + 2 <= (uint16_t)addr + size)
      return FAIL;

    for ( i = 0; i < size; i++ ) {
      eeprom_write_byte(addrPtr, *bufPtr);
      addrPtr++;
      bufPtr++;
    }

    while(!eeprom_is_ready());

    return SUCCESS;

  }

  command result_t InternalFlash.read(void* addr, void* buf, uint16_t size) {

    uint8_t *addrPtr = (uint8_t*)addr;
    uint8_t *bufPtr = (uint8_t*)buf;
    uint16_t i;

    if ((uint16_t)addr < IFLASH_BOUND_LOW || IFLASH_BOUND_HIGH + 2 <= (uint16_t)addr + size)
      return FAIL;

    for ( i = 0; i < size; i++ ) {
      *bufPtr = eeprom_read_byte(addrPtr);
      addrPtr++;
      bufPtr++;
    }

    return SUCCESS;

  }

}
