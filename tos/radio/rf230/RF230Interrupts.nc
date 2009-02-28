/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: RF230Interrupts.nc,v 1.1.2.2 2007/04/27 05:01:56 njain Exp $
 */

 
interface RF230Interrupts {
	
	async command void enable();
	
	async command void disable();
	
	async void event INT_RX_Start();
	
	async void event INT_TRX_Done();
	
	async void event INT_TRX_UnderRun();
	
	async void event INT_PLL_Locked();
	
}
