/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2004 SenseTech Software / Crossbow Technology Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: MicIntC.nc,v 1.1.4.1 2007/04/27 05:27:08 njain Exp $
 */
 
/******************************************************************************
 *
 *	Mobile Pipeline Intrusion Detection System (MPIDS)
 *
 *	Authors:	Tim Reilly
 *
 *****************************************************************************/
 
/**
 * Interrupt driven microphone sensor configuration
 * 
 * @modified  8/18/04
 *
 * @author Tim Reilly
 */
configuration MicIntC
{ 
	provides
	{
		interface Mic;
		interface StdControl;
		interface Interrupt;
		interface Sample;
	}
	
	uses
	{
		interface IntOutput;
	}
}

implementation
{

	components	MicIntM,
				MicC;
				
	MicIntM.Mic -> MicC;
	MicIntM.ADC -> MicC.MicADC;
	MicIntM.MicControl -> MicC;

	Mic = MicC;
	StdControl = MicIntM;
	Interrupt = MicIntM;
	Sample = MicIntM;
	MicIntM.IntOutput = IntOutput;
}

