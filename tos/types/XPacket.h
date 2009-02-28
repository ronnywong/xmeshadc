/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: XPacket.h,v 1.2.2.1 2007/04/27 06:07:28 njain Exp $
 */

/**
 * Definition of just the header portion of the standard packet structure.
 *
 * @file       XPacket.h
 * @author     Martin Turon
 *
 * @version    2005/9/26         mturon          Initial version
 *
 * These structure definitions are used by mig to auto-generate XML packet 
 * descriptions for parsing by tools such as XServe 2.0.  
 *
 */

#ifndef __XPACKET_H__
#define __XPACKET_H__

typedef struct TosHeader_s
{
  uint16_t addr;
  uint8_t  type;
  uint8_t  group;
  uint8_t  length;
} __attribute__ ((packed)) TosHeader_t;

typedef struct XMeshHeader_s {
  uint16_t dest_id;		//!< Node that last sent this message.
  uint16_t node_id;		//!< Node that owns message (source or final destination).
  int16_t  seqno;		//!< XMesh sequence number for link estimation.
  uint8_t  app_id;		//!< Application identifier, or "socket" port.
} __attribute__ ((packed)) XMeshHeader_t;

#endif

