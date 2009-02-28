/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: PressureSensor.h,v 1.1.4.1 2007/04/26 19:33:19 njain Exp $
 */

/* 
 * Author: Xin Yang (xyang@xbow.com)
 * Date:   11/05/05
 */
 
/**
 * PressureSensor.h - application specific defines
 *
 *
 * <pre>
 *	$Id: PressureSensor.h,v 1.1.4.1 2007/04/26 19:33:19 njain Exp $
 * </pre>

 * 
 * @author Xin Yang
 * @author Alan Broad
 * @date November 13 2005
 */

#ifndef PRESSURE_SENSOR__
#define PRESSURE_SENSOR__
 
//XMesh elp constants
#define ELP_SLEEP      2000         //time to sleep elp (sec),
#define ELP_HINT       20           //time interval between health pkt (sec)
#define NUM_ROUTE_DISCOVER_INTS 3   //number of route update intervals to join mesh
#define ELP_RETRIES    5            // number of times to retry to get health pkt ack
#define HEALTH_XMIT    0            // Xmit a elp health pkt
#define NO_HEALTH_XMIT 1            // Don't Xmit a elp health pkt

#endif
