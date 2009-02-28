/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: Snoop.nc,v 1.1.4.1 2007/04/25 23:30:42 njain Exp $
 */
 
 /*
 * Authors:		Wei Hong
 * Date last modified:  03/03/03
 *
 */

/**
 * @author Wei Hong
 */


includes AM;
interface Snoop {
  /**
   *
   * Signals that a message that was not destined to the current node
   * has been received promiscuously.  Allows applications to perform
   * certain optimizations taking advantage of the broadcast media.
   *
   * @param msg The complete buffer received.
   *
   * @param payload The payload portion of the packet for this
   * protocol layer. If this layer has layers above it, it should signal
   * receive() with payload incremented by the size of its header. Payload
   * is a pointer into the msg structure.
   *
   * @param payloadLen The length of the payload buffer. If this layer
   * has layers above it, it should signal receive() with payloadLen
   * decreased by the size of its headers and footers.
   *
   * @param sender The address of the sender of the snooped message.
   *
   */
  event void snoop(TOS_MsgPtr msg, void* payload, uint16_t payloadLen, uint16_t sender);
}
