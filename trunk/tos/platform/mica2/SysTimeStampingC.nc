/*
 * Copyright (c) 2003, Vanderbilt University
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: SysTimeStampingC.nc,v 1.1.4.1 2007/04/26 00:17:20 njain Exp $
 */
 
/*
 * Author: Miklos Maroti
 * Date last modified: 12/05/03
 */

configuration SysTimeStampingC
{
	provides
	{
		interface TimeStamping;
#ifdef TIMESTAMPING_CALIBRATE
		command uint8_t getBitOffset();
#endif
	}
}

implementation
{
	components SysTimeStampingM, CC1000RadioIntM, SysTimeC;

	TimeStamping = SysTimeStampingM;
#ifdef TIMESTAMPING_CALIBRATE
	getBitOffset = SysTimeStampingM;
#endif

	SysTimeStampingM.RadioSendCoordinator	 -> CC1000RadioIntM.RadioSendCoordinator;
	SysTimeStampingM.RadioReceiveCoordinator -> CC1000RadioIntM.RadioReceiveCoordinator;
	SysTimeStampingM.SysTime		 -> SysTimeC;
}
