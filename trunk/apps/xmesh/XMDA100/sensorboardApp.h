/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: sensorboardApp.h,v 1.2.4.1 2007/04/26 20:06:52 njain Exp $
 */

/* sensorboard.h - hardware specific definitions for the MTS101 
*/

// crossbow sensor board id
#define  SENSOR_BOARD_ID 0x91               //MTS101 sensor board id


typedef struct XMeshHeader{
  uint8_t  board_id;
  uint8_t  packet_id; // 3
  //uint8_t  node_id; // 3
  uint16_t parent;
}__attribute__ ((packed)) XMeshHeader;

typedef struct PData1 {
  uint16_t vref;
  uint16_t thermistor;
  uint16_t photo;
  uint16_t adc2;
  uint16_t adc3;
  uint16_t adc4;
  uint16_t adc5;
  uint16_t adc6;
} __attribute__ ((packed)) PData1;

typedef struct XDataMsg {
  XMeshHeader xMeshHeader;
  union {
  PData1    datap1;
  }xData;
} __attribute__ ((packed)) XDataMsg;

enum {
  AM_XSXMSG = 0,
  
};

enum {                                                                
                                  
  TOSH_ACTUAL_ADC2_PORT = 2,                                          
  TOSH_ACTUAL_ADC3_PORT = 3,                                          
  TOSH_ACTUAL_ADC4_PORT = 4,                                          
  TOSH_ACTUAL_ADC6_PORT = 6,                                          
  TOSH_ACTUAL_ADC5_PORT  = 5                                          
};                                                                    
                                                                      
enum {                                                                
                                    
  TOS_ADC2_PORT = 3,                                                  
  TOS_ADC3_PORT = 4,                                                  
  TOS_ADC4_PORT = 5,                                                  
  TOS_ADC6_PORT = 6,                                                  
  // TOS_ADC_VOLTAGE_PORT = 7,  defined this in hardware.h            
  TOS_ADC5_PORT = 8,                                                  
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

