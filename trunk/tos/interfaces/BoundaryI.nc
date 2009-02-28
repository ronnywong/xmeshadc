/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: BoundaryI.nc,v 1.12.2.1 2007/04/25 23:19:35 njain Exp $
 */
 /**
  * commands that will be called out from inside of XMesh binary
  * the binary needs to access TOS_Msg buffer, neighbor table and 
  * descendant table, which are not within the binary boundary
  */

interface BoundaryI {
/**
 * commands to access tos msg buffer
 * such that tos msgs of varied size are possible with the binary
 */
  command TOS_MsgPtr xalloc(uint8_t index);
  command void*    get_strength(TOS_MsgPtr pMsg);
  command uint8_t  get_ack(TOS_MsgPtr pMsg);
  command uint8_t  get_tos_data_length();
  command uint8_t  get_power_model();
  command uint8_t  get_platform();
  command uint8_t  get_nbr_advert_threshold();
  command uint32_t get_route_update_interval();
  command uint8_t  get_route_table_size();
  command uint8_t  get_max_retry();
  command uint8_t  get_descendant_table_size();
  command bool     set_built_from_factory();
  command void     set_tos_cc_channel(uint8_t channel);
  command uint8_t  get_tos_cc_channel();
  command void     set_tos_cc_txpower(uint8_t power);
  command uint8_t  get_tos_cc_txpower();

/**
 * commands to access (get/set) neighbor table
 */
  command uint16_t get_nbrtbl_id(uint8_t index);
  command uint16_t get_nbrtbl_parent(uint8_t index);
  command uint16_t get_nbrtbl_cost(uint8_t index);
  command uint8_t  get_nbrtbl_childLiveliness(uint8_t index);
  command uint16_t get_nbrtbl_missed(uint8_t index);
  command uint16_t get_nbrtbl_received(uint8_t index);
  command uint16_t get_nbrtbl_lastSeqno(uint8_t index);
  command uint8_t  get_nbrtbl_flags(uint8_t index);
  command uint8_t  get_nbrtbl_liveliness(uint8_t index);
  command uint8_t  get_nbrtbl_hop(uint8_t index);
  command uint8_t  get_nbrtbl_receiveEst(uint8_t index);
  command uint8_t  get_nbrtbl_sendEst(uint8_t index);
  command void     new_nbrtbl_entry(uint8_t index,uint16_t nodeid);
  command uint8_t  find_nbrtbl_entry(uint16_t id);
  command void     set_nbrtbl_id(uint8_t index,uint16_t value);
  command void     set_nbrtbl_parent(uint8_t index,uint16_t value);
  command void     set_nbrtbl_cost(uint8_t index, uint16_t value);
  command void     set_nbrtbl_childLiveliness(uint8_t index, uint8_t value);
  command void     set_nbrtbl_missed(uint8_t index, uint16_t value);
  command void     set_nbrtbl_received(uint8_t index,uint16_t value);
  command void     set_nbrtbl_lastSeqno(uint8_t index,uint16_t value);
  command void     set_nbrtbl_flags(uint8_t index,uint8_t value);
  command void     set_nbrtbl_liveliness(uint8_t index,uint8_t value);
  command void     set_nbrtbl_hop(uint8_t index,uint8_t value);
  command void     set_nbrtbl_receiveEst(uint8_t index,uint8_t value);
  command void     set_nbrtbl_sendEst(uint8_t index,uint8_t value);
  command uint8_t  get_nbrtbl_size();
  command TableEntry* get_nbrtbl_addr(uint8_t index);

/**
 *commands to access (get/set) descendant table
 */
  command uint8_t  find_dsctbl_entry(uint16_t id, uint8_t size);
  command uint16_t get_dsctbl_origin(uint8_t iIndex);
  command uint16_t get_dsctbl_from(uint8_t iIndex);
  command void     set_dsctbl_origin(uint8_t iIndex, uint16_t value);
  command void     set_dsctbl_from(uint8_t iIndex, uint16_t value);
  command DescendantTbl* get_dsctbl_addr(uint8_t index);

/**
 * commands to access (get/set) forward queue 
 */
  command void     set_fwd_buf_ptr(uint8_t index,TOS_MsgPtr pMsg);
  command uint8_t  get_fwd_buf_status(uint8_t index);
  command void     set_fwd_buf_status(uint8_t index, uint8_t status);
  command uint8_t  get_fwd_buf_size();
  command TOS_MsgPtr get_fwd_buf_ptr(uint8_t index);
}
