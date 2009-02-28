/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: MicM.nc,v 1.1.4.4 2007/04/27 05:45:35 njain Exp $
 */
 
/*
 *
 * Authors:  Mike Grimmer
 * Revision:		
 *
 */

includes sensorboard;
module MicM 
{
  provides interface StdControl;
  provides interface Mic;
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
  uint32_t timerval;
  uint16_t adc;
  uint8_t  state;
  uint8_t  flag;
  uint8_t detectval;
  uint8_t gainval;
  uint8_t lpval;
  uint8_t  hpval;


  command result_t StdControl.init() 
  {
    call ADCControl.bindPort(TOS_ADC_MIC_PORT, TOSH_ACTUAL_MIC_PORT);
    TOSH_MAKE_MIC_CTL_OUTPUT();
    TOSH_SET_MIC_CTL_PIN();
    TOSH_uwait(100);
    flag=0;
    state=0;
    timerval=20;
    call ADCControl.init();
    call PotControl.init();
    cbi(EIMSK,5);
    cbi(EICRB,ISC50);
    cbi(EICRB,ISC51);
    return SUCCESS;
  }

  command result_t StdControl.start() 
  {
    TOSH_CLR_MIC_CTL_PIN();
    TOSH_uwait(100);
    MIC_INT_ENABLE();
    return SUCCESS;
  }

  command result_t StdControl.stop() 
  {
    TOSH_SET_MIC_CTL_PIN();
    MIC_INT_DISABLE();
    return SUCCESS;
  }

  command result_t Mic.MicOn()
  {
    TOSH_CLR_MIC_CTL_PIN();
    TOSH_uwait(100);
    return SUCCESS;
  }
  
  command result_t Mic.MicOff()
  {
    MIC_INT_DISABLE();
    TOSH_SET_MIC_CTL_PIN();
    return SUCCESS;
  }
  command result_t Mic.LPFsetFreq(uint8_t freq)
  {
    flag=flag | 0x03;
    lpval=freq;
/*
    if(state==0)
    {
    state=1;
    call SetTimer.start(TIMER_REPEAT, timerval);
    }*/
    return SUCCESS;
  }
  
  command result_t Mic.HPFsetFreq(uint8_t freq)
  {
    flag=flag | 0x0c;
    hpval=freq;
    /*
    if(state==0)
    {
    state=4;
    call SetTimer.start(TIMER_REPEAT, timerval);
    }*/
    return SUCCESS;
  }

  command result_t Mic.gainAdjust(uint8_t val)
  {
    flag=flag | 0x10;
    gainval=val;
/*
    if(state==0)
    {
    state=0x10;
    call SetTimer.start(TIMER_REPEAT, timerval);
    }*/
    return SUCCESS;
  }
  
  command result_t Mic.detectAdjust(uint8_t val)
  {
    flag=flag | 0x20;
    detectval=val;
    /*
    if(state==0)
    {
    state=0x20;
    call SetTimer.start(TIMER_REPEAT, timerval);
    }*/
    return SUCCESS;
  }
  command result_t Mic.setting()
  {
  	return call SetTimer.start(TIMER_REPEAT, timerval);
  }

  uint8_t GetNextState(uint8_t current)
  {
     uint8_t i,tmpstate,val;
     tmpstate=flag;
     tmpstate=tmpstate & (~current);
     for(i=0;i<8;i++)
     {
        if((tmpstate & 0x01)!=0)
        {
           break;
        }
        tmpstate=tmpstate >>1;
     }
     if(i>=8)
        return 0;
     val=0x01 << i;
     return val;
  }
  
  event result_t SetTimer.fired(){
//          TOSH_CLR_MIC_CTL_PIN();
          state=GetNextState(0);
	  switch (state)
	  {
		  case 1:
		  {
		  call I2CPot.writePot(TOS_LPF_POT_ADDR, 0, lpval);
		  break;
		  }
		  case 2:
		  {
		  call I2CPot.writePot(TOS_LPF_POT_ADDR, 1, lpval);
		  break;
		  }
		  case 4:
		  {
		  call I2CPot.writePot(TOS_HPF_POT_ADDR, 0, hpval/2);
		  break;
		  }
		  case 8:
		  {
		  call I2CPot.writePot(TOS_HPF_POT_ADDR, 1, hpval);
		  break;
		  }
		  case 0x10:
		  {
		  call I2CPot.writePot(TOS_MIC_POT_ADDR, 0, gainval);
		  break;
		  }
		  case 0x20:
		  {
		  call I2CPot.writePot(TOS_MIC_POT_ADDR, 1, detectval);
		  break;
		  }
		  default:
		  {
		  if(flag==0)
		  {
/*
	  	  	TOSH_MAKE_GREEN_LED_OUTPUT();
  			TOSH_SET_GREEN_LED_PIN();    	
*/
		  call SetTimer.stop();
		  signal Mic.SetDone();
		  }
		  return SUCCESS;
		  }
	  }
	  return SUCCESS;
  }

  event result_t I2CPot.readPotDone(char data, bool result)
  {
    return SUCCESS;
  }

  event result_t I2CPot.writePotDone(bool result)
  {
    if(result==FALSE)
       return FAIL;
    if(state!=0)
    {
        flag=flag & (~state);        
    }
/*
    if (state == 0x20)
    {
	  	  	TOSH_MAKE_GREEN_LED_OUTPUT();
  			TOSH_CLR_GREEN_LED_PIN();    	
    }
*/
    return SUCCESS;
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
	signal Mic.DataDone(tmp);	
   }

   command result_t Mic.sampleNow()
   {
        call ADC.getData();
	return SUCCESS;
   }
	
   async event result_t ADC.dataReady(uint16_t data)
   {
	atomic adc = data; 
    	post HandleADCTask();
    	return SUCCESS;
   }
   
   command result_t Mic.IntEnable()
   {
   MIC_INT_ENABLE();
   return SUCCESS;
   }
   
   /**
   * Command used by client to disable sensor device interrupt.
   * 
   * @return SUCCESS
   */
   command result_t Mic.IntDisable()
   {
   MIC_INT_DISABLE();
   return SUCCESS;
   }
  
  task void HandleInterruptTask()
  {
	signal Mic.InterruptEvent();     
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

