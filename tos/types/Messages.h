/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: Messages.h,v 1.1.4.1 2007/04/27 06:07:12 njain Exp $
 */


#ifndef _H_MESSAGES_H_
#define _H_MESSAGES_H_

/***********************************************************************
 * Reserved TosMsg AM types 
 ***********************************************************************/

/**
 * Standard Active Message packet types used by XMesh are defined here.  
 *
 * User AM types are 100 to 200.  Other AM types are reserved by Crossbow 
 * for future development.
 *
 * AM_DEBUGPACKT      : Health packet
 * AM_DATA2BASE       : Upstream data message to base
 * AM_DATA2NODE       : Downstream data to node
 * AM_DATAACK2BASE    : Upstream data to base requiring an ack
 * AM_DATAACCK2NODE   : Downstream data to node requiring an ack
 * AM_DOWNSTREAM_ACK  : Acknowledge message from base to the originating mote
 * AM_UPSTREAM_ACK    : Acknowledge message from node to the originating base
 * AM_PATH_LIGHT DOWN : Create dedicated stream to node for designated time
 * AM_PATH_LIGHT_UP   : Create dedicated stream from node for designated time
 * AM_MULTIHOPMSG     : Route Update message
 */
enum {
  AM_HEALTH          = 3,    //!< 0x03 : Health packet
  AM_DEBUGPACKET     = 3,    //!< 0x03 : Health packet
  AM_DATA2BASE       = 11,   //!< 0x0B : Upstream data message to base
  AM_DATA2NODE       = 12,   //!< 0x0C : Downstream data to node
  AM_DATAACK2BASE    = 13,   //!< 0x0D : Upstream guaranteed delivery to base
  AM_DATAACK2NODE    = 14,   //!< 0x0E : Downstream guaranteed delivery to node
  AM_ANY2ANY         = 15,   //!< 0x0F : Any to any 

  AM_TIMESYNC        = 239,  //!< 0xEF : Time Sync packet
  AM_PREAMBLE        = 240,  //!< 0xFO : Low power preamble packet
  AM_DOWNSTREAM_ACK  = 246,  //!< 0xF6 : Ack message from base to node
  AM_UPSTREAM_ACK    = 247,  //!< 0xF7 : Ack message from node to base
  AM_PATH_LIGHT_DOWN = 248,  //!< 0xF8 : Light full power path down to node
  AM_PATH_LIGHT_UP   = 249,  //!< 0xF9 : Light full power path up to base
  AM_MULTIHOPMSG     = 250,  //!< 0xFA : Link estimation message
  AM_ONE_HOP         = 251,  //!< 0xFB : Single-hop service via XMesh  
  AM_HEARTBEAT       = 253,  //!< 0xFD : Heartbeat messages from the Base Station

  AM_MGMT            = 90,   //!< 0x5A : OTAP status message
  AM_BULKXFER        = 91,   //!< 0x5B : OTAP transfer fragment
  AM_MGMTRESP        = 92    //!< 0x5C : OTAP status acknowledgement
};

#endif // _H_MESSAGES_H_



