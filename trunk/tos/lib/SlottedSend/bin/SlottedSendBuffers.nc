/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: SlottedSendBuffers.nc,v 1.2.2.1 2007/04/25 23:39:09 njain Exp $
 */

/* 
 * Author: Xin Yang (xyang@xbow.com)
 * Date:   11/05/05
 */

/**
 * SlottedSendBuffers.nc - interface for accessing TOS_Msg buffers
 *
 * <pre>
 *	$Id: SlottedSendBuffers.nc,v 1.2.2.1 2007/04/25 23:39:09 njain Exp $
 * </pre>
 * 
 * @author Xin Yang 
 * @date November 13 2005
 */


interface SlottedSendBuffers {
	
	/**
	 * Get a ptr to a TOS_Msg.
	 *
	 * @param void
	 * @return TOS_MsgPtr to buffer
	 */
	async command TOS_MsgPtr getRxBuffer();
		
	/**
	 * Determines if a packet has a preamble AM type
	 *
	 * @param m			Ptr to msg to test
	 * @return bool 	result of test
	 */
	async command bool isPreamblePacket(TOS_MsgPtr m);
	
	/**
	 * Determines if a packet is a bcast packet.
	 *
	 * @param m			Ptr to msg to test
	 * @return bool		result of test
	 */
	async command bool isBcast(TOS_MsgPtr m);
	
	/**
	 * Configure a packet according to a Preamble packet payload
	 *
	 * @param m			Ptr to msg to configure
	 * @return void
	 */
	async command void configPacket(TOS_MsgPtr m);
	
}
