/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: tos.h,v 1.3.4.2 2007/04/27 06:06:12 njain Exp $
 */


/*
 *
 * Authors:		Jason Hill, David Gay, Philip Levis, Nelson Lee
 * Date last modified:  6/25/02
 *
 */

/**
 * @author Jason Hill
 * @author David Gay
 * @author Philip Levis
 * @author Nelson Lee
 */


#if !defined(__CYGWIN__)
#if defined(__MSP430__)
#include <sys/inttypes.h>
#else
#include <inttypes.h>
#endif
#else //__CYGWIN
// Must be PLATFORM_PC...
#include <unistd.h>
#include <stdio.h>
#include <sys/types.h>

// Earlier cygwins do not define uint8_t & co
#ifndef _STDINT_H
#ifndef __uint8_t_defined
#define __uint8_t_defined
typedef u_int8_t uint8_t;
#endif

#ifndef __uint16_t_defined
#define __uint16_t_defined
typedef u_int16_t uint16_t;
#endif

#ifndef __uint32_t_defined
#define __uint32_t_defined
typedef u_int32_t uint32_t;
#endif
#endif

#endif //__CYGWIN
#include <string.h>
#include <stdlib.h>
#include <math.h>
#include <stddef.h>
#include <ctype.h>

#ifndef GENERICCOMM
# define GENERICCOMM GenericComm //the name of the default generic comm component
#endif

#ifndef GENERICCOMMPROMISCUOUS
# define GENERICCOMMPROMISCUOUS GenericCommPromiscuous //the name of the default promiscuous generic comm component
#endif

typedef unsigned char bool;
#ifdef FALSE //if FALSE is defined, undefine it, for the enum below
#undef FALSE
#endif
#ifdef TRUE //if TRUE is defined, undefine it, for the enum below
#undef TRUE
#endif
enum {
  FALSE = 0,
  TRUE = 1
};

#ifndef NESC_BUILD_BINARY
uint16_t TOS_LOCAL_ADDRESS = 1;
#else
extern uint16_t TOS_LOCAL_ADDRESS;
#endif

#ifdef ROUTE_PROTOCOL
uint8_t TOS_ROUTE_PROTOCOL = ROUTE_PROTOCOL;
#endif

#ifdef CPU_CLK
uint8_t TOS_CPU_CLK = CPU_CLK;
#endif

#ifdef CPU_PWRMGMT
uint8_t TOS_CPU_PWRMGMT = CPU_PWRMGMT;
#endif

#ifdef BASE_STATION
uint8_t TOS_BASE_STATION = 1;
#else 
uint8_t TOS_BASE_STATION = 0;
#endif

#ifdef TOSH_DATA_LENGTH
const uint8_t TOS_DATA_LENGTH = TOSH_DATA_LENGTH;
#else
const uint8_t TOS_DATA_LENGTH = 36;
#endif

#ifdef PLATFORM_MICA2
    uint8_t TOS_PLATFORM = 1;  // MICA2
#else 
   #ifdef PLATFORM_MICA2DOT
    uint8_t TOS_PLATFORM = 2;  // MICA2DOT
   #else
   		#ifdef PLATFORM_MICAZ
    	uint8_t TOS_PLATFORM = 3;  // MICAZ
    	#else
    		  #ifdef PLATFORM_MICA3
    		  uint8_t TOS_PLATFORM = 4;  // MICA3
    		  #else
    		  	#if defined( PLATFORM_MICA2B) || defined(PLATFORM_M9100) || defined(PLATFORM_M4100) 
    		  	uint8_t TOS_PLATFORM = 5;	//MICA2B
    		  	#else
    		  		#if defined( PLATFORM_MICAZB) || defined(PLATFORM_M2100) 
    		  		uint8_t TOS_PLATFORM = 6;	//MICAZB
    		  		#else
    		  			#if defined(PLATFORM_MICAZC) || defined(PLATFORM_M2110) 
    		  			uint8_t	 TOS_PLATFORM = 7;	//MICAZC
    		  			#else
    		  			uint8_t TOS_PLATFORM = 0xFF; // Unknown Platform
    		  			#endif
    		  		#endif
    		  	#endif
    		  #endif 
    	#endif        
   #endif    
#endif

enum { /* standard codes for result_t */
  FAIL = 0,
  SUCCESS = 1
};

#if NESC >= 110
uint8_t rcombine(uint8_t r1, uint8_t r2); // keep 1.1alpha1 happy
typedef uint8_t result_t __attribute__((combine(rcombine)));
#else
typedef uint8_t result_t;
#define atomic
#define async
#define norace
#endif

result_t rcombine(result_t r1, result_t r2)
/* Returns: FAIL if r1 or r2 == FAIL , r2 otherwise. This is the standard
     combining rule for results
*/
{
  return r1 == FAIL ? FAIL : r2;
}

result_t rcombine3(result_t r1, result_t r2, result_t r3)
{
  return rcombine(r1, rcombine(r2, r3));
}

result_t rcombine4(result_t r1, result_t r2, result_t r3,
				 result_t r4)
{
  return rcombine(r1, rcombine(r2, rcombine(r3, r4)));
}

#undef NULL
enum {
	NULL = 0x0
};

#include <hardware.h>
#include <dbg.h>
#include <sched.c>

// buggy in avr-gcc 3.1
void *nmemcpy(void *to, const void *from, size_t n)
{
  char *cto = to;
  const char *cfrom = from;

  while (n--) *cto++ = *cfrom++;
  
  return to;
}

void *nmemset(void *to, int val, size_t n)
{
  char *cto = to;

  while (n--) *cto++ = val;

  return to;
}

#if 0 /* to be turned by David Gay later */
int strcasecmp(const char *s1, const char *s2)
{
   while (*s1 && *s2)
     {
       int c1 = tolower(*s1++), c2 = tolower(*s2++);

       if (c1 != c2)
	return c1 - c2;
     }
   if (*s1)
     return 1;
   else if (*s2)
     return -1;
   else
     return 0;
}
#endif

#define memcpy nmemcpy
#define memset nmemset

#include "Ident.h"  //added by css

/* avr-gcc lib 3.3 for 128s defines an output() macro. 
 * This is clearly a bad idea.
 * But we have to live with it. The problem is that
 * the IntOutput interface has a command, output; if we don't
 * undef gcc's output. the compiler tosses an error at you.
 * -pal, 6/2/03
 */ 
#ifdef output
#undef output
#endif
