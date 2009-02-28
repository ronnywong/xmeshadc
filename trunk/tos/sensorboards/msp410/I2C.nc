/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: I2C.nc,v 1.1.4.1 2007/04/27 05:25:19 njain Exp $
 */
 
/**
 * Byte and Command interface for using the I2C hardware bus
 */
interface I2C
{
  command result_t sendStart();
  command result_t sendEnd();
  command result_t read(bool ack);
  command result_t write(char data);
 
  event result_t sendStartDone();
  event result_t sendEndDone();
  event result_t readDone(char data);
  event result_t writeDone(bool success);
}
