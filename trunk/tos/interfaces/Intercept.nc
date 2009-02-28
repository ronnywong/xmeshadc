/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: Intercept.nc,v 1.1.4.1 2007/04/25 23:24:35 njain Exp $
 */
 
/*
 * Authors:		Philip Levis
 * Date last modified:  1/30/03
 *
 * The Intercept interface should be provided by all protocols above layer
 * 2 (GenericComm/AM). For example, ad-hoc routing protocols should
 * provide this interface for in-network packet processing.
 *
 * The goal of this interface is to allow transmission hops to 
 * process packet payloads without having to know about the internal
 * structure of the packet or the layers below them in the stack.
 *
 * The Interface interface is only used by nodes that are forwarding a
 * multihop messages. A protocol layer does not perform a buffer swap, but
 * can tell lower layers to not forward a packet by giving a FAIL return value.
 * Using this, an in-network intermediary can receive multiple packets, aggregate
 * their results, then forward them on to the destination.
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
interface Intercept {
  /**
   *
   * Signals that a message has been received, which is supposed to be
   * forwarded to another destination. Allows protocol layers above the
   * routing layer to perform data aggregation or make application-specific
   * decisions on whether to forward.
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
   * @return SUCCESS indicates the packet should be forwarded, FAIL
   * indicates that it should not be forwarded.
   *
   */
  event result_t intercept(TOS_MsgPtr msg, void* payload, uint16_t payloadLen);
  
}
