/*
 * Copyright (c) 2002-2005 Intel Corporation
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: TokenReceiveMsg.nc,v 1.1.4.1 2007/04/25 23:33:20 njain Exp $
 */

/* 
 * Author: Phil Buonadonna
 * Revision: $Revision: 1.1.4.1 $
 * 
 */

/**
 * @author Phil Buonadonna
 */


includes AM;

/**
 * Receive messages with an identifying token that can be used for
 * acknowledgement.
 *
 * @author Phil Buonadonna
 */

interface TokenReceiveMsg
{

  /** 
   * A packet and an associated token have been recieved. 
   * The one-byte token is a unique value linked to the message received.
   * This interface is designed for use by modules like HDLCM which 
   * may pass a token up that is later used as part of an acknowledgement
   * process.
   *
   * @param Msg A pointer to the received TOS_Msg
   * @param Token A one byte token associated with the recieved message.
   *
   * @return A buffer for the provider to use for the next packet.
   * 
   */

  event TOS_MsgPtr receive(TOS_MsgPtr Msg, uint8_t Token);

  /**
   * Sends a one byte token down the original channel that received the token.
   * This function can be used as an acknowledgement mechanism.
   *
   * @param Token  A one byte token.
   *
   * @return SUCCESS if the provider was able to queue the token for 
   * transmission.
   *
   */

  command result_t ReflectToken(uint8_t Token);


}
