/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: sensorboardApp.h,v 1.1.2.5 2007/04/26 20:05:01 njain Exp $
 */

/* sensorboard.h - hardware specific definitions for the MTS300/310 
*/

TOSH_ALIAS_PIN(PHOTO_CTL, INT1);
TOSH_ALIAS_PIN(TEMP_CTL, INT2);

enum {
  TOSH_ACTUAL_PHOTO_PORT = 1,
  TOSH_ACTUAL_TEMP_PORT = 1, 
};

enum {
  TOS_ADC_PHOTO_PORT = 1,
  TOS_ADC_TEMP_PORT = 2,
};


#define FEATURE_SOUNDER     1

// Define SOUND_STATE_CHANGE one of two ways:
//      One time sound at test init   ==>  FALSE
//      Continuous beeping throughout ==>  !sound_state
#define SOUND_STATE_CHANGE  FALSE
//#define SOUND_STATE_CHANGE  !sound_state

// crossbow sensor board id
#define  SENSOR_BOARD_ID 0x88               //XTYPE_XTUTORIAL=0x88

#ifndef PhotoLogCount
#define PhotoLogCount	 8
#endif

enum {
  BYTE_EEPROM_ID = unique("ByteEEPROM"),
};

typedef struct XSensorHeader{
  uint8_t  board_id;
  uint8_t  packet_id; // 3
  uint8_t  node_id;
  uint8_t  rsvd;
}__attribute__ ((packed)) XSensorHeader;

typedef struct PData1 {
  uint16_t light[PhotoLogCount];
} __attribute__ ((packed)) PData1;

typedef struct XDataMsg {
  XSensorHeader xSensorHeader;
  union {
  PData1    datap1;
  }xData;
} __attribute__ ((packed)) XDataMsg;

enum {
  AM_XSXMSG = 0,
  
};
