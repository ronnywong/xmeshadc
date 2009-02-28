/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: sensorboardApp.h,v 1.1.4.1 2007/04/26 20:14:59 njain Exp $
 */

/* sensorboard.h - hardware specific definitions for the MSP410
*/

// crossbow sensor board id
#define SENSOR_BOARD_ID  0xA0         //xsm board id for xlisten


typedef struct XMeshHeader{
  uint8_t  board_id;
  uint8_t  packet_id; // 3
  //uint8_t  node_id; // 3
  uint16_t parent;
}__attribute__ ((packed)) XMeshHeader;

typedef struct PData1 {
   uint16_t seq_no; 
   uint8_t  batt;       
   uint8_t quadrant;            //4 bit binary value indicating which pir quadrant has fired:
                              // xxx1 => quadrant 1 has fired
                              // xx1x => quadrant 2 has fired
                              // x1xx => quadrant 3 has fired
                              // 1xxx => quadrant 4 has fired
                              // note- multiple quadrants can fire simultenously
                              // note- quadrant orienation relative to physical XSM unit not defined yet
                              // note - 0000 => no pir detect

   uint16_t pir;    //10 bit; pir magnitude over threshold
                              // = pir(adc)-pir(detect_threshold)
                              // note:  0 => no pir detect

   uint16_t  mag;   //10 bit; magnetometer magnitude over threshold
                              // = mag(adc)-mag(detect_threshold)
                              // note: 0=> no magnetometer detct

   uint16_t  audio;    //10 bit; audio magnitude over threshold
                                 // = audi(adc)-audio(detect_threshold)
                                 // not presently used
                                 // note: 0=> no audio detect

   uint16_t pirThreshold;      // base line window detect value for pir
                                 // reference value only
   uint16_t magThreshold;      //base line detect value for mag
                                 //reference value only
   uint16_t audioThreshold;   //base detect value for audio
                                //ref value only                         
   uint8_t  terminator;      
} __attribute__ ((packed)) PData1;

typedef struct XDataMsg {
  XMeshHeader xMeshHeader;
  union {
  PData1    datap1;
  }xData;
} __attribute__ ((packed)) XDataMsg;

#ifdef TIM_CODE
typedef struct _DetectionMessage
{
	uint8_t		nodeId;				// mote address
	uint8_t		serialNumber[8];	// unique mote serial number
	uint8_t		quadrant;			// PIR detectin quadrant
	uint16_t	pir;				// PIR sample value
	int16_t		mag;				// Magnetometer sample value
	uint16_t	audio;				// Microphone sample value
	uint16_t	pirThreshold;		// PIR detection threshold
	uint16_t	magThreshold;		// Manetometer detection threshold
	uint16_t	audioThreshold;		// Microphone detection threshold
} DetectionMessage __attribute__((packed));
#endif

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


#define TOS_ADC_BG_PORT  9            //if use BAND_GAP port ADCREFM intercepts and kills
#define BATTERY_CONVERT  12595        //conversion constant to compute battery volts in 100mv units
//timer settings
enum{
  START_TIME = 10,                         //time for everything to start
  POWERON_TIME		= 15*1024,	// 5 seconds
  SAMPLING_TIME	= 512,		// 0.5 second
  HB_TIME  = 500,      // 500 msec for heartbeat fires 
};

// Message xmit control parameters 
//#define 	RADIO_POWER		0x01      //radio control power
#define HB_MAX_CNT  60          //xmit heart beat  msg every HB_TIME/1000 * HB_MAX_CNT
#define MAX_DEAD_TIME_CNT 8     //max rate to xmit sensor trigger msgs HB_TIME/1000 * MAX_DEAD_TIME_CNT

//=======================================MAG DETECT ====================================
#define MAG_THRESHOLD	 100    // trigger threshold of mag value over average bias value
#define MAX_MAGS_TRIG  12    // # if times to see incrementing abs,mag delta values before trg 
#define MAG_THRESH_INC 1     // required delta increase for each trigger seq
#define MAG_MW_SIZE    64    // size of mag moving window averagers
#define MAG_LP_SIZE    16    // size of low pass averager window
#define MAG_XY_SIZE    16     // number of samples to track x-y and x+y correlation

// Trigger thresholds

//   Nov 19,2004 ~20' car detect 
//#define MAG_DIFFSUM_THRESH 750    
//#define MAG_DIFFDIFF_THRESH 550      

// Car detect at >20' but some false detects, Nov 30
//#define MAG_DIFFSUM_THRESH 400   
//#define MAG_DIFFDIFF_THRESH 300      


#define MAG_DIFFSUM_THRESH 500   
#define MAG_DIFFDIFF_THRESH 400      


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
#define PIR_DETECT_ADJUST	64
#define PIR_THRESHOLD     736                  
//
// Quad Detection: triggers on hi value of indivdual PIR detectors. 
//               : there is post gain amplification of x20 after
//                 quad detect before window detector.
// Pot:   Upr Thrsh(v):  Delta(mv) to fire (3.2 volt supply)
// 6         1.64          37
// 8         1.65          48
// 10        1.66          60
// 12        1.67          72
#define	PIR_QUAD_ADJUST		 10
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
// States used to track PIR signal
enum{
PIR_IDLE    =0,
PIR_MONITOR =1,
};


#define AUDIO_THRESHOLD	 1023

// Sensor device settings
enum
{
	MIC_LPF				= 0,
	MIC_HPF				= 255,
	MIC_GAIN			= 100,
	MIC_DETECT_ADJUST	= 255,
};

#ifndef BASE_STATION
#define 	BASE_STATION	 0 
#endif

// State machine
enum
{
	START,
	INITIALIZED,
	DETECTION,
	DETECTION_WINDOW,
	SAMPLING
};

// Detection trigger type
enum
{
	NONE,
	PIR_DETECT,
	AUDIO_DETECT,
	MAG_DETECT
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

