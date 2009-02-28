/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: Mic.nc,v 1.1.4.1 2007/04/27 05:26:51 njain Exp $
 */
 
/*
 * Authors:		Mike Grimmer
 * Date last modified:  2-20-04
 * 
 */

interface Mic 
{

  command result_t MicOn();
  command result_t MicOff();
  command result_t LPFsetFreq(uint8_t freq);
  command result_t HPFsetFreq(uint8_t freq);
  command result_t detectAdjust(uint8_t val);
  command result_t gainAdjust(uint8_t val);
}
