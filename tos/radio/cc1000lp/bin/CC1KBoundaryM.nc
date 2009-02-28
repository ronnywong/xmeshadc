/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: CC1KBoundaryM.nc,v 1.2.4.1 2007/04/27 04:55:10 njain Exp $
 */

module CC1KBoundaryM {
  provides {
    interface CC1KBoundaryI;
  }
}
implementation {

 TOS_Msg RxBuf;

 command result_t CC1KBoundaryI.defined_CC1K_DEF_FREQ() {
   #ifdef CC1K_DEF_FREQ
     return TRUE;
   #else 
     return FALSE;
   #endif
 }

 command uint8_t CC1KBoundaryI.get_CC1K_DEF_FREQ() {
   #ifdef CC1K_DEF_FREQ
     return CC1K_DEF_FREQ;
   #else 
     return TOS_CC1K_CHANNEL;
   #endif
 }

 command result_t CC1KBoundaryI.defined_FREQ_433_MHZ(){
   #ifdef FREQ_433_MHZ
     return TRUE;
   #else 
     return FALSE;
   #endif
 }
  command uint16_t CC1KBoundaryI.get_crc(TOS_MsgPtr pMsg){
     return pMsg->crc;
  }
  command void CC1KBoundaryI.set_crc(TOS_MsgPtr pMsg, uint16_t val){
     pMsg->crc = val;
  }
  command uint8_t CC1KBoundaryI.offsetofCRC(){
     return offsetof(TOS_Msg,crc);
  }
  command TOS_MsgPtr CC1KBoundaryI.get_tos_msg_buf(){
     return &RxBuf;
  }
   command void  CC1KBoundaryI.set_time(TOS_MsgPtr pMsg, uint16_t time){
       pMsg->time = time;
   }
   command uint16_t  CC1KBoundaryI.get_strength(TOS_MsgPtr pMsg){
       return  pMsg->strength;
   }
   command void  CC1KBoundaryI.set_strength(TOS_MsgPtr pMsg, uint16_t strength){
      pMsg->strength = strength;
   }
   command uint8_t  CC1KBoundaryI.get_ack(TOS_MsgPtr pMsg){
      return pMsg->ack;
   }
   command void  CC1KBoundaryI.set_ack(TOS_MsgPtr pMsg, uint8_t ack){
      pMsg->ack = ack;
   }
   command uint8_t  CC1KBoundaryI.get_tos_data_length(){
      return TOSH_DATA_LENGTH;
   }
}
