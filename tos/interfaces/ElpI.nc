/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: ElpI.nc,v 1.1.4.1 2007/04/25 23:22:05 njain Exp $
 */

/**
 * Interface to control power management of an Extended Low Power mote.
 */
interface ElpI {

 /**
  * Put an Elp capable mote to sleep.
  *
  * @param duratin           The amount of time to put mote to sleep 
  * @param health_interval   Time between sending health packets (sec)
  * @param retries           Number of times to xmit health pkt and get an ack 
  */
  command result_t sleep (uint16_t duratin, uint16_t health_interval, 
			  uint8_t retries, uint8_t force_sleep);

  /** Event signaled everytime node wakes from Elp deep sleep interval. */
  event result_t sleep_done(result_t success);

  /** Wake node from Elp sleep cycling state into full power. */
  command result_t wake();

  /** Event signaled after node goes leaves Elp mode. */
  event result_t wake_done(result_t success);

  /** attempts to join the mesh, when called it:
   *  turn the radio on for up to rui*ROUTE_UPDATE_INTERVAL, attempt to find a parent
   *  if a parent is found, sends a health message (retries up to x times) requireing an end-end
   *  acknowledge from the base station
   */
  command result_t route_discover(uint8_t rui);
 
  /** Event returns after route_discover has either found a parent or timed out after the rui period. 
   *  If route_discover fails its up to the application to decide when to try route_discover again
   *  return value:
   *      SUCCESS: a parent is found
   *      FAIL: no parent is found
   */
  event result_t route_discover_done(result_t success, uint16_t parent);
}
