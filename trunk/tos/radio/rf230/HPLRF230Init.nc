/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: HPLRF230Init.nc,v 1.1.2.2 2007/04/27 05:01:06 njain Exp $
 */

interface HPLRF230Init {
	/**
	 *	initialize the spi port for communcating with rf230
	 *  initialize pin directions for GPIO pins
	 */
	async command void init();

}
