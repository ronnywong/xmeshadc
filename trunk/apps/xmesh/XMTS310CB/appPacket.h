/**
 * Definition of complete and final packet structure for this application.
 *
 * @file       appPacket.h
 * @author     Martin Turon
 *
 * @version    2005/9/26         mturon          Initial version
 *
 * These structure definitions are used by mig to auto-generate XML packet 
 * descriptions for parsing by tools such as XServe 2.0.  
 *
 * Usage:        mig xserve appPacket.h AppPacket
 *
 * $Id: appPacket.h,v 1.1.2.1 2006/04/27 08:50:04 pipeng Exp $
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
