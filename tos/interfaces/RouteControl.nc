/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: RouteControl.nc,v 1.1.4.1 2007/04/25 23:29:18 njain Exp $
 */
 
/*
 * Authors:	Phil Buonadonna
 * Rev:		$Id: RouteControl.nc,v 1.1.4.1 2007/04/25 23:29:18 njain Exp $
 */

/** 
 * Control/Monitor interface to a routing component 
 * @author Phil Buonadonna
 */

interface RouteControl {

  /**
   * Get this node's present parent address.
   * 
   * @return The address of the parent
   */
  command uint16_t getParent();

  /** 
   * Get this node's depth in the network
   * 
   * @return The network depth.
   */
  command uint8_t getDepth();

  /**
   * Get the previous hop sender for the given TOS_Msg
   *
   * @param A pointer to the TOS_Msg of interest
   *
   * @return The address of the sender.
   */
  command uint16_t getSender(TOS_MsgPtr msg);

  /**
   * Return length of the routing forwarding queue 
   *
   * @return The number of outstanding entries in the queue.
   */
  command uint8_t getOccupancy();

  /**
   * Get a measure of goodness for the current parent 
   * 
   * @return A value between 0-256 where 256 represent the best
   * goodness
   * type=1: sendEst
   * type=2: receiveEst
   */
  command uint8_t getQuality(uint8_t type);

  /** 
   * Set the routing componenets internal update interval.
   *
   * @param The duration, in seconds, of successive routing
   * updates.
   * 
   * @return SUCCESS if the operation succeeded.
   */
  command result_t setUpdateInterval(uint16_t Interval);

  /**
   * Queue a manual update of the routing state.  This may or may
   * not include the transmission of a message.
   *
   * @return SUCCESS if a route update was queued.
   */
  command result_t manualUpdate();

}
