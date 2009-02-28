/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: SpiByteFifo.nc,v 1.1.4.1 2007/04/26 00:11:30 njain Exp $
 */
 
interface SpiByteFifo
{
  async command result_t send(uint8_t data);
  async command result_t idle();
  async command result_t startReadBytes(uint16_t timing);
  async command result_t txMode();
  async command result_t rxMode();
  async command result_t phaseShift();

  async event result_t dataReady(uint8_t data);
}
