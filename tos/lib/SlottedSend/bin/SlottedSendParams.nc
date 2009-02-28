/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: SlottedSendParams.nc,v 1.1.4.1 2007/04/25 23:39:34 njain Exp $
 */

/*
 * Author: Xin Yang (xyang@xbow.com)
 * Date:   11/05/05
 */

/**
 * SlottedSendParam.nc - Slotted Send configuration interface
 *
 * Interface for configuring options in the slotted send module
 *
 * <pre>
 *	$Id: SlottedSendParams.nc,v 1.1.4.1 2007/04/25 23:39:34 njain Exp $
 * </pre>
 * 
 * @author Xin Yang 
 * @date November 13 2005
 */


interface SlottedSendParams {
	
  // Gets the power mode of the slotted send strategy
  command result_t setPowerMode(uint8_t mode);
  command uint8_t getPowerMode();
	
  // Period in ms of how long node sleeps
  command result_t setSleepPeriod(uint32_t ms);
  command uint32_t getSleepPeriod();
	
  // Period in ms of sub intervals that nodes stay up during each sleep invterval
  // This occurs only if there is more than one packet that is sent per interval
  command result_t setSubInterval(uint16_t ms);
  command uint16_t getSubInterval();
	
  // Set threshold in ms for which nodes remain awake if kept on beyond threshold.
  command result_t setThreshold(uint16_t ms);
  command uint16_t getThreshold();
}

