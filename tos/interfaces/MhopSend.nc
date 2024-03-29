/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: MhopSend.nc,v 1.1.4.1 2007/04/25 23:26:07 njain Exp $
 */

/*
 * Authors:		Philip Levis
 * Date last modified:  8/12/02
 *
 * The Send interface should be provided by all protocols above layer
 * 2 (GenericComm/AM). For example, ad-hoc routing protocols should
 * provide this interface for sending packets.
 *
 * The goal of this interface is to allow applications to take part in
 * buffer swapping (avoiding the mbuf problem) on send while being
 * unaware of the structure of the underlying packet. When an
 * application wants to send a packet, it should call getBuffer(),
 * passing the packet buffer it will use. The underlying component,
 * aware of the structure of its headers and footers, returns a
 * pointer to the area of the packet that the application can fill
 * with data; it also provides the length of the usable region within
 * the buffer.
 *
 * The application can then fill this region with data and send it with
 * the send() call, stating how much of the region was used.
 *
 * getBuffer(), when called, should set all protocol fields into a
 * unique and recognizable state. This way, when a buffer is passed to
 * send(), the component can distinguish between packets that are
 * being forwarded and those that are originating at the mote.
 * Therefore, getBuffer() should not be called on a packet that is
 * being forwarded.
 *
 */

/**
 * @author Philip Levis
 */


includes AM;
interface MhopSend {
  /**
   * Send a message buffer with a data payload of a specific length.
   * The buffer should have its protocol fields set already, either through
   * a protocol-aware component or by getBuffer().
   *
   * @param msg The buffer to send.
   *
   * @param length The length of the data buffer sent using this
   * component. This must be <= the maximum length provided by
   * getBuffer().
   *
   * @param mode the mode of transportation ( upstream ack, upstream noack, 
   *  downstreamack, downstream no ack)
   *
   * @return Whether the send request was successful: SUCCESS means a
   * sendDone() event will be signaled later, FAIL means one will not.
   */
  
  command result_t send(uint16_t dest, uint8_t mode, TOS_MsgPtr msg, uint16_t length);

  /**
   * Given a TinyOS message buffer, provide a pointer to the data
   * buffer within it that an application can use as well as its
   * length. If a protocol-unaware application is sending a packet
   * with this interface, it must first call getBuffer() to get a
   * pointer to the valid data region. This allows the application to
   * send a specific buffer while not requiring knowledge of the
   * packet structure. When getBuffer() is called, protocol fields
   * should be set to note that this packet requires those fields to
   * be later filled in properly. Protocol-aware components (such as a
   * routing layer that use this interface to send) should not use
   * getBuffer(); they can have their own separate calls for getting
   * the buffer.
   *
   * @param msg The message to get the data region of.
   *
   * @param length Pointer to a field to store the length of the data region.
   *
   * @return A pointer to the data region.
   */
  
  command void* getBuffer(TOS_MsgPtr msg, uint16_t* length);


  
  /**
   * Signaled when a packet sent with send() completes.
   *
   * @param msg The message sent.
   *
   * @param success Whether the send was successful.
   *
   * @return Should always return SUCCESS.
   */
  event result_t sendDone(TOS_MsgPtr msg, result_t success);
}
