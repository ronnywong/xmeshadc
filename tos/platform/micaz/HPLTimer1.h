/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: HPLTimer1.h,v 1.1.4.1 2007/04/26 21:47:56 njain Exp $
 */

enum {
  TCLK_CPU_OFF = 0,
  TCLK_CPU_DIV1 =1,	 //MZ CPUCLK = 7.3278MHz
  TCLK_CPU_DIV8 = 2,
  TCLK_CPU_DIV64 = 3,
  TCLK_CPU_DIV256 = 4,	//34.722uSec
  TCLK_CPU_DIV1024 = 5
};
enum {
  TIMER1_DEFAULT_SCALE=TCLK_CPU_DIV64,	
  TIMER1_DEFAULT_INTERVAL=255
};

