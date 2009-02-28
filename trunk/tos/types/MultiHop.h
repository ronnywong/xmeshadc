/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: MultiHop.h,v 1.4.2.1 2007/04/27 06:07:20 njain Exp $
 */


#ifndef _TOS_MULTIHOP_H
#define _TOS_MULTIHOP_H

typedef struct MultihopMsg {
  uint16_t sourceaddr;
  uint16_t originaddr;
  int16_t seqno;
  uint8_t socket; // this is where we put the application id
  uint8_t data[(TOSH_DATA_LENGTH - 7)]; 
} __attribute__ ((packed)) TOS_MHopMsg;

typedef struct ACKMsg {
  uint16_t source;
  uint8_t type;
} __attribute__ ((packed)) ACK_Msg;


 /**
  * Bit flags used in neigborhood table
  *
  * NBRFLAG_VALID : 1 = neighbor is valid
  * NBRFLAG_NEW:
  * NBRFLAG_EST_INIT
  */
  enum {
    NBRFLAG_VALID    = 0x01,
    NBRFLAG_NEW      = 0x02,
    NBRFLAG_EST_INIT = 0x04,
    NBRFLAG_EST_SLEEP = 0x08,
    NBRFLAG_EST_HOLD = 0x10
  };

  /**
   * XMesh Sending mode
   */
  enum {
    MODE_UPSTREAM,
    MODE_UPSTREAM_ACK,
    MODE_DOWNSTREAM,
    MODE_DOWNSTREAM_ACK,
    MODE_ANY2ANY,
    MODE_ONE_HOP_BROADCAST
  };

  /**
   * Bit flags using in RouteSelect
   */
  enum {
    RS_RESENT= 0x01,
    RS_FORCE_MONITOR= 0x02,
    RS_UPDATE_DSCTBL= 0x04,
    RS_SEARCH_DSCTBL= 0x08
  };
 /**
  * Constants used in neigbohood table calculation.
  *
  *  ROUTE_TABLE_SIZE : size of neigbor table. This also sets the max number
  *                    of children for this mote
  *  ESTIMATE_TO_ROUTE_RATIO  how often estimation is performed
  *  ACCEPTABLE_MISSED        Negative number , if (new seq no < than this) 
  *                                             then reset table entry
  *  ROUTE_UPDATE_INTERVAL    How often to xmit route updates
  *  SWITCH_THRESHOLD     	
  *  MAX_ALLOWABLE_LINK_COST 
  *  LIVELINESS               Max value for livliness in neighbor table      
  *  MAX_DESCENDANT
  *
  *  ROUTE_INVALID            Used to denote invalid parameters in neighbor tbl
  */
  enum {
    BASE_STATION_ADDRESS        = 0,
#ifdef BASE_STATION
    ROUTE_TABLE_SIZE            = 30,
#else
    ROUTE_TABLE_SIZE            = 15,
#endif
    ESTIMATE_TO_ROUTE_RATIO     = 5,
    ACCEPTABLE_MISSED           = -20,
#ifndef DESCENDANT_TABLE_SIZE
#ifdef BASE_STATION
    DESCENDANT_TABLE_SIZE	= 100,
#else
    DESCENDANT_TABLE_SIZE	= 50,
#endif
#endif
    SWITCH_THRESHOLD     	= 384,
    MAX_ALLOWABLE_LINK_COST     = 256*6,
    LIVELINESS              	= 2,
    MAX_DESCENDANT		= 5,
    MAX_RETRY                   = 8 
  };
#ifdef USE_LOW_POWER
    uint8_t NBR_ADVERT_THRESHOLD    = 10;
#else
    uint8_t NBR_ADVERT_THRESHOLD    = 100;
#endif

#ifdef ROUTE_UPDATE_INTERVAL  
	uint32_t TOS_ROUTE_UPDATE = ROUTE_UPDATE_INTERVAL;
#else
	#ifdef USE_LOW_POWER
               uint32_t TOS_ROUTE_UPDATE =  360000u;
	#else
    	       uint32_t TOS_ROUTE_UPDATE =  36000u;
	#endif
#endif
/**
 * XM_Flags - 1 byte in binary
 *   Bit 1 - Health Packet Enable
 *   Bit 2 - Watchdog Enable
 */
#ifndef CONFIG_NO_HEALTH_PKG
	#ifdef USE_WATCHDOG  
		uint8_t TOS_XM_FLAGS  = 0x3;
	#else
		uint8_t TOS_XM_FLAGS  = 0x1;
	#endif
#else
	#ifdef USE_WATCHDOG  
		uint8_t TOS_XM_FLAGS  = 0x2;
	#else
		uint8_t TOS_XM_FLAGS  = 0x0;
	#endif
#endif

#ifdef HEALTH_UPDATE_INTERVAL  
		uint32_t TOS_HEALTH_UPDATE  = HEALTH_UPDATE_INTERVAL;
#else
#ifdef USE_LOW_POWER
 		uint32_t TOS_HEALTH_UPDATE  = 600;
#else
 		uint32_t TOS_HEALTH_UPDATE  = 60;
#endif 		
#endif
/***********************************************************************
 * Limit buffers on mote to conserve ram for application code.
 * Base doesn't run application so it can have more buffers.  
 ***********************************************************************/
#ifndef MHOP_QUEUE_SIZE
#ifdef BASE_STATION
#define MHOP_QUEUE_SIZE 16
#else
#define MHOP_QUEUE_SIZE 8
#endif
#endif
  enum {
    ROUTE_INVALID    = 0xff
  };

  enum {
    FWD_QUEUE_SIZE = MHOP_QUEUE_SIZE, // Forwarding Queue
  };

  enum {
	UPSTREAM,
	DOWNSTREAM
  };

  enum {
	HIGHPOWER,
	LOWPOWER
  };

  enum {
	LitPathOff,
	LitPathOn,
        LitPathOtap
  };

  typedef struct RPEstEntry {
    uint16_t id;
    uint8_t receiveEst;
  } __attribute__ ((packed)) RPEstEntry;

  typedef struct RoutePacket {
    uint16_t parent;
    uint16_t cost;
    uint8_t estEntries;
    RPEstEntry estList[0];
  } __attribute__ ((packed)) RoutePacket;

/******************************************************************************
 * Neighborhood table structure
 * id              : node address neighbor
 * parent          : parent of neighbor
 * cost            : cost to xmit msg to base 
 * childLiveliness : valid downstream node since   
 * missed          : number of missed sequence numbers
 * received        : number of received message
 * lastSeqno       : last sequence number
 * flag            : NBRFLAG_VALID,NBRFLAG_NEW,NBRFLAG_EST_INIT
 * liveliness      : Init to zero, set to LIVELINESS when a route msg is
 *                 : rcvd and local mote is seen in route info 
 * hop             : hop count to base of this id
 * receiveEst      : 255 * #MsgRcvd/TotalMsgSentbyMote
 * sendEst         : receiveEst of this mote as determined by neighbor
  *****************************************************************************/
  typedef struct TableEntry {
    uint16_t id;  
    uint16_t parent;
    uint16_t cost;
    uint8_t childLiveliness;
    uint16_t missed;
    uint16_t received;
    int16_t lastSeqno;
    uint8_t flags;
    uint8_t liveliness;
    uint8_t hop;
    uint8_t receiveEst;
    uint8_t sendEst;
  } __attribute((packed)) TableEntry;

  typedef struct {
    uint16_t origin;
    uint16_t from;
  } __attribute__ ((packed)) DescendantTbl;

  typedef struct {
    uint8_t cmd_type;  
    uint16_t duration;
  } __attribute__ ((packed)) LitPathCmd;

#endif /* _TOS_MULTIHOP_H */
