/*
 * Copyright (c) 2003, Vanderbilt University
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: SysTimeC.nc,v 1.1.4.1 2007/04/26 00:17:01 njain Exp $
 */

configuration SysTimeC
{
	provides
	{
		interface SysTime;
	}
}

implementation 
{
	components Main, SysTimeM;

	SysTime	= SysTimeM;

	Main.StdControl -> SysTimeM;
}
