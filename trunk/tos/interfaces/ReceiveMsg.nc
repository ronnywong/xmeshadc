/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: ReceiveMsg.nc,v 1.1.4.1 2007/04/25 23:28:53 njain Exp $
 */

/**
 * TinyOS AM packet reception interface.
 *
 * @author Jason Hill
 * @author David Gay
 * @author Philip Levis
 * @modified 6/25/02
 */

includes AM;
interface ReceiveMsg
{

  /**
   * A packet has been received. The packet received is passed as a
   * pointer parameter. The event handler should return a pointer to a
   * packet buffer for the reception layer to use for the next
   * reception. This allows an application to swap buffers back and
   * forth with the messaging layer, preventing the need for
   * copying. The signaled component should not maintain a reference
   * to the buffer that it returns. It may return the buffer it was
   * passed. For example:
   * <code><pre>
   * event TOS_MsgPtr ReceiveMsg.receive(TOS_MsgPtr m) {
   *    return m;
   * }
   * </pre></code>
   *
   * A more common example:
   * <code><pre>
   * TOS_MsgPtr buffer;
   * event TOS_MsgPtr ReceiveMsg.receive(TOS_MsgPtr m) {
   *    TOS_MsgPtr tmp;
   *    tmp = buffer;
   *    buffer = m;
   *	post receiveTask();
   *	return tmp;
   * }
   * </pre></code>
   *
   * @return A buffer for the provider to use for the next packet.
   *
   */
  event TOS_MsgPtr receive(TOS_MsgPtr m);
}
