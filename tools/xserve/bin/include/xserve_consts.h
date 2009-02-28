/**
 * Global Constant definitions for XServe modules
 *
 * @file      xserve_consts.h
 * @author    Martin Turon, Rahul Kapur
 * @version   2004/3/10    mturon      Initial version
 * @n         2005/11/1    rkapur      Major rewrite for XServe2
 * Copyright (c) 2004 Crossbow Technology, Inc.   All rights reserved.
 *
 * $Id: xserve_consts.h,v 1.9.2.10 2007/03/13 22:32:05 rkapur Exp $
 */

#ifndef __XSERVE_CONST_H__
#define __XSERVE_CONST_H__

/**
 *  A unique identifier for each Crossbow sensorboard.
 *
 *  Note: The sensorboard id is organized to allow for identification of
 *        host mote as well:
 *
 *  if  (sensorboard_id < 0x80)  // mote is a mica2dot
 *  if  (sensorboard_id > 0x7E)  // mote is a mica2
 *
 * @version   2004/3/10    mturon      Initial version
 */
typedef enum {
  // surge packet
  XTYPE_SURGE = 0x00,

  // mica2dot sensorboards
  XTYPE_MDA500 = 0x01,
  XTYPE_MTS510,
  XTYPE_MEP500,
  XTYPE_MEP510,

  XTYPE_HEALTH = 0x10,

  XTYPE_TELOSB = 0x40,

  // mote boards
  XTYPE_MICA2 = 0x60,
  XTYPE_MICA2DOT,
  XTYPE_MICAZ,

  // mica2 sensorboards
  XTYPE_MDA400 = 0x80,
  XTYPE_MDA300,
  XTYPE_MTS101,
  XTYPE_MTS300,
  XTYPE_MTS310,
  XTYPE_MTS400,
  XTYPE_MTS420,
  XTYPE_MEP401,
  XTYPE_XTUTORIAL = 0x88,
  XTYPE_GGBACLTST,
  XTYPE_MEP410,

  XTYPE_MDA320 = 0x90,
  XTYPE_MDA100,
  XTYPE_MTS450,
  XTYPE_MDA325 = 0x93,

  // mica2 integrated boards
  XTYPE_MSP410 = 0xA0,
  XTYPE_MTP400 = 0xA1,
  XTYPE_MTS410 = 0xA2,

} XbowSensorboardType;

typedef enum {
    AMTYPE_XUART      = 0x00,
    AMTYPE_HEALTH     = 0x03,
    AMTYPE_SIMPLE_CMD = 0x08,
    AMTYPE_XMESH_PING = 0x0C,  // 12
    AMTYPE_XMESH_TEST = 0x0D,  // 13
    AMTYPE_SURGE_MSG  = 0x11,  // 17
    AMTYPE_SURGE_CMD  = 0x12,  // 18
    AMTYPE_XCOMMAND   = 0x30,  // 48
    AMTYPE_XDEBUG     = 0x31,  // 49
    AMTYPE_XSENSOR    = 0x32,  // 50
    AMTYPE_XMULTIHOP  = 0x33,  // 51
    AMTYPE_HEARTBEAT  = 0xFD,

    AMTYPE_XMESH_UP_MSG 	= 11,   //!< 0x0B : Upstream data message to base
    AMTYPE_XMESH_DOWN_MSG   = 12,   //!< 0x0C : Downstream data to node
    AMTYPE_XMESH_UP_MSG_ACK = 13,   //!< 0x0D : Upstream guaranteed delivery to base
    AMTYPE_XMESH_DOWN_MSG_ACK = 14,   //!< 0x0E : Downstream guaranteed delivery to node
    AMTYPE_XMESH_ANY2ANY         = 15,   //!< 0x0F : Any to any

    AMTYPE_TIMESYNC        = 239,  //!< 0xEF : Time Sync packet
    AMTYPE_PREAMBLE        = 240,  //!< 0xFO : Low power preamble packet
    AMTYPE_XMESH_DOWN_ACK  = 246,  //!< 0xF6 : Ack message from base to node
    AMTYPE_XMESH_UP_ACK    = 247,  //!< 0xF7 : Ack message from node to base
    AMTYPE_XMESH_PATH_LIGHT_DOWN = 248,  //!< 0xF8 : Light full power path down to node
    AMTYPE_XMESH_PATH_LIGHT_UP   = 249,  //!< 0xF9 : Light full power path up to base
    AMTYPE_XMESH_MULTIHOPMSG     = 250,  //!< 0xFA : Link estimation message
    AMTYPE_XMESH_ONE_HOP         = 251,  //!< 0xFB : Single-hop service via XMesh

    AMTYPE_MGMT            = 90,   //!< 0x5A : OTAP status message
    AMTYPE_BULKXFER        = 91,   //!< 0x60 : OTAP transfer fragment
    AMTYPE_MGMTRESP        = 92,    //!< 0x61 : OTAP status acknowledgement
    AMTYPE_XJOIN		   = 150,

} XbowAMType;


/**
 * Reserves general packet types that xlisten handles for all sensorboards.
 *
 * @version      2004/4/2     mturon      Initial version
 */
typedef enum {
  // reserved packet ids
  // reserved packet ids
  XPACKET_ACK      = 0x40,
  XPACKET_W_ACK    = 0x41,
  XPACKET_NO_ACK   = 0x42,

  XPACKET_ESC      = 0x7D,    //!< Reserved for serial packetizer escape code.
  XPACKET_START    = 0x7E,    //!< Reserved for serial packetizer start code.
  XPACKET_TEXT_MSG = 0xF8,    //!< Special id for sending text error messages.
} XbowGeneralPacketType;


enum {
  XDATAROW_NODEID = 0x01,
  XDATAROW_PARENTID,
  XDATAROW_BOARDID ,
  XDATAROW_LEGACY
};


enum {
  XTYPE_RAW = 0x01,
  XTYPE_CHAR,
  XTYPE_BYTE,
  XTYPE_SHORT,
  XTYPE_INT,
  XTYPE_LONG,
  XTYPE_FLOAT ,
  XTYPE_DOUBLE,
  XTYPE_UINT8,
  XTYPE_UINT16,
  XTYPE_UINT32,
  XTYPE_UINT64,
  XTYPE_STRING,
};




#define XPACKET_TYPE                2  //!< offset to type of TOS packet
#define XPACKET_GROUP               3  //!< offset to group id of TOS packet
#define XPACKET_LENGTH              4  //!< offset to length of TOS packet
#define XPACKET_SOCKET              11  //!< offset to type of TOS packet in xmesh 2


//define platform types
#define AVRMOTE 1
#define TELOS   2
#define MICAZ   3

#define XPACKET_MIN_SIZE            4   //!< minimum valid packet size
#define XHANDLE_TABLE_SIZE          512 //!< handle lookup table size
#define XPACKET_BUFLEN		        500 //!<Default size for a whole packet buffer
#define XDEFAULT_RANK				512
#define XPARAM_TABLE_SIZE			100

#define XREPORT_DATA_FILE_SIZE_MAX   	100000
#define XNODE_TABLE_SIZE   				100

#define XCONFIGXML_DIR_DEFAULT			"../configxml"
#define XPARSERS_LIB_DEFAULT			"../lib/parsers"
#define XDATASINKS_LIB_DEFAULT			"../lib/datasinks"
#define XCOMMAND_LIB_DEFAULT			"../lib/commands"
#define XREPORT_WEB_DIR_DEFAULT			"../web"



#define XPARAMS_FILENAME_VAR			"XSERVE_PARAMETER_FILE"
#define XCONFIGXML_DIR_VAR				"ConfigXMLDir"
#define XPARSERS_LIB_VAR				"ParserLibDir"
#define XDATASINKS_LIB_VAR				"DataSinkLibDir"
#define XREPORT_WEB_DIR_VAR				"XServeWebDir"
#define XSERVE_LOG_DIR_VAR				"XServeLogDir"
#define XCOMMAND_LIB_VAR				"CommandLibDir"



#define XPACKET_DATASTART_STANDARD  5  //!< Standard offset to data payload
#define XPACKET_DATASTART_MULTIHOP  12 //!< Multihop offset to data payload
#define XPACKET_DATASTART           12 //!< Default offset to data payload

enum {UPSTREAM = 0, DOWNSTREAM = 1};

enum{
	XREPORT_MINUTE,
	XREPORT_HOURLY,
	XREPORT_DAILY
};


#define RATE_CALC( max, count, interval) \
 count = count / interval; if( max < count )max = count; count = 0

#define SET_MIN( update, data) \
 if( update > data )update = data

#define SET_MAX( update, data) \
 if( update < data )update = data

#define VARIANCE( mean, data) \
 (mean - data)*(mean - data)




#endif



