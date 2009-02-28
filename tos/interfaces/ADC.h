/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: ADC.h,v 1.1.4.1 2007/04/25 23:17:09 njain Exp $
 */

/*
 * defines how often each sample is taken : sampling scale 
 */
enum {
  TOS_ADCSample3750ns = 0,
  TOS_ADCSample7500ns = 1,
  TOS_ADCSample15us =   2,
  TOS_ADCSample30us =   3,
  TOS_ADCSample60us =   4,
  TOS_ADCSample120us =  5,
  TOS_ADCSample240us =  6,
  TOS_ADCSample480us =  7
};
