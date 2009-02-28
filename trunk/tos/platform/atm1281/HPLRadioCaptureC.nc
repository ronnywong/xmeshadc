/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: HPLRadioCaptureC.nc,v 1.1.2.2 2007/04/26 00:05:35 njain Exp $
 */
 
configuration HPLRadioCaptureC {
	provides {
		interface TimerCapture;
	}
}

implementation {
	components HPLTimer1M;
	
	TimerCapture = HPLTimer1M.CaptureT1;
}
