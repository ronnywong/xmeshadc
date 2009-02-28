/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: SlottedSendBuffersM.nc,v 1.2.2.1 2007/04/25 23:39:18 njain Exp $
 */

/* 
 * Author: Xin Yang (xyang@xbow.com)
 * Date:   11/05/05
 */

/**
 * SlottedSendBuffersM.nc - Implemenation of buffer pool for slotted send
 *
 * <pre>

 *	$Id: SlottedSendBuffersM.nc,v 1.2.2.1 2007/04/25 23:39:18 njain Exp $
 * </pre>
 * 
 * @author Xin Yang 
 * @date November 13 2005
 */
 
module SlottedSendBuffersM {
	provides interface SlottedSendBuffers as Buffers;
}

implementation {
	#include "SlottedSend.h"
	
/*===Module Variables =====================================================*/

	TOS_Msg RX_Msg;

/*===Acquire Buffer =======================================================*/
	
	/**
	 * Get a ptr to a TOS_Msg.
	 *
	 * @param void
	 * @return TOS_MsgPtr to buffer
	 */
	async command TOS_MsgPtr Buffers.getRxBuffer() {
		return &RX_Msg;
	}
	
/*===Query Buffer =========================================================*/

	/**
	 * Determines if a packet has a preamble AM type
	 *
	 * @param m			Ptr to msg to test
	 * @return bool 	result of test
	 */
	async command bool Buffers.isPreamblePacket(TOS_MsgPtr m) {
		return m->type == AM_PREAMBLE;
	}
	
	/**
	 * Determines if a packet is a bcast packet.
	 *
	 * @param m			Ptr to msg to test
	 * @return bool		result of test
	 */
	async command bool Buffers.isBcast(TOS_MsgPtr m) {
		return m->addr == TOS_BCAST_ADDR;
	}
	
/*===Configure Buffer =====================================================*/

	/**
	 * Configure a packet according to a Preamble packet payload
	 *
	 * @param m			Ptr to msg to configure
	 * @return void
	 */	

	async command void Buffers.configPacket(TOS_MsgPtr m) {
		m->length = PACKETLENGTH;
    	m->addr = TOS_BCAST_ADDR;
    	m->type = AM_PREAMBLE;
    	m->group = TOS_AM_GROUP;
	}
	
}
