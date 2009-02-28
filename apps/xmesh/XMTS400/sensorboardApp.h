/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: sensorboardApp.h,v 1.1.2.4 2007/04/26 20:19:31 njain Exp $
 */

// controls for the voltage reference monitor
#define MAKE_BAT_MONITOR_OUTPUT() sbi(DDRA, 5)
#define MAKE_ADC_INPUT() cbi(DDRF, 7)
#define SET_BAT_MONITOR() sbi(PORTA, 5)
#define CLEAR_BAT_MONITOR() cbi(PORTA, 5)


typedef struct XMeshHeader{
  uint8_t  board_id;
  uint8_t  packet_id; // 3
  //uint8_t  node_id;
  uint16_t parent;
}__attribute__ ((packed)) XMeshHeader;

/* * PACKET #3 
 * ----------------
 *  msg->data[0] : sensor id, MTS400 = 0x85,MTS420 = 0x86
 *  msg->data[1] : packet id = 3
 *  msg->data[2] : node id
 *  msg->data[3] : parent
 *  msg->data[4,5] : battery ADC data
 *  msg->data[6,7] : humidity data
 *  msg->data[8,9] : temperature data
 *  msg->data[10,11] : cal_word1 
 *  msg->data[12,13] : cal_word2
 *  msg->data[14,15] : cal_word3
 *  msg->data[16,17] : cal_word4
 *  msg->data[18,19] : intersematemp
 *  msg->data[20,21] : pressure
 */
 
/* * PACKET #4 
 * ----------------
 *  msg->data[0] : sensor id, MTS400 = 0x85,MTS420 = 0x86
 *  msg->data[1] : packet id = 4
 *  msg->data[2] : node id
 *  msg->data[3] : parent
 *  msg->data[4,5] : taosch0
 *  msg->data[6,7] : taosch1
 *  msg->data[8,9] : accel_x
 *  msg->data[10,11] : accel_y 
 */


/* * PACKET #2 
 *  msg->data[0] : sensor board id, MTS400 = 0x85,MTS420 = 0x86
 *  msg->data[1] : packet id = 2
 *  msg->data[2] : node id
 *  msg->data[3] : parent
 *  msg->data[4] : Hours
 *  msg->data[5] : Minutes
 *  msg->data[6] : Latitude degrees
 *  msg->data[7] : Longitude degrees
 *  msg->data[8,9,10,11] : Decimal seconds
 *  msg->data[12,13,14,15] : Latitude decimal minutes
 *  msg->data[16,17,18,19] : Longitude decimal minutes
 *  msg->data[20] : NSEWind
 *  msg->data[21] : whether the packet is valid
 */

typedef struct Pmts400 {
  
 // packet 3 
  uint16_t vref;
  uint16_t humidity;
  uint16_t temp;
  uint16_t cal_word1;           //!< Pressure calibration word 1
  uint16_t cal_word2;           //!< Pressure calibration word 2
  uint16_t cal_word3;           //!< Pressure calibration word 3
  uint16_t cal_word4;           //!< Pressure calibration word 4
  uint16_t intersematemp;
  uint16_t intersemapressure;
  
  uint16_t taosch0;
  uint16_t taosch1;
  uint16_t accel_x;
  uint16_t accel_y;
 
} __attribute__ ((packed))Pmts400; 


typedef struct XDataMsg {
  XMeshHeader xmeshHeader;
  union {
     Pmts400    data6; //mts400
     }xData;
} __attribute__ ((packed))XDataMsg;

enum {
    BATT_TEMP_PORT = 7,             //adc port for battery voltage
};

enum {
    AM_XDEBUG_MSG    = 49,
    AM_XSENSOR_MSG   = 50,
    AM_XMULTIHOP_MSG = 51,         // xsensor multihop 
};

// Zero out the accelerometer, chrl@20061206
#define ACCEL_AVERAGE_POINTS 3

#ifdef APP_RATE
uint32_t XSENSOR_SAMPLE_RATE = APP_RATE;
#else
#ifdef USE_LOW_POWER
uint32_t XSENSOR_SAMPLE_RATE = 184320;
#else
uint32_t XSENSOR_SAMPLE_RATE = 7680;  // 7.5 sec
#endif
#endif

uint32_t timer_rate;

