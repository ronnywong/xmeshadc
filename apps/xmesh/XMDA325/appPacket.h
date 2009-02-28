/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: appPacket.h,v 1.1.4.1 2007/04/26 20:10:21 njain Exp $
 */

#ifndef __APP_PACKET_H__
#define __APP_PACKET_H__

#include "XPacket.h"
#include "sensorboardApp.h"

enum { AM_APPPACKET = AM_XMULTIHOP_MSG };

typedef struct AppPacket {
    TosHeader_t    am;
    XMeshHeader_t  xmesh;
    XDataMsg       data;
} AppPacket;


#endif
