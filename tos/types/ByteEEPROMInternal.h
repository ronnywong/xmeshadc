/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: ByteEEPROMInternal.h,v 1.1.4.1 2007/04/27 06:06:55 njain Exp $
 */

typedef struct RegionSpecifier_t {
  uint32_t startByte;
  uint32_t stopByte;
  struct RegionSpecifier_t *next;
} RegionSpecifier;

#include "ByteEEPROM_platform.h"
