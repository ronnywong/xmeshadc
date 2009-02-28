/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: RadioEncoding.nc,v 1.1.4.1 2007/04/26 00:26:20 njain Exp $
 */
 
interface RadioEncoding
{
  async command result_t encode_flush();
  async command result_t encode(char data);
  async command result_t decode(char data);
  async event result_t decodeDone(char data, char error);
  async event result_t encodeDone(char data);
}
