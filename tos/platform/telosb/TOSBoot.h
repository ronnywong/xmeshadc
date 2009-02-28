/*
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: TOSBoot.h,v 1.1.4.1 2007/04/26 22:25:43 njain Exp $
 */

/*
 * Bootloader constants for nesc-based bootloader.
 * @author  Jonathan Hui <jwhui@cs.berkeley.edu>
 */

#ifndef __MSP_BOOTLOADER_H__
#define __MSP_BOOTLOADER_H__

// size of each internal program flash page
#define TOSBOOT_INT_PAGE_SIZE  ((uint32_t)512)

// address of the golden image in external flash
#define TOSBOOT_GOLDEN_IMG_ADDR     ((uint32_t)0xf0200)

// number of resets to force golden image
#define TOSBOOT_GESTURE_MAX_COUNT   3

enum {
  TOSBOOT_GOLDEN_IMG_LOADED = 1,
  TOSBOOT_EXPLICIT_REBOOT = 2,
  TOSBOOT_PROGRAM_FAIL_FLAG = 4,
};

// bootloader state stored in the information section
#define TOSBOOT_LOAD_IMG_ADDR         0x70 // 1 byte
#define TOSBOOT_GESTURE_COUNT_ADDR    0x71 // 1 byte
#define TOSBOOT_NEW_IMG_START_ADDR    0x72 // 4 bytes
#define TOSBOOT_CUR_IMG_START_ADDR    0x76 // 4 bytes
#define TOSBOOT_PROGRAM_BUF_ADDR      0x7a // 4 bytes

#define TOSBOOT_FLAGS_ADDR            0x7e // 1 byte

#endif
