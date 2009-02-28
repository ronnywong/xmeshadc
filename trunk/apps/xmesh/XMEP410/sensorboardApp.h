/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: sensorboardApp.h,v 1.2.4.1 2007/04/26 20:12:26 njain Exp $
 */

// crossbow sensor board id
#define  SENSOR_BOARD_ID 0x8A              //MEP401 sensor board id

typedef struct XMeshHeader{
  uint8_t  board_id;
  uint8_t  packet_id; // 3
  //uint8_t  node_id;
  uint16_t parent;
}__attribute__ ((packed)) XMeshHeader;



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
  XMeshHeader xMeshHeader;
  union {
    XTotalData  datax;
  }xData;
} __attribute__ ((packed)) XDataMsg;


enum {
  AM_XSXMSG = 0,
  
};
enum {
    AM_XDEBUG_MSG    = 49,
    AM_XSENSOR_MSG   = 50,
    AM_XMULTIHOP_MSG = 51,         // xsensor multihop 
};

#ifdef APP_RATE
uint32_t XSENSOR_SAMPLE_RATE = APP_RATE;
#else
#ifdef USE_LOW_POWER
uint32_t XSENSOR_SAMPLE_RATE = 184320;
#else
uint32_t XSENSOR_SAMPLE_RATE = 1843;
#endif
#endif

   uint32_t   timer_rate;  

