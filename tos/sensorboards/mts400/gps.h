/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: gps.h,v 1.1.4.1 2007/04/27 05:42:45 njain Exp $
 */


#ifndef XBOW_GPS_H
#define XBOW_GPS_H

#define GPS_DATA_LENGTH  128
#define GPS_PACKET_START 0x24            //start of gps packet
#define GPS_PACKET_END1  0x0D            //end if gps packet
#define GPS_PACKET_END2  0x0A            //end of gps packet

typedef struct GPS_Msg
{
  /* The following fields are received on the gps. */
  uint8_t length;
  int8_t data[GPS_DATA_LENGTH];
  uint16_t crc;
} GPS_Msg;
typedef GPS_Msg *GPS_MsgPtr;

#endif /* XBOW_GPS_H */

