/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: WakeSequence.nc,v 1.1.2.2 2007/04/27 05:03:03 njain Exp $
 */

interface WakeSequence {
	
	/**
	 *  @brief send a single wake up packet
	 *
	 *	This procedure sends duration number of packets.  Please
	 *	use the predefined macros pretuned for this purpose.
	 *	This procedure is not a split phase operation.  It returns
	 *  only after the completion or failure to send the packet
	 *
	 *  @param duration		how long a wake sequence to send
	 *  @return result_t 	was the send successful
	 */
	async command result_t sendWake(uint16_t duration);

	/**
	 *  @brief the wake sequence is done sending
	 *
	 *  This event is signaled when the wake sequnence has completed sending.
	 */
	 async event void sendWakeDone(result_t succ);	
	
	/**
	 *  @brief monitor for incoming traffic for us units of time.
	 *
	 *  @param uss			micro seconds before expiring
	 *  @return result_t	was the set correct
	 */
	async command result_t startSniff(uint16_t us);
	
		
	/**
	 *	@brief receieved a single wakeup packet
	 *
	 *	Wake up packets are distinguished via packet length.  Potential race
	 *  with sniff expiration.  If sniff timer is set, it will stop the sniff.
	 */
	async event void IncomingPacket();
	

	/**
	 *  @brief sniff timer expired
	 *
	 *  Sniff expired.  potential race with receiveWake
	 */

	async event void sniffExpired(bool channelClear);

}
