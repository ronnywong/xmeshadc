/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: PIR.nc,v 1.1.4.1 2007/04/27 05:27:58 njain Exp $
 */
 
/*
 * Authors:		Mike Grimmer
 * Date last modified:  2-20-04
 * 
 */

interface PIR 
{

  command result_t On();
  command result_t Off();

  command result_t detectAdjust(uint8_t val);
  command result_t QuadAdjust(uint8_t val);
  command uint8_t QuadRead(uint8_t* quaddetect);
  command result_t sampleNow();
  command result_t IntEnable();
  command result_t IntDisable();
  event result_t QuadAdjustDone();
  event result_t detectAdjustDone();
  event result_t InterruptEvent();
  event result_t DataDone(uint16_t val);
 
}
