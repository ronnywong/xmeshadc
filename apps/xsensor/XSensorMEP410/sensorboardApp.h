/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: sensorboardApp.h,v 1.1.4.1 2007/04/26 20:29:25 njain Exp $
 */

// crossbow sensor board id
#define  SENSOR_BOARD_ID 0x8A              //MEP401 sensor board id

typedef struct XSensorHeader{
  uint8_t  board_id;
  uint8_t  packet_id; // 3
  uint8_t  node_id;
  uint8_t  rsvd;
}__attribute__ ((packed)) XSensorHeader;


typedef struct XTotalData {
  uint16_t seq_no;
  uint16_t  vref;
  uint16_t humid;
  uint16_t humtemp;
  uint16_t inthum;
  uint16_t inttemp;     // 15
  uint16_t photo[4];    // 23
  uint16_t  accel_x;
  uint16_t  accel_y;
  uint16_t prtemp;
  uint16_t press;       // 29
  uint16_t presscalib[4]; // 37
} __attribute__ ((packed)) XTotalData;

typedef struct   XDataMsg {
  XSensorHeader xSensorHeader;
  union {
    XTotalData datax;
  }xData;
} __attribute__ ((packed)) XDataMsg;


enum {
  AM_XSXMSG = 0,
  
};
