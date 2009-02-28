/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: Receive.nc,v 1.1.4.1 2007/04/25 23:28:45 njain Exp $
 */
 
/*
 * Authors:		Philip Levis
 * Date last modified:  1/30/03
 *
 * The Receive interface should be provided by all protocols above layer
 * 2 (GenericComm/AM). For example, ad-hoc routing protocols should
 * provide this interface for receiving packets.
 *
 * The goal of this interface is to allow network end-points to
 * receive packet payloads without having to know about the internal
 * structure of the packet or the layers below them in the stack.
 *
 * The Receive interface is only used at the communication end-point,
 * allowing a buffer swap between the top-level application and the
 * networking stack. Hops along the way that want to look at the
 * internals of the packet (for in-network aggregation, for example),
 * should use the Intercept interface.
 *
 * For example, if a packet takes the route A->B->C->D
 *
 * A: send();
 * B: intercept();
 * C: intercept();
 * D: receive();
 */

/**
 * @author Philip Levis
 */


includes AM;
interface Receive {
  /**
   * Received a message buffer addressed to us.
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
   * @return The buffer to use for the next receive event.
   *
   */
  event TOS_MsgPtr receive(TOS_MsgPtr msg, void* payload, uint16_t payloadLen);
  
}
