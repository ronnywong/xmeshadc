/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: SendMsg.nc,v 1.1.4.1 2007/04/25 23:30:17 njain Exp $
 */
 
includes AM;

/**
 * Basic interface for sending AM messages. Interface to the basic
 * TinyOS communication primitive.
 *
 * @author Jason Hill
 * @author David Gay
 * @author Philip Levis
 * @modified 6/25/02 
 *
 *
 */

interface SendMsg
{ 
  command result_t send(uint16_t address, uint8_t length, TOS_MsgPtr msg);
  event result_t sendDone(TOS_MsgPtr msg, result_t success);
}
