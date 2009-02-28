/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2004 SenseTech Software / Crossbow Technology Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: MicIntM.nc,v 1.1.4.1 2007/04/27 05:27:17 njain Exp $
 */
 
/******************************************************************************
 *
 *	Mobile Pipeline Intrusion Detection System (MPIDS)
 *
 *	Authors:	Tim Reilly
 *
 *****************************************************************************/
 
/**
 * Interrupt driven microphone sensor implementation module
 * 
 * @modified  8/18/04
 *
 * @author Tim Reilly
 */
module MicIntM
{
	provides 
	{
		interface StdControl;
		interface Interrupt;
		interface Sample;
	}
	
	uses 
	{
		interface Mic;
		interface ADC;
		interface IntOutput;
		interface StdControl as MicControl;
	}
}

#define MIC_INT_ENABLE()  sbi(EIMSK,5)
#define MIC_INT_DISABLE() cbi(EIMSK,5)

implementation
{
	uint16_t adc = 0;		// last adc reading	
	bool enabled = FALSE;	// interrupt currently enabled
	
	/**
	 * Initialize components.
	 *
	 * @return SUCCESS
	 */
	command result_t StdControl.init() 
	{
		MIC_INT_DISABLE();
		call MicControl.init();

		return SUCCESS;
	}

	/**
	 * Start components.
	 *
	 * @return SUCCESS
	 */
	command result_t StdControl.start() 
	{
		// Start sensor device but don't enable interrupt
		call MicControl.start();
		call Mic.MicOn();
		
		return SUCCESS;
	}

	/**
	 * Stop components.
	 *
	 * @return SUCCESS
	 */
	command result_t StdControl.stop() 
	{
		MIC_INT_DISABLE();
		call Mic.MicOff();
		call MicControl.stop();
		
		return SUCCESS;
	}

	/**
	 * Event signaled when client has processed latest sample.
	 * 
	 * @param success SUCCESS if no errors during processing.
	 * @return SUCCESS
	 */
	event result_t IntOutput.outputComplete(result_t success)
	{
		if (enabled)
		{
			TOSH_uwait(100); 
			MIC_INT_ENABLE();
		}
		
		return SUCCESS;
	}
	
	/**
	 * Task used to send latest sample to client.
	 */
	task void HandleADCTask()
	{
		uint16_t tmp;
		
		atomic
		{
			tmp = adc;
		}

		call IntOutput.output(tmp);
	}
	
	/**
	 * Event signaled when client adc port is finished sampling.
	 * 
	 * @param data Latest sample from ADC port.
	 * @return SUCCESS
	 */
    async event result_t ADC.dataReady(uint16_t data)
    {
		atomic
		{
			adc = data;
		}
        post HandleADCTask();

		return SUCCESS;
    }
		
	/**
	 * Command used by client to demand a fresh sensor sample.
	 * 
	 * @return SUCCESS
	 */
	command result_t Sample.sampleNow()
	{
        call ADC.getData();

		return SUCCESS;
	}
	
	/**
	 * Task used to sample ADC port in response to device interrupt.
	 */
	task void HandleInterruptTask()
	{
        call ADC.getData();
	}
	
	/**
	 * Command used by client to enable sensor device interrupt.
	 * 
	 * @return SUCCESS
	 */
	command result_t Interrupt.enable()
	{
		MIC_INT_ENABLE();
		enabled = TRUE;
		
		return SUCCESS;
	}
	
	/**
	 * Command used by client to disable sensor device interrupt.
	 * 
	 * @return SUCCESS
	 */
	command result_t Interrupt.disable()
	{
		MIC_INT_DISABLE();
		enabled = FALSE;
		
		return SUCCESS;
	}
	
	/**
	 * Interrupt service routine.
	 */
	TOSH_SIGNAL(SIG_INTERRUPT5)
	{
		MIC_INT_DISABLE();
		
		post HandleInterruptTask();
	}
}
