/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: sensorboardApp.h,v 1.1.4.1 2007/04/26 20:36:34 njain Exp $
 */
/* sensorboard.h - hardware specific definitions for the MTS101 
*/

// crossbow sensor board id
#define  SENSOR_BOARD_ID 0x92               //MTS101 sensor board id

typedef struct XSensorHeader{
  uint8_t  board_id;
  uint8_t  packet_id; // 1
  uint16_t  node_id;
}__attribute__ ((packed)) XSensorHeader;

typedef struct PData1 {
  uint16_t vref;
  uint16_t humid;
  uint16_t temp;
  uint16_t gas;
  uint16_t cal[5];
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

