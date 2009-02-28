/**
 * Handles generating and sending commands to control an XSensor application.
 *
 * @file      cmd_XSensor.c
 * @author    Martin Turon
 * @version   2004/10/5    mturon      Initial version
 *
 * Copyright (c) 2004 Crossbow Technology, Inc.   All rights reserved.
 *
 * $Id: xcmd_base.h,v 1.9.2.10 2007/03/13 22:29:51 rkapur Exp $
 */

#include "xcmd_server.h"
#include "xconvert.h"
#include "xutil.h"


/****************************************

	Command Message Packet formats

*****************************************/
typedef struct XCommandOp {
    uint16_t     cmd;         // XCommandOpcode
	uint8_t cmdkey;

    union {
	uint32_t newrate;       //!< FOR XCOMMAND_SET_RATE
	uint16_t nodeid;        //!< FOR XCOMMAND_SET_NODEID
	uint8_t  group;         //!< FOR XCOMMAND_SET_GROUP
	uint8_t  rf_power;      //!< FOR XCOMMAND_SET_RF_POWER
	uint32_t rf_channel;    //!< FOR XCOMMAND_SET_RF_CHANNEL
	uint16_t path_time;

	/** FOR XCOMMAND_ACCTUATE */
	struct {
	    uint16_t device;    //!< LEDS, sounder, relay, ...
	    uint16_t state;     //!< off, on, toggle, ...
	} actuate;

	/** FOR XEE UID Config Packet */
	struct {
		uint8_t serialid[8]; //!< 64 bit serial ID
		uint16_t nodeid;	 //!< nodeis is refered as UID
	} uidconfig;
	/** FOR CUSTOM ACTION */
	struct {
	    uint16_t type;    //!< FOR COMMAND TYPE
	    uint16_t value;     //!<  FOR CUSTOM VALUE
	} custom_data;

    } param;
} __attribute__ ((packed)) XCommandOp;



typedef struct XMeshCmdMsg {
    TosMsg       tos;
    MultihopMsg  multihop;
    XCommandOp   inst;
} __attribute__ ((packed)) XMeshCmdMsg;

typedef struct XSensorCmdMsg {
    TosMsg 		 tos;
    uint16_t     seqno;
    uint16_t     dest;
    XCommandOp   inst;
} __attribute__ ((packed)) XSensorCmdMsg;


typedef struct _XCommandRespHeader {
  uint8_t   board_id;  // mica2,mica2dot,micaz
  uint8_t   packet_id; // 1: default serialid msg
  uint16_t  node_id;
  uint8_t 	responseCode;   //Response Code !< Success or Fail
  uint8_t   cmdkey;
 } __attribute__ ((packed)) XCommandRespHeader;

typedef struct _ConfigData{
		uint8_t uid[8];
		uint16_t nodeid;
		uint8_t  group;
		uint8_t  rf_power;
		uint8_t  rf_channel;
} __attribute__ ((packed)) ConfigData;

typedef struct _UidConfigData{
		uint16_t oldNodeid;  //!< Origin ID before Setting UID
		uint16_t nodeid;	 //!< nodeis is refered as UID
		uint8_t serialid[8]; //!< 64 bit serial ID
		uint8_t isSuccess;   //!< Success or Fail
} __attribute__ ((packed)) UidConfigData;

typedef struct _RFData {
	uint8_t  rf_power;
	uint8_t  rf_channel;
} __attribute__ ((packed)) RFData;


typedef struct _XCommandRespData {
  union {
	  uint32_t newrate;       //!< FOR XCOMMAND_SET_RATE
	  ConfigData configdata;
	  UidConfigData uiddata;
	  uint16_t nodeid;
	  uint8_t groupid;
	  uint8_t rf_channel;
	  RFData rfdata;
   }data;
} __attribute__ ((packed)) XCommandRespData;

typedef struct XMeshCmdRespMsg {
    TosMsg       tos;
    MultihopMsg  multihop;
    XCommandRespHeader resphdr;
    XCommandRespData respdata;
} __attribute__ ((packed)) XMeshCmdRespMsg;






/****************************************

	Command States

*****************************************/


enum {
	XMESH = 1,
	XSENSOR = 2,
	SURGE = 3,
} XTransportTypes;


enum {

    // Power Management:
    XCOMMAND_RESET = 0x10,
    XCOMMAND_SLEEP,
    XCOMMAND_WAKEUP,

    // Basic update rate:
    XCOMMAND_SET_RATE = 0x20,         // Update rate

    // MoteConfig Parameter settings:
    XCOMMAND_GET_CONFIG = 0x30,       // Return radio freq and power
    XCOMMAND_SET_NODEID,
    XCOMMAND_SET_GROUP,
    XCOMMAND_SET_RF_POWER,
    XCOMMAND_SET_RF_CHANNEL,

    // Actuation:
    XCOMMAND_ACTUATE = 0x40,
    
    // custom action, need not save parameters
    XCOMMAND_CUSTOM_ACTION = 0x60,

} XCommandOpcode;

enum {
     XCMD_DEVICE_LED_GREEN,
     XCMD_DEVICE_LED_YELLOW,
     XCMD_DEVICE_LED_RED,
     XCMD_DEVICE_LEDS,
     XCMD_DEVICE_SOUNDER,
     XCMD_DEVICE_RELAY1,
     XCMD_DEVICE_RELAY2,
     XCMD_DEVICE_RELAY3
} XSensorSubDevice;


enum {
     XCMD_STATE_OFF = 0,
     XCMD_STATE_ON = 1,
     XCMD_STATE_TOGGLE
} XSensorSubState;

enum {
	CONFIG_PKT=0x81,
  	UID_PKT,
  	SETNODEID_PKT,
  	SETGROUPID_PKT,
  	SETFREQ_PKT,
  	SETRFPOWER_PKT,
  	SETTIMERRATE_PKT
} XCommandRespCodes;


/****************************************

Set up Command Op payload

*****************************************/


int cmd_basic(XCommandOp* op, int opcode);
int cmd_get_config(XCommandOp * op);
int cmd_set_rate(XCommandOp* op, int newrate);
int cmd_set_nodeid(XCommandOp* op, uint16_t nodeid);
int cmd_set_groupid(XCommandOp* op,uint8_t newgroup);
int cmd_set_rfchannel(XCommandOp* op,int rfchannel);
int cmd_set_rfpower(XCommandOp* op, int rfpower);
int cmd_actuate(XCommandOp* op, int device, int state);
int cmd_reset(XCommandOp* op);
int cmd_sleep(XCommandOp* op);
int cmd_wake (XCommandOp* op);
int cmd_green_off(XCommandOp* op);
int cmd_green_on(XCommandOp* op);
int cmd_green_toggle(XCommandOp* op);
int cmd_red_off(XCommandOp* op);
int cmd_red_on(XCommandOp* op);
int cmd_red_toggle(XCommandOp* op);
int cmd_yellow_off(XCommandOp* op);
int cmd_yellow_on(XCommandOp* op) ;
int cmd_yellow_toggle(XCommandOp* op);
int cmd_relay1_open(XCommandOp* op);
int cmd_relay1_close(XCommandOp* op);
int cmd_relay1_toggle(XCommandOp* op);
int cmd_relay2_open(XCommandOp* op);
int cmd_relay2_close(XCommandOp* op);
int cmd_relay2_toggle(XCommandOp* op);
int cmd_set_leds(XCommandOp* op, int leds);
int cmd_set_sounder(XCommandOp* op, int sounder);


int xmlrpc_get_int_from_vec(XMLRPC_VALUE vec, char* name, int* intval);
int xmlrpc_get_string_from_vec(XMLRPC_VALUE vec, char* name, const char** strval);
XCommandOp* cmd_set_headers(int msgtype, char * buffer, uint8_t tos_type,int seq_no, uint16_t dest, uint8_t group );
XMLRPC_VALUE cmd_generate_response(char* buffer, int len);
