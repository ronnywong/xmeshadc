/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: PacketSink.nc,v 1.1.4.1 2007/04/27 06:02:17 njain Exp $
 */

/*
 *
 * Authors:		David Gay, Philip Levis
 * Date last modified:  6/25/02
 *
 */


/* This component is a packet sink
*/

/**
 * @author David Gay
 * @author Philip Levis
 */

module PacketSink {
  provides {
    interface StdControl as Control;
    interface BareSendMsg as Send;
    interface ReceiveMsg as Receive;

    command result_t txBytes(uint8_t *bytes, uint8_t numBytes);
    /* Effects: start sending 'numBytes' bytes from 'bytes'
    */
  }
}
implementation
{
  command result_t Control.init() {
    return SUCCESS;
  }

  command result_t Control.start() {
    return SUCCESS;
  }

  command result_t Control.stop() {
    return SUCCESS;
  }
  
  command result_t txBytes(uint8_t *bytes, uint8_t numBytes) {
    return FAIL;
  }

  /* Command to transmit a packet */
  command result_t Send.send(TOS_MsgPtr msg) {
    return FAIL;
  }
}

