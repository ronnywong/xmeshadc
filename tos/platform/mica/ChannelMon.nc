/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: ChannelMon.nc,v 1.1.4.1 2007/04/26 00:23:14 njain Exp $
 */
 
interface ChannelMon
{
  async command result_t init();
  async command result_t startSymbolSearch();
  async command result_t stopMonitorChannel();
  async command result_t macDelay();

  async event result_t startSymDetect();
  async event result_t idleDetect();
}
