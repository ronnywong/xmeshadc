/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: sensorboardApp.h,v 1.1.4.1 2007/04/26 20:35:02 njain Exp $
 */



typedef struct XSensorHeader{
  uint8_t  board_id;
  uint8_t  packet_id; // 3
  uint8_t  node_id;
  uint8_t  rsvd;
}__attribute__ ((packed)) XSensorHeader;


typedef struct PData1
{
  uint16_t seq_no;
  uint16_t vref;
  uint16_t  pir;         
  uint16_t humidity;
  uint16_t temperature;
  uint16_t cal_wrod1;
  uint16_t cal_wrod2;
  uint16_t cal_wrod3;
  uint16_t cal_wrod4;
  uint16_t intersematemp;
  uint16_t pressure;
  uint16_t accelx;
  uint16_t accely;
  uint16_t taoch0;
  uint16_t taoch1;
  uint16_t audio;           
  uint16_t adc5;
  uint16_t adc6;
} __attribute__ ((packed)) PData1;


// Sensor device settings
enum
{
	MIC_LPF				= 0,
	MIC_HPF				= 255,
	MIC_GAIN			= 3,
	MIC_DETECT_ADJUST		= 130,
};

enum {                                                                
  TOSH_ACTUAL_ADC5_PORT  = 5,                                          
  TOSH_ACTUAL_ADC6_PORT = 6,                                          
};                                                                    
                                                                      
enum {                                                                
  TOS_ADC5_PORT = 8,                                                  
  TOS_ADC6_PORT = 6,                                                  
};                                                                    

enum {
  AM_XSXMSG = 0,  
};

typedef struct XDataMsg {
  XSensorHeader xSensorHeader;
  union {
     PData1    data1;
  }xData;
} __attribute__ ((packed)) XDataMsg;



//=======================================PIR DETECT ====================================
// Window Detection: triggers on hi/lo PIR values. 
//                 : input to window detector is summed value of all PIRs
// PIR_DETECT_ADJUST: (see PIRBiasCalc.xls)
// Assuming 3.2V battery supply
//  Pot: ~Upr Thrsh(v): ~Lwr T(v):  Upr Adc: Lwr Adc:
//  0        1.60          1.6       512      512
//  48       2.11          1.09      675      348 
//  64       2.22          0.98      708      315
//  80       2.30          0.90      736      287
//  96       2.37          0.83      759      264
//  128      2.49          0.71      796      227
// PIR_THRESHOLD is UprAdc value corresponding to PIR_DETECT_ADJUST                
#define PIR_DETECT_ADJUST	255
#define PIR_THRESHOLD     736                  
//
//
// PIR alg detection parameters used after a window detect event to track
//   an event
// PIR_MIN         : min thresh for pir, a/d counts (0..1023)
// PIR_MAX         : max thresh for pir, a/d counts (0..1023)
// PIR_SAMPLE_TIME : msec between PIR tracking checks
// PIR_CNT_MAX     : PIR_CNT_MAX*PIR_SAMPLE_TIME = max time to chk pir ovr
// PIR_TRAN_TRESH  : Require this number of zero crossings before declaring an event
#define PIR_MIN          430
#define PIR_MAX          600
#define PIR_SAMPLE_TIME  50
#define PIR_CNT_MAX      75
#define PIR_TRAN_THRESH  4
//
#define DETECT_MIC      1
#define DETECT_PIR	2

#define DETECT_INTERVAL	200
#define DETECT_CNT	20
#define TRIGGER_CNT	10
#define SET_PARAM	1

// States used to track PIR signal
enum{
PIR_IDLE    =0,
PIR_MONITOR =1,
};

enum {
    AM_XDEBUG_MSG    = 49,
    AM_XSENSOR_MSG   = 50,
    AM_XMULTIHOP_MSG = 51,         // xsensor multihop 
};

    uint32_t   timer_rate;  


