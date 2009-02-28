/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: sensorboardApp.h,v 1.1.4.1 2007/04/26 20:24:39 njain Exp $
 */


/*
 * @file     XMeshBase/sensorboardApp.h
 * @date     September 7, 2005
 * @author   Martin Turon <mturon@xbow.com>
 *
 * @version    2005/9/7         mturon          Initial version
 */

// The base must handle the maximum packet size for any application
#define MSG_LEN  55
enum {
    AM_SURGEMSG = 17,
    AM_XDEBUG_MSG    = 49,
    AM_XSENSOR_MSG   = 50,
    AM_XMULTIHOP_MSG = 51,         // xsensor multihop
};

uint32_t   timer_rate;

