/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: SODbug.nc,v 1.1.4.1 2007/04/26 19:32:50 njain Exp $
 */

 
 //#define NO_LEDS 
 
 configuration SODbug { }
 
 implementation {
	 
/*=== Components ============================================================*/

	components Main,
				TimerC,
				LedsC, NoLeds,
				SODbugM;
				
	Main.StdControl -> SODbugM;
	SODbugM.TimerControl -> TimerC.StdControl;
	SODbugM.UpdateTimer -> TimerC.Timer[unique("Timer")];

	#ifdef NO_LEDS
		SODbugM.Leds -> NoLeds;
	#else
		SODbugM.Leds -> LedsC;
	#endif
 }
