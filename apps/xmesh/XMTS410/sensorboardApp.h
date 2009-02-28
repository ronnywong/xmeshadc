/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: sensorboardApp.h,v 1.3.2.12 2007/04/26 20:20:17 njain Exp $
 */

#define XSENSOR_XMTS410_PACKET_20D 2
#define XSENSOR_XMTS410_PACKET_20E 3
#define PIR_WINDOW_SIZE 10

typedef struct XMeshHeader{
  uint8_t  board_id;
  uint8_t  packet_id; // 3
  //uint8_t  node_id;
  uint16_t parent;
}__attribute__ ((packed)) XMeshHeader;


typedef struct PData1
{
  uint16_t seq_no;
  uint16_t vref;
  uint8_t pir;
  uint8_t pir_sum;
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
  uint16_t pir_max;
} __attribute__ ((packed)) PData1;

typedef struct PirInfo
{
  uint16_t  pir_bias;
  uint16_t  pir_threshold;
  uint16_t  pir_N;
  uint16_t  pir_T;
//  uint16_t  vref;
} __attribute__ ((packed)) PirInfo;

// Sensor device settings
enum
{
	MIC_LPF				= 0,
	MIC_HPF				= 255,
	MIC_GAIN			= 30,
	MIC_DETECT_ADJUST	= 133,
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
  XMeshHeader xMeshHeader;
  union {
     PData1    data1;
     PirInfo   pirInfo;
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
#define PIR_DETECT_ADJUST	107
#define PIR_DEF_ADJUST_THRESHOLD 107

// 20061229 chrl
#define PIR_MONITOR_TIMER   2000	// monitor period after a interrupt
#define PIR_VALID_CNT       3     // trigerr number
#define PIR_DEF_BIAS        512   // ADC value
#define PIR_DEF_THRESHOLD   120   // ADC threshold
#define STANDARD_VREF       0x1A1 // 3003mv
#define UPPER_VREF          0x165 // 3507mv
#define LOWER_VREF          0x1F5 // 2500mv
#define RE_ADJUST_INTERVAL  44236800u   // 12 hours@millisec

// Zero out the accelerometer, chrl@20061207
#define ACCEL_AVERAGE_POINTS 3

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
uint32_t XSENSOR_SAMPLE_RATE = 8843;
#endif
#endif

    uint32_t   timer_rate;


