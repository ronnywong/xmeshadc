/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: TimerJiffyAsync.nc,v 1.1.2.2 2007/04/26 00:07:57 njain Exp $
 */
 
// @author Cory Sharp <cssharp@eecs.berkeley.edu>


interface TimerJiffyAsync
{
  async command result_t setOneShot( uint32_t jiffy );

  async command result_t stop();

  async command bool isSet();

  async event result_t fired();
}

