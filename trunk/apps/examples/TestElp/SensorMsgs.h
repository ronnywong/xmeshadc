/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: SensorMsgs.h,v 1.2.4.1 2007/04/26 19:34:21 njain Exp $
 */

/* 
 * Author: Xin Yang (xyang@xbow.com)
 * Date:   11/05/05
 */
 
/**
 * SensorMsgs.h - Structure for Pressure Sensor Msgs
 *
 *
 * @author Xin Yang
 * @author Alan Broad
 * @date November 13 2005
 */

 
 /**
  *	 WARNING:
  *	 It is acceptable to use this AM as an XMesh application Level AM.
  *	 Applications using XMESH must not wire direcly into Generic Comm
  *  with this AM.
  */

#include "PressureSensor.h"
     
enum {
	AM_PRESSURE = 71,		//0x47
	PRESSURE_SENSOR_CHANNEL	= 5
};

typedef struct pressureMsg {
  uint8_t   Board_id;                         //Sensor board id
  uint8_t   Pkt_id;                           //Sensor board packet id
  uint16_t  Parent_id;                        //XMesh parent id
  uint8_t   Sample_period;                    //sampling period of sensor
  uint8_t   NmbSamples;                       //nmb of actual sensor readings
  uint16_t  SensorCount[DEFAULT_CACHE_SAMPLES];   //nmb of sensor readings
} __attribute__ ((packed)) pressureMsg;
