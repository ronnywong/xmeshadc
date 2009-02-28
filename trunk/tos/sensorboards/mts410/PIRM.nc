/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: PIRM.nc,v 1.1.4.6 2007/04/27 05:46:00 njain Exp $
 */

/*
 *
 * Authors:  Mike Grimmer
 * Revision:		$Rev$
 *
 */

/****************************************************************************
 * I2C: the I2C on xsm is shared with magnetometers. There is no bus arbitration
 *      for this. Also, no parameterized interface.
 *      The I2CPot.writePotDone and I2CPot.readPotDone will connect back to both
 *      mag and pir. Since PIR thresholds are set just once, set these first.
 *      then enable the mags. bQuadAjust and bDetectAdjust are used to screen
 *      unwanted events from I2CPot
 *****************************************************************************/

includes sensorboard;
module PIRM 
{
  provides interface StdControl;
  provides interface PIR;
  uses 
  {
    interface ADCControl;
    interface ADC;
    interface StdControl as PotControl;
    interface I2CPot;
    interface Timer as SetTimer;
  }
}
implementation 
{
//#include "SODebug.h"
  bool bQuadAdjust;
  bool bDetectAdjust;
  uint16_t adc;
  uint8_t  detectval;
  uint8_t  flag;


  command result_t StdControl.init() 
  {
    bDetectAdjust = FALSE;
    call ADCControl.bindPort(TOS_ADC_PIR_PORT, TOSH_ACTUAL_PIR_PORT);
    
    TOSH_SET_PIR_CTL_PIN();
    TOSH_SET_INT7_PIN();
    call ADCControl.init();
    call PotControl.init();
    flag=0;
    cbi(EIMSK,7);
    cbi(EICRB,ISC70);
    sbi(EICRB,ISC71);
    return SUCCESS;
  }

  command result_t StdControl.start() 
  {
    call PotControl.start();
    TOSH_CLR_PIR_CTL_PIN();
    return SUCCESS;
  }

  command result_t StdControl.stop() 
  {
    call PotControl.stop();
    TOSH_SET_PIR_CTL_PIN();
    return SUCCESS;
  }

  command result_t PIR.On()
  { 
    TOSH_CLR_PIR_CTL_PIN();
    TOSH_uwait(100);    
    return SUCCESS;
  }
  
  command result_t PIR.Off()
  {
    PIR_INT_DISABLE();
    TOSH_SET_PIR_CTL_PIN();
    return SUCCESS;
  }

  command result_t PIR.detectAdjust(uint8_t val)
  {
    bDetectAdjust = TRUE;
    flag=1;
    detectval=val;    	
    TOSH_CLR_PIR_CTL_PIN();         
    call SetTimer.start(TIMER_REPEAT, 10);
    return SUCCESS;
  }
  
  event result_t SetTimer.fired(){
     if(flag==0)
     {
        call SetTimer.stop();
        return SUCCESS;
     }
     call I2CPot.writePot(TOS_PIR_POT_ADDR, 0, detectval);
     return SUCCESS;
  }

  event result_t I2CPot.readPotDone(char data, bool result)
  {
    return result;
  }

  event result_t I2CPot.writePotDone(bool result)
    {
        if(result==FALSE)
          return FAIL;
        flag=0;
	if (bDetectAdjust) {
	  bDetectAdjust = FALSE;
	  call PotControl.stop();
	  signal PIR.detectAdjustDone();
    }
	return result;
  }
  
  /**************************************************************************
   * Get ADC value of PIRs.
   *  -The input to the ADC is a analog sum of all 4 PIRS (they are ac coupled
   *   to one adc input channel).
   *************************************************************************/
   task void HandleADCTask()
	{
		uint16_t tmp;		
		atomic tmp = adc;
		signal PIR.DataDone(tmp);	
	}

    command result_t PIR.sampleNow()
	{
        call ADC.getData();
//SODbg(DBG_USR2, "PRIM: getAdcData() \n");
		return SUCCESS;
	}
	
    async event result_t ADC.dataReady(uint16_t data)
    {
	atomic adc = data; 
    	post HandleADCTask();
    	return SUCCESS;
    }

    /**************************************************************************
	 * Command used by client to enable sensor device interrupt.
	 * 
	 * @return SUCCESS
	 */
	command result_t PIR.IntEnable()
	{
		PIR_INT_ENABLE();
		return SUCCESS;
	}
	
	/**
	 * Command used by client to disable sensor device interrupt.
	 * 
	 * @return SUCCESS
	 */
	command result_t PIR.IntDisable()
	{
		PIR_INT_DISABLE();
		return SUCCESS;
	}
	
    
    /**
	 * Task used to sample ADC port in response to device interrupt.
	 */
	task void HandleInterruptTask()
	{
		signal PIR.InterruptEvent();     
	}


	/**
	 * Interrupt service routine.
	 */
	TOSH_SIGNAL(SIG_INTERRUPT7)
	{
		PIR_INT_DISABLE();	
		post HandleInterruptTask();
	}
}

