/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: sensorboardApp.h,v 1.2.4.3 2007/04/26 20:23:53 njain Exp $
 */


#define  SENSOR_BOARD_ID    0x2  

// controls for the voltage reference monitor
#define MAKE_BAT_MONITOR_OUTPUT() sbi(DDRC, 7)
#define MAKE_ADC_INPUT() cbi(DDRF, 1)
#define SET_BAT_MONITOR() cbi(PORTC, 7)
#define CLEAR_BAT_MONITOR() sbi(PORTC, 7)
//controls for the thermistor sensor
#define MAKE_THERM_OUTPUT() sbi(DDRC,6)
#define SET_THERM_POWER() cbi(PORTC,6)
#define CLEAR_THERM_POWER() sbi(PORTC,6)


typedef struct XMeshHeader{
  uint8_t  board_id;
  uint8_t  packet_id; // 3
  //uint8_t  node_id;
  uint16_t parent;
}__attribute__ ((packed)) XMeshHeader;

typedef struct PData1 {
  uint16_t  vref;
  uint16_t thermistor;
  uint16_t light;
  uint16_t accelX;
  uint16_t accelY;
  uint16_t sound[5];
} __attribute__ ((packed)) PData1;

typedef struct XDataMsg {
  XMeshHeader xMeshHeader;
  union {
  PData1    datap1;
  }xData;

} __attribute__ ((packed)) XDataMsg;

enum {
    BATT_TEMP_PORT = 1,             //adc port for battery voltage
};

enum {
	TEMP_ADC_PORT = 9
};

enum {
  AM_XSXMSG = 0,
  
};


enum {
    AM_XDEBUG_MSG    = 49,
    AM_XSENSOR_MSG   = 50,
    AM_XMULTIHOP_MSG = 51         // xsensor multihop 
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
