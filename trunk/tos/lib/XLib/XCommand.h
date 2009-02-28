/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: XCommand.h,v 1.4.2.2 2007/04/25 23:42:40 njain Exp $
 */

/**
 * Provides a library module for handling basic application messages for
 * controlling a wireless sensor network.
 *
 * @file      XCommand.h
 * @author    Martin Turon
 * @version   2004/10/1    mturon      Initial version
 *
 * Summary of XSensor commands:
 *      reset, sleep, wakeup
 *  	set/get (rate) "heartbeat"
 *  	set/get (nodeid, group)
 *  	set/get (radio freq, band, power)
 *  	actuate (device, state)
 *  	set/get (calibration)
 *  	set/get (mesh type, max resend)
 *
 * Copyright (c) 2004 Crossbow Technology, Inc.   All rights reserved.
 *
 * $Id: XCommand.h,v 1.4.2.2 2007/04/25 23:42:40 njain Exp $
 */

#define INITIAL_TIMER_RATE   10000

enum {
	 // Power Management:
     XCOMMAND_RESET = 0x10,
     XCOMMAND_SLEEP,
     XCOMMAND_WAKEUP,

     // Basic update rate:
     XCOMMAND_SET_RATE = 0x20,                   // Update rate

     // MoteConfig Parameter settings:
     XCOMMAND_GET_CONFIG = 0x30,                 // Return radio freq and power,grouid,nodeid and UID
     XCOMMAND_SET_NODEID,
     XCOMMAND_SET_GROUP,
     XCOMMAND_SET_RF_POWER,
     XCOMMAND_SET_RF_CHANNEL,
     XCOMMAND_CONFIG_UID,

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
     XCMD_RES_FAIL = 0,
     XCMD_RES_SUCCESS = 1
} XCommandResponseCode;


typedef struct XCommandOp {
  uint16_t       cmd;   // XCommandOpcode
  uint8_t 		 cmdkey;
  union {
    uint32_t newrate;       //!< FOR XCOMMAND_SET_RATE
    uint16_t nodeid;        //!< FOR XCOMMAND_SET_NODEID
    uint8_t  group;         //!< FOR XCOMMAND_SET_GROUP
    uint8_t  rf_power;      //!< FOR XCOMMAND_SET_RF_POWER
    uint8_t  rf_channel;    //!< FOR XCOMMAND_SET_RF_CHANNEL

    /** FOR XCOMMAND_ACCTUATE */
    struct {
        uint16_t device;    //!< LEDS, sounder, relay, ...
        uint16_t state;     //!< off, on, toggle, ...
    } actuate;
		/** FOR CUSTOM ACTION */
		struct {
		    uint16_t type;    //!< FOR COMMAND TYPE
		    uint16_t value;     //!<  FOR CUSTOM VALUE
		} custom_data;

    /** FOR XEE UID Config Packet */
	struct {
		uint8_t serialid[8]; //!< 64 bit serial ID
		uint16_t nodeid;	 //!< nodeis is refered as UID
	} uidconfig;
  } param;
} __attribute__ ((packed)) XCommandOp;


typedef struct XCommandMsg {
  uint16_t     dest;      // +++ Desired destination (0xFFFF for broadcast?)
  XCommandOp   inst;
} __attribute__ ((packed)) XCommandMsg;

typedef struct XMeshMsg {
  XCommandOp  inst;
} __attribute__ ((packed)) XMeshMsg;

typedef struct XCmdDataHeader{
  uint8_t   board_id;  // mica2,mica2dot,micaz
  uint8_t   packet_id; // 1: default serialid msg
  uint16_t  node_id;
  uint8_t 	responseCode;   //Response Code !< Success or Fail
  uint8_t   cmdkey;
}__attribute__ ((packed)) XCmdDataHeader;

typedef struct ConfigData {
    uint8_t uid[8];
	uint16_t nodeid;
    uint8_t  group;
    uint8_t  rf_power;
    uint8_t  rf_channel;
} __attribute__ ((packed)) ConfigData;

typedef	struct UidConfigData{
	    uint16_t oldNodeid;  //!< Origin ID before Setting UID
		uint16_t nodeid;	 //!< nodeis is refered as UID
		uint8_t serialid[8]; //!< 64 bit serial ID
	    uint8_t isSuccess;   //!< Success or Fail
	} UidConfigData;


typedef struct XCmdDataMsg {
  XCmdDataHeader xHeader;
  union {
  uint32_t newrate;       //!< FOR XCOMMAND_SET_RATE
  ConfigData   configdata1;
  UidConfigData uidData1;
  uint16_t nodeid;
  uint8_t groupid;
  uint8_t rf_channel;
  struct RFData {
    uint8_t  rf_power;
    uint8_t  rf_channel;
	} rfParams;
  }xData;
} __attribute__ ((packed)) XCmdDataMsg;

#define  MOTE_BOARD_ID 0x69               //Unknown board id
#if defined(PLATFORM_MICA2)
#undef MOTE_BOARD_ID
#define  MOTE_BOARD_ID 0x60               //MICA2 board id
#endif
#if defined(PLATFORM_MICA2DOT)
#undef MOTE_BOARD_ID
#define  MOTE_BOARD_ID 0x61               //MICA2DOT board id
#endif
#if defined(PLATFORM_MICAZ)
#undef MOTE_BOARD_ID
#define  MOTE_BOARD_ID 0x62               //MICAZ board id
#endif

enum {
    AM_XCOMMAND_MSG  = 48,
    //AMTYPE_XMESH_CMD  = 0xF9,  // 249 downstream cmd
};

