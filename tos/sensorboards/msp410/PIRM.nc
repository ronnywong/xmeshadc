/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: PIRM.nc,v 1.1.4.1 2007/04/27 05:28:15 njain Exp $
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
  }
}
implementation 
{
#include "SODebug.h"
  bool bQuadAdjust;
  bool bDetectAdjust;
  uint16_t adc;


  command result_t StdControl.init() 
  {
    bDetectAdjust = FALSE;
	bQuadAdjust = FALSE;
    call ADCControl.bindPort(TOS_ADC_PIR_PORT, TOSH_ACTUAL_PIR_PORT);
//    call ADCControl.bindPort(TOS_ADC_BANDGAP_PORT,TOSH_ACTUAL_BANDGAP_PORT);
    
    TOSH_SET_PIR_CTL_PIN();
	TOSH_SET_INT2_PIN();
	TOSH_MAKE_IRQUAD1_INPUT();
	TOSH_MAKE_IRQUAD2_INPUT();
	TOSH_MAKE_IRQUAD3_INPUT();
	TOSH_MAKE_IRQUAD4_INPUT();
         SODbg(DBG_USR2, "PIRMinit() \n");
    call ADCControl.init();
    call PotControl.init();
    return SUCCESS;
  }

  command result_t StdControl.start() 
  {
    TOSH_SET_PIR_CTL_PIN();
    return SUCCESS;
  }

  command result_t StdControl.stop() 
  {
    TOSH_SET_PIR_CTL_PIN();
     SODbg(DBG_USR2, "PRIMstop() \n");
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
    SODbg(DBG_USR2, "PRIMoff() \n");
    return SUCCESS;
  }

  command result_t PIR.detectAdjust(uint8_t val)
  {
    TOSH_SET_I2C_MUX_PIN();
    // SODbg(DBG_USR2, "PRIM detect adjust  \n");
	bDetectAdjust = TRUE;    	         
    return call I2CPot.writePot(TOS_PIR_POT_ADDR, 0, val);
  }

  command result_t PIR.QuadAdjust(uint8_t val)
  {
   
    TOSH_SET_I2C_MUX_PIN();
	bQuadAdjust = TRUE;
    return call I2CPot.writePot(TOS_PIR_POT_ADDR, 1, val);
  }

  command uint8_t PIR.QuadRead(uint8_t* quaddetect)
  {
    uint8_t myquad;

    *quaddetect = 0;
	myquad = 0;

    myquad = TOSH_READ_IRQUAD1_PIN();
    
    // SODbg(DBG_USR2, "PRIM myquad %i \n",myquad);


    if (TOSH_READ_IRQUAD1_PIN())
	{
	  *quaddetect = 1;
	  myquad += 1;
	}
    if (TOSH_READ_IRQUAD2_PIN())
	{
	  *quaddetect += 2;
	  myquad += 2;
	}
    if (TOSH_READ_IRQUAD3_PIN())
	{
	  *quaddetect += 4;
	  myquad +=4;
	}
    if (TOSH_READ_IRQUAD4_PIN())
	{
	  *quaddetect += 8;
	  myquad += 8;
	}
	
    return myquad;
  }	  

  event result_t I2CPot.readPotDone(char data, bool result)
  {
    TOSH_SET_I2C_MUX_PIN();
    return result;
  }

  event result_t I2CPot.writePotDone(bool result)
    {
    if (bQuadAdjust) {
	  bQuadAdjust = FALSE;
      signal PIR.QuadAdjustDone();
    }
	if (bDetectAdjust) {
	  bDetectAdjust = FALSE;
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
	TOSH_SIGNAL(SIG_INTERRUPT6)
	{
		PIR_INT_DISABLE();	
		post HandleInterruptTask();
	}
}

