/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: sensorboardApp.h,v 1.1.2.2 2007/04/26 20:35:48 njain Exp $
 */


#define MAKE_GPS_ENA_OUTPUT() sbi(DDRE,8)//6)
#define SET_GPS_ENA() cbi(PORTE,8)//6)
#define CLR_GPS_ENA() sbi(PORTE,8)//6)

#define GPS_MSG_LENGTH 100
#define GPS_CHAR 11
#define GGA_FIELDS 8
#define GPS_CHAR_PER_FIELD 10
#define GPS_DELIMITER ','
#define GPS_END_MSG '*'

#define GPS_MAX_WAIT 5             // max wait time for gps packet = GPS_MAX_WAIT*TIMER_PERIOD
#define FIRST_WORK_FACTOR 8
#define NORMAL_WORK_FACTOR 1
// REAL_SLEEP_TIME(ms) = SLEEP_INTERVAL * gps_work_factor * TIMER_PERIOD, gps_work_factor = 0,NORMAL_WORK_FACTOR
#define GPS_SLEEP_INTERVAL 150
// REAL_WORK_TIME(ms) = WORK_INTERVAL * gps_work_factor * TIMER_PERIOD, gps_work_factor = FIRST_WORK_FACTOR,NORMAL_WORK_FACTOR
#define GPS_WORK_INTERVAL 30


typedef struct XSensorHeader
{
	uint8_t  board_id;
	uint8_t  packet_id; // 3
	uint8_t  node_id;
	uint8_t  rsvd;
}__attribute__ ((packed)) XSensorHeader;

typedef struct GGAMsg
{
	uint8_t  hour;
	uint8_t  minute;
	uint8_t  lat_deg;
	uint8_t  long_deg;
	uint32_t dec_sec;
	uint32_t lat_dec_min;
	uint32_t long_dec_min;
	uint8_t  nsewind;
	uint8_t  fixed;
//	uint8_t  SVs;
} __attribute__ ((packed)) GGAMsg;

typedef struct XSensorMTS400DataMsg
{
	uint16_t vref;
	uint16_t humidity;
	uint16_t temperature;
	uint16_t cal_word1;
	uint16_t cal_word2;
	uint16_t cal_word3;
	uint16_t cal_word4;
	uint16_t intersematemp;
	uint16_t pressure;
	uint16_t taoch0;
	uint16_t taoch1;
	uint16_t accel_x;
	uint16_t accel_y;
} __attribute__ ((packed)) XSensorMTS400DataMsg;


typedef struct EEPROMData 
{
	uint8_t  EEPROMData[10];
} __attribute__ ((packed)) EEPROMData;

enum 
{
	AM_XSXMSG = 0,  
};

typedef struct XDataMsg 
{
  XSensorHeader xSensorHeader;
  union 
  {
     XSensorMTS400DataMsg    data1;
     GGAMsg    	dataGps;
	 EEPROMData dataE2prom;
  }xData;
} __attribute__ ((packed)) XDataMsg;

