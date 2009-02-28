/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: Send.nc,v 1.1.4.1 2007/04/25 23:30:00 njain Exp $
 */

/**
 * @author Philip Levis
 */


includes AM;
interface Send {
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
   * @return Whether the send request was successful: SUCCESS means a
   * sendDone() event will be signaled later, FAIL means one will not.
   */
  
  command result_t send(TOS_MsgPtr msg, uint16_t length);

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
