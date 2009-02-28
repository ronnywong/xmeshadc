/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: AssrMask.h,v 1.1.2.2 2007/04/27 04:54:44 njain Exp $
 */

#if defined(TOSH_HARDWARE_MICA2) || defined(TOSH_HARDWARE_MICA2DOT)
#define ASSR_MASK 0x7
#elif defined(TOSH_HARDWARE_MICA2B)
#define ASSR_MASK 0x1f
#endif
