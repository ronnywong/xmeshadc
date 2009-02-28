/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: BareSendMsg.nc,v 1.1.4.1 2007/04/25 23:18:53 njain Exp $
 */
/*
 * Authors:		Jason Hill, David Gay, Philip Levis
 * Date last modified:  6/26/02
 *
 *
 */

/**
 * Functionality for sending a raw packet buffer; unaware of message
 * structure (besides length). This is in contrast to SendMsg, which
 * takes parameters for message headers.
 * @author Jason Hill
 * @author David Gay
 * @author Philip Levis
 */


includes AM;
interface BareSendMsg
{
  /**
   * Send a message buffer over a communiation channel.
   *
   * @return SUCCESS if the buffer will be sent, FAIL if not. If
   * SUCCESS, a sendDone should be expected, if FAIL, the event should
   * not be expected.
   */
  command result_t send(TOS_MsgPtr msg);

  /**
   * Signals that a buffer was sent; success indicates whether the
   * send was successful or not.
   *
   * @return SUCCESS always.
   *
   */
  event result_t sendDone(TOS_MsgPtr msg, result_t success);
}
