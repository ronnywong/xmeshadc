/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: PressureSensor.h,v 1.2.4.1 2007/04/26 19:33:56 njain Exp $
 */

/* 
 * Author: Xin Yang (xyang@xbow.com)
 * Date:   11/05/05
 */
 
/**
 * PressureSensor.h - application specific defines
 *
 *
 * 
 * @author Xin Yang
 * @author Alan Broad
 * @date November 13 2005
 */

#ifndef PRESSURE_SENSOR__
#define PRESSURE_SENSOR__
 
#define BOARD_ID           0x62         //sensor board id
#define PKT_ID             1            //packet id


//XMesh elp constants
#define ELP_SLEEP      60           //time to sleep elp (sec),
#define ELP_SLEEP_MS   184320       //time between health pkts xmit (msec)
#define ELP_HINT       80           //time interval between health pkt (sec)
#define NUM_ROUTE_DISCOVER_INTS 3   //number of route update intervals to join mesh
#define ELP_RETRIES    5            // number of times to retry to get health pkt ack
#define HEALTH_XMIT    0            // xmit a health packet on elp sleep entry
#define NO_HEALTH_XMIT 1            // no xmit of health packet on elp sleep entry



#define  DEFAULT_SAMPLE_INTERVAL 	1024		//sample interval in terms of ms
#define  DEFAULT_SAMPLE_INTERVAL_SEC  1			//sample interval in terms of seconds
#define  WAIT_INTERVAL   50                     //# msec for sensor power up
#define  DEFAULT_CACHE_SAMPLES 20               //max samples
#endif
