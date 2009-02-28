/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: BoundaryM.nc,v 1.1.4.1 2007/04/25 23:44:40 njain Exp $
 */

/** 
 * this module handle the request from inside the binary,
 * such as buffer allocation, outside parameter etc
 */

module BoundaryM {
  provides interface StdControl;
  provides interface BoundaryI;
#if defined(PLATFORM_MICA2) || defined(PLATFORM_MICA2DOT)
  uses interface    CC1000Control;
#elif defined(PLATFORM_MICAZ)
  uses interface    CC2420Control;
#elif defined(PLATFORM_TELOSB)
  uses interface    CC2420Control;
#endif
}
implementation {
/**
 *  in addition to the forward queue, we need to allocate 5 more TOS_Msg: 
 *  route update packet
 *  end to end ack packet
 *  neighbor health packet
 *  physical health packet
 *  otap boot response packet
 */
#define POOL_SIZE FWD_QUEUE_SIZE+5

  TableEntry NeighborTbl[ROUTE_TABLE_SIZE];
  DescendantTbl DscTbl[DESCENDANT_TABLE_SIZE];
  TOS_Msg gTOSBuffer[POOL_SIZE];
  uint8_t index=0;
  TOS_Msg *FwdBufList[FWD_QUEUE_SIZE];
  uint8_t FwdBufStatus[FWD_QUEUE_SIZE];
  static uint8_t singleton = 0;

  command result_t StdControl.init(){
     int i;
     if (singleton != 0) return SUCCESS;
     singleton++;
     for (i=0;i<FWD_QUEUE_SIZE;i++) FwdBufList[i]=NULL;
     memset((void *)NeighborTbl,0,(sizeof(TableEntry) * ROUTE_TABLE_SIZE));
     memset((void *)DscTbl,0,(sizeof(DescendantTbl) * DESCENDANT_TABLE_SIZE));
     return SUCCESS;
  }
  command result_t StdControl.start(){
     return SUCCESS;
  }
  command result_t StdControl.stop(){
     return SUCCESS;
  }

  command TOS_MsgPtr BoundaryI.xalloc(){
     if (index==POOL_SIZE) return NULL;
     index++;
     return (TOS_Msg *)(&gTOSBuffer[index-1]); 
  }
  command uint8_t BoundaryI.get_tos_data_length(){
    return TOSH_DATA_LENGTH;
  }
  command uint8_t BoundaryI.get_route_table_size(){
    return ROUTE_TABLE_SIZE;
  }
  command uint8_t BoundaryI.get_descendant_table_size(){
    return DESCENDANT_TABLE_SIZE;
  }
  command uint32_t BoundaryI.get_route_update_interval(){
    return TOS_ROUTE_UPDATE;
  }
  command uint8_t BoundaryI.get_power_model(){
#ifdef USE_LOW_POWER 
     return 0;
#else 
     return 1;
#endif
  }
/**
 * platform
 * 1: mica2 2:mica2dot 3:micaz 0: don't know
 */
  command uint8_t BoundaryI.get_platform(){
#if defined (TOSH_HARDWARE_MICA2)
    return 1;
#elif defined (TOSH_HARDWARE_MICA2DOT)
    return 2;
#elif defined (TOSH_HARDWARE_MICAZ)
    return 3;
#elif defined (TOSH_HARDWARE_TELOSB)
    return 4;
#endif
    return 0;
  }
  command void* BoundaryI.get_strength(TOS_MsgPtr pMsg){
     return &(pMsg->strength);
  }
  command uint8_t BoundaryI.get_ack(TOS_MsgPtr pMsg){
     return pMsg->ack;
  }
  command uint8_t BoundaryI.get_nbr_advert_threshold(){
     return NBR_ADVERT_THRESHOLD;
  }
  command bool BoundaryI.set_built_from_factory(){
#ifdef BUILT_FROM_FACTORY
     return TRUE;
#else 
     return FALSE;
#endif
  }
  command uint8_t BoundaryI.get_tos_cc_txpower() {
#if defined(PLATFORM_MICA2) || defined(PLATFORM_MICA2DOT)
     return call CC1000Control.GetRFPower();
#elif defined(PLATFORM_MICAZ)
     return TOS_CC2420_TXPOWER;
#elif defined(PLATFORM_TELOSB)
     return TOS_CC2420_TXPOWER;
#endif
     return 0;
  }
  command void BoundaryI.set_tos_cc_txpower(uint8_t power){
#if defined(PLATFORM_MICA2) || defined(PLATFORM_MICA2DOT)
     call CC1000Control.SetRFPower(power);
#elif defined(PLATFORM_MICAZ)
     TOS_CC2420_TXPOWER = power; 
     call CC2420Control.SetRFPower(power);
#elif defined(PLATFORM_TELOSB)
     TOS_CC2420_TXPOWER = power; 
     call CC2420Control.SetRFPower(power);
#endif
  }
  command uint8_t  BoundaryI.get_tos_cc_channel() {
#if defined(PLATFORM_MICA2) || defined(PLATFORM_MICA2DOT)
     return TOS_CC1K_CHANNEL; 
#elif defined(PLATFORM_MICAZ)
     return TOS_CC2420_CHANNEL; 
#elif defined(PLATFORM_TELOSB)
     return TOS_CC2420_CHANNEL; 
#endif
  }
  command void  BoundaryI.set_tos_cc_channel(uint8_t channel) {
#if defined(PLATFORM_MICA2) || defined(PLATFORM_MICA2DOT)
     TOS_CC1K_CHANNEL = channel; 
     call CC1000Control.TunePreset(TOS_CC1K_CHANNEL);
#elif defined(PLATFORM_MICAZ)
     TOS_CC2420_CHANNEL = channel; 
     call CC2420Control.TunePreset(TOS_CC2420_CHANNEL);
#elif defined(PLATFORM_TELOSB)
     TOS_CC2420_CHANNEL = channel; 
     call CC2420Control.TunePreset(TOS_CC2420_CHANNEL);
#endif
  }
// neighbor table get commands
  command uint16_t BoundaryI.get_nbrtbl_id(uint8_t iIndex){
       return NeighborTbl[iIndex].id;
  }
  command uint16_t BoundaryI.get_nbrtbl_parent(uint8_t iIndex){
       return NeighborTbl[iIndex].parent;
  }
  command uint16_t BoundaryI.get_nbrtbl_cost(uint8_t iIndex){
       return NeighborTbl[iIndex].cost;
  }
  command uint8_t  BoundaryI.get_nbrtbl_childLiveliness(uint8_t iIndex){
       return NeighborTbl[iIndex].childLiveliness;
  }
  command uint16_t BoundaryI.get_nbrtbl_missed(uint8_t iIndex){
       return NeighborTbl[iIndex].missed;
  }
  command uint16_t BoundaryI.get_nbrtbl_received(uint8_t iIndex){
       return NeighborTbl[iIndex].received;
  }
  command uint16_t BoundaryI.get_nbrtbl_lastSeqno(uint8_t iIndex){
       return NeighborTbl[iIndex].lastSeqno;
  }
  command uint8_t BoundaryI.get_nbrtbl_flags(uint8_t iIndex){
       return NeighborTbl[iIndex].flags;
  }
  command uint8_t BoundaryI.get_nbrtbl_liveliness(uint8_t iIndex){
       return NeighborTbl[iIndex].liveliness;
  }
  command uint8_t BoundaryI.get_nbrtbl_hop(uint8_t iIndex){
       return NeighborTbl[iIndex].hop;
  }
  command uint8_t BoundaryI.get_nbrtbl_receiveEst(uint8_t iIndex){
       return NeighborTbl[iIndex].receiveEst;
  }
  command uint8_t BoundaryI.get_nbrtbl_sendEst(uint8_t iIndex){
       return NeighborTbl[iIndex].sendEst;
  }

//neighbor table set commands
  command void  BoundaryI.set_nbrtbl_id(uint8_t iIndex,uint16_t value){
       NeighborTbl[iIndex].id = value;
  }
  command void  BoundaryI.set_nbrtbl_parent(uint8_t iIndex,uint16_t value){
       NeighborTbl[iIndex].parent= value;
  }
  command void  BoundaryI.set_nbrtbl_cost(uint8_t iIndex,uint16_t value){
       NeighborTbl[iIndex].cost = value;
  }
  command void   BoundaryI.set_nbrtbl_childLiveliness(uint8_t iIndex,uint8_t value){
       NeighborTbl[iIndex].childLiveliness = value;
  }
  command void  BoundaryI.set_nbrtbl_missed(uint8_t iIndex,uint16_t value){
       NeighborTbl[iIndex].missed = value;
  }
  command void  BoundaryI.set_nbrtbl_received(uint8_t iIndex,uint16_t value){
       NeighborTbl[iIndex].received= value;
  }
  command void  BoundaryI.set_nbrtbl_lastSeqno(uint8_t iIndex,uint16_t value){
       NeighborTbl[iIndex].lastSeqno = value;
  }
  command void  BoundaryI.set_nbrtbl_flags(uint8_t iIndex,uint8_t value){
       NeighborTbl[iIndex].flags= value;
  }
  command void  BoundaryI.set_nbrtbl_liveliness(uint8_t iIndex,uint8_t value){
       NeighborTbl[iIndex].liveliness = value;
  }
  command void  BoundaryI.set_nbrtbl_hop(uint8_t iIndex,uint8_t value){
       NeighborTbl[iIndex].hop = value;
  }
  command void  BoundaryI.set_nbrtbl_receiveEst(uint8_t iIndex,uint8_t value){
       NeighborTbl[iIndex].receiveEst = value;
  }
  command void  BoundaryI.set_nbrtbl_sendEst(uint8_t iIndex,uint8_t value){
       NeighborTbl[iIndex].sendEst = value;
  }
  command TableEntry* BoundaryI.get_nbrtbl_addr(uint8_t iIndex){

      return &NeighborTbl[iIndex];
  }
  command uint8_t BoundaryI.get_nbrtbl_size(){
      return sizeof(NeighborTbl)/sizeof(NeighborTbl[0]);
  }
// descendant table
  command uint16_t BoundaryI.get_dsctbl_origin(uint8_t iIndex){
      return DscTbl[iIndex].origin;
  }
  command uint16_t BoundaryI.get_dsctbl_from(uint8_t iIndex){
      return DscTbl[iIndex].from;
  }
  command void BoundaryI.set_dsctbl_origin(uint8_t iIndex, uint16_t value){
      DscTbl[iIndex].origin = value;
  }
  command void BoundaryI.set_dsctbl_from(uint8_t iIndex, uint16_t value){
      DscTbl[iIndex].from = value;
  }
  command DescendantTbl* BoundaryI.get_dsctbl_addr(uint8_t iIndex){
      return &DscTbl[0];
  }
//forward queue 
  command TOS_MsgPtr BoundaryI.get_fwd_buf_ptr(uint8_t iIndex){
      return FwdBufList[iIndex];
  }
  command void BoundaryI.set_fwd_buf_ptr(uint8_t iIndex,TOS_MsgPtr pMsg){
      FwdBufList[iIndex] = pMsg;
  }
  command uint8_t BoundaryI.get_fwd_buf_status(uint8_t iIndex){
      return FwdBufStatus[iIndex];
  }
  command void BoundaryI.set_fwd_buf_status(uint8_t iIndex, uint8_t status){
      FwdBufStatus[iIndex] = status;
  }
  command uint8_t BoundaryI.get_fwd_buf_size(){
      return FWD_QUEUE_SIZE;
  }
  command uint8_t BoundaryI.get_max_retry(){
      return MAX_RETRY;
  }
}
