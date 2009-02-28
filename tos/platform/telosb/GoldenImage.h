/*
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: GoldenImage.h,v 1.1.4.1 2007/04/26 22:24:48 njain Exp $
 */

/*
 * Constants for the Golden Image.  
 * @author Jonathan Hui <jwhui@cs.berkeley.edu>
 */

#ifndef __GOLDEN_IMAGE_H__
#define __GOLDEN_IMAGE_H__

#define GI_NUM_SECTIONS  2

// Start address of the data and interrupt vector sections
const uint32_t startAddrs[GI_NUM_SECTIONS] = { 0x5000, 0xffe0 };
// End address of the data and interrupt vector sections
const uint32_t endAddrs[GI_NUM_SECTIONS] = { 0xb000, 0x10000 };

#define GI_GET_BYTE(x) (*(uint8_t*)((uint16_t)(x)))

#endif
