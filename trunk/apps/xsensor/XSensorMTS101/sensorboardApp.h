/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: sensorboardApp.h,v 1.1.4.1 2007/04/26 20:31:58 njain Exp $
 */

/* sensorboard.h - hardware specific definitions for the MTS101 
*/

// crossbow sensor board id
#define  SENSOR_BOARD_ID 0x82               //MTS101 sensor board id

typedef struct XSensorHeader{
  uint8_t  board_id;
  uint8_t  packet_id; // 3
  uint8_t  node_id;
  uint8_t  rsvd;
}__attribute__ ((packed)) XSensorHeader;

typedef struct PData1 {
  uint16_t vref;
  uint16_t thermistor;
  uint16_t photo;
  uint16_t adc0;
  uint16_t adc1;
  uint16_t adc2;
  uint16_t adc3;
  uint16_t adc4;
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

enum {
  TOSH_ACTUAL_MIC_PORT = 2, 
  TOSH_ACTUAL_ACCEL_X_PORT = 3, 
  TOSH_ACTUAL_ACCEL_Y_PORT = 4, 
  TOSH_ACTUAL_MAG_X_PORT = 6, 
  TOSH_ACTUAL_MAG_Y_PORT  = 5
};

enum {
  TOS_ADC_MIC_PORT = 3,
  TOS_ADC_ACCEL_X_PORT = 4,
  TOS_ADC_ACCEL_Y_PORT = 5,
  TOS_ADC_MAG_X_PORT = 6,
  // TOS_ADC_VOLTAGE_PORT = 7,  defined this in hardware.h
  TOS_ADC_MAG_Y_PORT = 8,
};

enum {
  TOS_MAG_POT_ADDR = 0,
  TOS_MIC_POT_ADDR = 1
};

TOSH_ALIAS_PIN(TONE_DECODE_SIGNAL, INT3);

TOSH_ALIAS_OUTPUT_ONLY_PIN(MIC_CTL, PW3);
TOSH_ALIAS_OUTPUT_ONLY_PIN(SOUNDER_CTL, PW2);
TOSH_ALIAS_OUTPUT_ONLY_PIN(ACCEL_CTL, PW4);
TOSH_ALIAS_OUTPUT_ONLY_PIN(MAG_CTL, PW5);
TOSH_ALIAS_OUTPUT_ONLY_PIN(MIC_MUX_SEL, PW6);


