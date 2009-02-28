/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: Ping.nc,v 1.1.4.1 2007/04/25 23:27:13 njain Exp $
 */
 
/*
 * Authors:		Nelson Lee
 * Date last modified:  7/1/02
 *
 *
 */

/*
 * This flow diagram shows the steps of the command and events defined in this interface:
 *
 *   Mote 11                                 Mote 2
 *     |                                       |
 *  send(2, 12)                                |
 *     |                                  pingReceive(11, 12)
 *  pingResponse(2, 12)                        |
 *     |                                       |
 *    \_/                                     \_/
 */     

/**
 * The Ping interface
 * @author Nelson Lee
 */ 
interface Ping
{
  /// function that sends a ping to another mote
  command result_t send(uint16_t moteID, uint8_t sequence);

  /// event signaled when a mote receives a message to a ping it previously sent
  event result_t pingResponse(uint16_t moteID, uint8_t sequence);

  /// event signaled when a mote receives a ping from another mote; the response to the pinger is sent before this is signaled
  event result_t pingReceive(uint16_t moteID, uint8_t sequence);
}










