/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: Reset.h,v 1.1.4.1 2007/04/27 06:03:07 njain Exp $
 */


/* 
 * Authors:  Wei Hong
 *           Intel Research Berkeley Lab
 * Date:     7/15/2002
 *
 */

/**
 * @author Wei Hong
 * @author Intel Research Berkeley Lab
 */


void resetMote()
{
#if defined(PLATFORM_MICA) || defined(PLATFORM_MICA2) || defined(PLATFORM_MICA2DOT) || defined (PLATFORM_MICAZ)
    	cli(); 
  	wdt_enable(0); 
  	while (1) { 
  		__asm__ __volatile__("nop" "\n\t" ::);
  	}
#endif
  
}
