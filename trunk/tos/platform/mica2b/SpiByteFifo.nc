/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: SpiByteFifo.nc,v 1.1.2.2 2007/04/26 00:20:00 njain Exp $
 */
 
interface SpiByteFifo
{
  async command result_t writeByte(uint8_t data);
  async command result_t isBufBusy();
  async command uint8_t readByte();
  async command result_t enableIntr();
  async command result_t disableIntr();
  async command result_t initSlave();
  async command result_t initMaster();
  async command result_t txMode();
  async command result_t rxMode();

  async event result_t dataReady(uint8_t data);
}
