/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: CC1KBoundaryI.nc,v 1.4.2.1 2007/04/25 23:20:08 njain Exp $
 */
 /**
  * commands that will be called out of the CC1000 radio binary
  */

includes AM;
interface CC1KBoundaryI {
   command result_t defined_CC1K_DEF_FREQ();
   command uint8_t get_CC1K_DEF_FREQ();
   command result_t defined_FREQ_433_MHZ();
   command uint16_t get_crc(TOS_MsgPtr pMsg);
   command void set_crc(TOS_MsgPtr pMsg, uint16_t crc);
   command uint8_t offsetofCRC();
   command TOS_MsgPtr get_tos_msg_buf();
   command void set_time(TOS_MsgPtr pMsg, uint16_t time);
   command uint16_t get_strength(TOS_MsgPtr pMsg);
   command void set_strength(TOS_MsgPtr pMsg, uint16_t strength);
   command uint8_t get_ack(TOS_MsgPtr pMsg);
   command void set_ack(TOS_MsgPtr pMsg, uint8_t ack);
   command uint8_t get_tos_data_length();
}
