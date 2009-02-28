/*
 * Copyright (c) 2003, Vanderbilt University
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: SysTime.nc,v 1.1.4.1 2007/04/25 23:31:07 njain Exp $
 */
 
/*
 * Author: Miklos Maroti
 * Date last modified: 12/07/03
 */

/** 
 * This interface provides access to a free-running CPU timer that is 
 * started at startup. The current value of this timer is NOT supposed
 * to be changed. On the MICA2 platform the current implementation 
 * uses a 1/8 prescaler that results in a 921.6 KHz clock frequency.
 */
interface SysTime
{
	/**
	 * This method returns the lower 16 bits of the current time.
	 * The overhead of this method is absolutely negligible (this
	 * is a simple register read).
	 */
	async command uint16_t getTime16();

	/**
	 * This method returns the current time. This method has a very 
	 * little overhead and preferable to the getTime16() method if
	 * space is not of concern.
	 */
	async command uint32_t getTime32();

	/**
	 * Returns the closest 32-bit time (either in the future or in the 
	 * past, symmetrically) whose lower 16-bit is the supplied argument.
	 */
	async command uint32_t castTime16(uint16_t time16);
}
