/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: BoundaryM.nc,v 1.18.2.4 2007/04/25 23:43:54 njain Exp $
 */
 
/** 
 * this module handle the request from inside the binary,
 * such as buffer allocation, outside parameter etc
 */

module BoundaryM {
  provides interface BoundaryI;
#if defined(PLATFORM_MICA2) \
  || defined(PLATFORM_MICA2DOT) \
  || defined(PLATFORM_M9100) \
  || defined(PLATFORM_M4100) 
  uses interface    CC1000Control;
#elif defined(PLATFORM_MICAZ) \
  || defined(PLATFORM_M2100) \
  || defined(PLATFORM_MICAZB) 
  uses interface    CC2420Control;
#elif defined(PLATFORM_MICAZC) \
  || defined(PLATFORM_M2110) 
  uses interface    RF230Control;
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

#define CHECK_AND_SET(tablename, length, index, field, value) \
       if (index < length) \
           tablename[index].field = value;
#define CHECK_AND_GET(tablename, length, index, field, invalid) \
       if (index < length) \
           return tablename[index].field; \
       else  \
           return invalid;

  TableEntry NeighborTbl[ROUTE_TABLE_SIZE];
  DescendantTbl DscTbl[DESCENDANT_TABLE_SIZE];
  TOS_Msg gTOSBuffer[POOL_SIZE];
  TOS_MsgPtr FwdBufList[FWD_QUEUE_SIZE];
  uint8_t FwdBufStatus[FWD_QUEUE_SIZE];

  command TOS_MsgPtr BoundaryI.xalloc(uint8_t iIndex){
     return &gTOSBuffer[iIndex]; 
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
#if defined(PLATFORM_MICA2) \
  || defined(PLATFORM_MICA2DOT) \
  || defined(PLATFORM_M9100) \
  || defined(PLATFORM_M4100) 
     return call CC1000Control.GetRFPower();
#elif defined(PLATFORM_MICAZ) \
  || defined(PLATFORM_M2100) \
  || defined(PLATFORM_MICAZB) 
     return TOS_CC2420_TXPOWER;
#elif defined(PLATFORM_MICAZC) \
  || defined(PLATFORM_M2110) 
     return TOS_RF230_TXPOWER;
#endif
     return 0;
  }
  command void BoundaryI.set_tos_cc_txpower(uint8_t power){
#if defined(PLATFORM_MICA2) \
  || defined(PLATFORM_MICA2DOT) \
  || defined(PLATFORM_M9100) \
  || defined(PLATFORM_M4100) 
     call CC1000Control.SetRFPower(power);
#elif defined(PLATFORM_MICAZ) \
  || defined(PLATFORM_M2100) \
  || defined(PLATFORM_MICAZB) 
     TOS_CC2420_TXPOWER = power; 
     call CC2420Control.SetRFPower(power);
#elif defined(PLATFORM_MICAZC) \
  || defined(PLATFORM_M2110) 
     TOS_RF230_TXPOWER = power; 
     call RF230Control.SetRFPower(power);
#endif
  }
  command uint8_t  BoundaryI.get_tos_cc_channel() {
#if defined(PLATFORM_MICA2) \
  || defined(PLATFORM_MICA2DOT) \
  || defined(PLATFORM_M9100) \
  || defined(PLATFORM_M4100) 
     return TOS_CC1K_CHANNEL; 
#elif defined(PLATFORM_MICAZ) \
  || defined(PLATFORM_M2100) \
  || defined(PLATFORM_MICAZB) 
     return TOS_CC2420_CHANNEL; 
#elif defined(PLATFORM_MICAZC) \
  || defined(PLATFORM_M2110) 
     return TOS_RF230_CHANNEL; 
#endif
  }
  command void  BoundaryI.set_tos_cc_channel(uint8_t channel) {
#if defined(PLATFORM_MICA2) \
  || defined(PLATFORM_MICA2DOT) \
  || defined(PLATFORM_M9100) \
  || defined(PLATFORM_M4100) 
     TOS_CC1K_CHANNEL = channel; 
     call CC1000Control.TunePreset(TOS_CC1K_CHANNEL);
#elif defined(PLATFORM_MICAZ) \
  || defined(PLATFORM_M2100) \
  || defined(PLATFORM_MICAZB) 
     TOS_CC2420_CHANNEL = channel; 
     call CC2420Control.TunePreset(TOS_CC2420_CHANNEL);
#elif defined(PLATFORM_MICAZC) \
  || defined(PLATFORM_M2110) 
     TOS_RF230_CHANNEL = channel; 
     call RF230Control.TunePreset(TOS_RF230_CHANNEL);
#endif
  }
// neighbor table get commands
  command uint16_t BoundaryI.get_nbrtbl_id(uint8_t iIndex){
       CHECK_AND_GET(NeighborTbl,ROUTE_TABLE_SIZE, iIndex, id, 0xffff);
  }
  command uint16_t BoundaryI.get_nbrtbl_parent(uint8_t iIndex){
       CHECK_AND_GET(NeighborTbl,ROUTE_TABLE_SIZE, iIndex, parent, 0xffff);
  }
  command uint16_t BoundaryI.get_nbrtbl_cost(uint8_t iIndex){
       CHECK_AND_GET(NeighborTbl,ROUTE_TABLE_SIZE, iIndex, cost, 0xffff);
  }
  command uint8_t  BoundaryI.get_nbrtbl_childLiveliness(uint8_t iIndex){
       CHECK_AND_GET(NeighborTbl,ROUTE_TABLE_SIZE, iIndex, childLiveliness, 0);
  }
  command uint16_t BoundaryI.get_nbrtbl_missed(uint8_t iIndex){
       CHECK_AND_GET(NeighborTbl,ROUTE_TABLE_SIZE, iIndex, missed, 0xffff);
  }
  command uint16_t BoundaryI.get_nbrtbl_received(uint8_t iIndex){
       CHECK_AND_GET(NeighborTbl,ROUTE_TABLE_SIZE, iIndex, received, 0xffff);
  }
  command uint16_t BoundaryI.get_nbrtbl_lastSeqno(uint8_t iIndex){
       CHECK_AND_GET(NeighborTbl,ROUTE_TABLE_SIZE, iIndex, lastSeqno, 0);
  }
  command uint8_t BoundaryI.get_nbrtbl_flags(uint8_t iIndex){
       CHECK_AND_GET(NeighborTbl,ROUTE_TABLE_SIZE, iIndex, flags, 0);
  }
  command uint8_t BoundaryI.get_nbrtbl_liveliness(uint8_t iIndex){
       CHECK_AND_GET(NeighborTbl,ROUTE_TABLE_SIZE, iIndex, liveliness, 0);
  }
  command uint8_t BoundaryI.get_nbrtbl_hop(uint8_t iIndex){
       CHECK_AND_GET(NeighborTbl,ROUTE_TABLE_SIZE, iIndex, hop, 0xff);
  }
  command uint8_t BoundaryI.get_nbrtbl_receiveEst(uint8_t iIndex){
       CHECK_AND_GET(NeighborTbl,ROUTE_TABLE_SIZE, iIndex, receiveEst, 0);
  }
  command uint8_t BoundaryI.get_nbrtbl_sendEst(uint8_t iIndex){
       CHECK_AND_GET(NeighborTbl,ROUTE_TABLE_SIZE, iIndex, sendEst, 0);
  }

//neighbor table set commands
  command void  BoundaryI.new_nbrtbl_entry(uint8_t iIndex,uint16_t nodeid){
    NeighborTbl[iIndex].id = nodeid;
    NeighborTbl[iIndex].flags = (NBRFLAG_VALID | NBRFLAG_NEW);
    NeighborTbl[iIndex].liveliness = 0;
    NeighborTbl[iIndex].parent = ROUTE_INVALID;
    NeighborTbl[iIndex].cost = ROUTE_INVALID;
    NeighborTbl[iIndex].childLiveliness = 0;
    NeighborTbl[iIndex].hop = ROUTE_INVALID;
    NeighborTbl[iIndex].missed = 0;
    NeighborTbl[iIndex].received = 0;
    NeighborTbl[iIndex].receiveEst = 0;
    NeighborTbl[iIndex].sendEst = 0;
  }
 
  command uint8_t  BoundaryI.find_nbrtbl_entry(uint16_t id){
    uint8_t i;
    for (i = 0; i < ROUTE_TABLE_SIZE; i++)
    {
      if ((NeighborTbl[i].flags & NBRFLAG_VALID) &&
           NeighborTbl[i].id == id)
      {
        return i;
      }
    }
    return ROUTE_INVALID;
  }

  command uint8_t  BoundaryI.find_dsctbl_entry(uint16_t id, uint8_t size){
     uint8_t i;
     i  = 0;
     while (i<size) {
        if (DscTbl[i].origin==id) return i;
        i++;
     }
     return ROUTE_INVALID;
  }

  command void  BoundaryI.set_nbrtbl_id(uint8_t iIndex,uint16_t value){
       CHECK_AND_SET(NeighborTbl,ROUTE_TABLE_SIZE, iIndex, id, value);
  }
  command void  BoundaryI.set_nbrtbl_parent(uint8_t iIndex,uint16_t value){
       CHECK_AND_SET(NeighborTbl,ROUTE_TABLE_SIZE, iIndex, parent, value);
  }
  command void  BoundaryI.set_nbrtbl_cost(uint8_t iIndex,uint16_t value){
       CHECK_AND_SET(NeighborTbl,ROUTE_TABLE_SIZE, iIndex, cost, value);
  }
  command void   BoundaryI.set_nbrtbl_childLiveliness(uint8_t iIndex,uint8_t value){
       CHECK_AND_SET(NeighborTbl,ROUTE_TABLE_SIZE, iIndex, childLiveliness, value);
  }
  command void  BoundaryI.set_nbrtbl_missed(uint8_t iIndex,uint16_t value){
       CHECK_AND_SET(NeighborTbl,ROUTE_TABLE_SIZE, iIndex, missed, value);
  }
  command void  BoundaryI.set_nbrtbl_received(uint8_t iIndex,uint16_t value){
       CHECK_AND_SET(NeighborTbl,ROUTE_TABLE_SIZE, iIndex, received, value);
  }
  command void  BoundaryI.set_nbrtbl_lastSeqno(uint8_t iIndex,uint16_t value){
       CHECK_AND_SET(NeighborTbl,ROUTE_TABLE_SIZE, iIndex, lastSeqno, value);
  }
  command void  BoundaryI.set_nbrtbl_flags(uint8_t iIndex,uint8_t value){
       CHECK_AND_SET(NeighborTbl,ROUTE_TABLE_SIZE, iIndex, flags, value);
  }
  command void  BoundaryI.set_nbrtbl_liveliness(uint8_t iIndex,uint8_t value){
       CHECK_AND_SET(NeighborTbl,ROUTE_TABLE_SIZE, iIndex, liveliness, value);
  }
  command void  BoundaryI.set_nbrtbl_hop(uint8_t iIndex,uint8_t value){
       CHECK_AND_SET(NeighborTbl,ROUTE_TABLE_SIZE, iIndex, hop, value);
  }
  command void  BoundaryI.set_nbrtbl_receiveEst(uint8_t iIndex,uint8_t value){
       CHECK_AND_SET(NeighborTbl,ROUTE_TABLE_SIZE, iIndex, receiveEst , value);
  }
  command void  BoundaryI.set_nbrtbl_sendEst(uint8_t iIndex,uint8_t value){
       CHECK_AND_SET(NeighborTbl,ROUTE_TABLE_SIZE, iIndex, sendEst, value);
  }
  command TableEntry* BoundaryI.get_nbrtbl_addr(uint8_t iIndex){
      return (TableEntry *)&NeighborTbl[iIndex];
  }
  command uint8_t BoundaryI.get_nbrtbl_size(){
      return sizeof(NeighborTbl)/sizeof(NeighborTbl[0]);
  }
// descendant table
  command uint16_t BoundaryI.get_dsctbl_origin(uint8_t iIndex){
       CHECK_AND_GET(DscTbl,DESCENDANT_TABLE_SIZE, iIndex, origin , 0xffff);
  }
  command uint16_t BoundaryI.get_dsctbl_from(uint8_t iIndex){
       CHECK_AND_GET(DscTbl,DESCENDANT_TABLE_SIZE, iIndex, from, 0xffff);
  }
  command void BoundaryI.set_dsctbl_origin(uint8_t iIndex, uint16_t value){
       CHECK_AND_SET(DscTbl,DESCENDANT_TABLE_SIZE, iIndex, origin, value);
  }
  command void BoundaryI.set_dsctbl_from(uint8_t iIndex, uint16_t value){
       CHECK_AND_SET(DscTbl,DESCENDANT_TABLE_SIZE, iIndex, from, value);
  }
  command DescendantTbl* BoundaryI.get_dsctbl_addr(uint8_t iIndex){
      return (DescendantTbl *)&DscTbl[iIndex];
  }
//forward queue 
  command TOS_MsgPtr BoundaryI.get_fwd_buf_ptr(uint8_t iIndex){
      return FwdBufList[iIndex];
  }
  command void BoundaryI.set_fwd_buf_ptr(uint8_t iIndex,TOS_MsgPtr pMsg){
      if (iIndex < FWD_QUEUE_SIZE) FwdBufList[iIndex] = pMsg;
  }
  command uint8_t BoundaryI.get_fwd_buf_status(uint8_t iIndex){
     if (iIndex < FWD_QUEUE_SIZE)
         return FwdBufStatus[iIndex];
     else 
         return 0;
  }
  command void BoundaryI.set_fwd_buf_status(uint8_t iIndex, uint8_t status){
     if (iIndex < FWD_QUEUE_SIZE) FwdBufStatus[iIndex] = status;
  }
  command uint8_t BoundaryI.get_fwd_buf_size(){
      return FWD_QUEUE_SIZE;
  }
  command uint8_t BoundaryI.get_max_retry(){
      return MAX_RETRY;
  }
}
