/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: HPLRF230C.nc,v 1.1.2.2 2007/04/27 05:00:58 njain Exp $
 */
 
configuration HPLRF230C {
	provides {
		interface HPLRF230Init;
		interface HPLRF230;
	}	
}

implementation {
	components HPLRF230M;
	
	HPLRF230Init = HPLRF230M;
	HPLRF230 =  HPLRF230M;
}
