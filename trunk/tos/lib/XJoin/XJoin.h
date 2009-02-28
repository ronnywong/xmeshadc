/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: XJoin.h,v 1.1.4.1 2007/04/27 04:52:56 njain Exp $
 */

#ifndef _XJOIN_H
#define _XJOIN_H

#include "AM.h"


#define JOIN_REQUEST_PERIOD		1000
#define JOIN_REQACK_PERIOD		1000
#define JOIN_RESP_PERIOD		1000
#define JOIN_REQACK_BACKOFF_PERIOD	200

#define MAP_TABLE_SIZE			50

#define REJECT_LIST_SIZE		5

enum{
   NEW_NODE,
   JOINED_NODE
};

//new node states
enum {
	SENDING_JOIN_REQUEST=50,
	WAITING_FOR_ACK,
	WAITING_FOR_RESPONSE_LOCAL,
};

//joined node states
enum {
	WAITING_FOR_REQUEST=100,
	SENDING_REQUEST_ACK,
	WAITING_FOR_RESPONSE_MESH,
};


enum {
	JOIN_REQUEST_MSG,
	JOIN_REQUEST_ACK_MSG,
	JOIN_RESPONSE_MSG
};


enum {
	JOIN_ACCEPT,
	JOIN_REJECT,
};

//base station mapping entry
typedef struct _mappingEntry{
	uint64_t unique_id;
	uint16_t node_id;
} MappingEntry;


typedef struct _joinHeaderMsg{
	uint8_t msg_type;
	uint8_t data[0];
} __attribute__ ((packed)) JoinHdrMsg;

typedef struct _joinRequest{
	uint64_t unique_id;
	uint16_t requested_node_id;
	uint8_t group_reject_list[REJECT_LIST_SIZE];
} __attribute__ ((packed)) JoinRequest;


typedef struct _joinRequestAck{
  uint64_t unique_id;
  uint8_t group_id;
  uint16_t proxy_id;
  uint16_t fh_period;
  uint16_t fh_phase;
} __attribute__ ((packed)) JoinRequestAck;

typedef struct _joinResponse{
	uint8_t status;
	uint64_t unique_id;
	uint16_t node_id;
	uint8_t group_id;
} __attribute__ ((packed)) JoinResponse;


enum {
	AM_XJP_MESH = 150,
	AM_XJP_LOCAL = 118,
	AM_XJP_XSERVE = 119,
};


#endif
