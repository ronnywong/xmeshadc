/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: SampleM.nc,v 1.1.4.1 2007/04/27 05:32:58 njain Exp $
 */


module SampleM
{
    provides interface StdControl as SamplerControl;
    provides interface Sample;

  uses {
      interface Leds;
      interface StdControl as IBADCcontrol;
      interface StdControl as SwitchControl;
      interface Switch;
      interface ADConvert as Vexc;
      interface ADConvert as Vsense;
      interface ADConvert as Vrtn;
  }
}
implementation
{
	enum { SET_SWITCH, IDLE, EXC, SENSE,RTN,D2A};
	const uint8_t MAX_CNT_AVRG=32;	
	char state;
	uint8_t curent_channel; // RTD1-4
	uint16_t Ve[32],Vs[32],Vr[32],Vd[32];   // ADC Channels readings 
	uint32_t AVe,AVs,AVr,AVd;
	uint8_t AvrgCnt;


 	command result_t SamplerControl.init() {
 		state = IDLE;
 		call SwitchControl.init();
        call IBADCcontrol.init(); 	
        return SUCCESS;
    }
    
    command result_t SamplerControl.start() { 
        call IBADCcontrol.start();
 		call SwitchControl.start();    	
        return SUCCESS;
    }

    command result_t SamplerControl.stop() {
 		call SwitchControl.stop();    	
        call IBADCcontrol.stop();
        return SUCCESS;
    }

	command result_t Sample.getSample(uint8_t RTDNum)
	{
        if(state != IDLE)return FAIL;		
		curent_channel = RTDNum;
		state = SET_SWITCH;
		call Switch.setCH(curent_channel);	
        return SUCCESS;			
	}         
    
  event result_t Switch.setCHDone() 
  {
  	 if(state == SET_SWITCH) {
  	 	state = EXC;
  	 	AvrgCnt = 0;
  	 	call Vexc.getData();
  	 	}
     return SUCCESS;
  }
  
    event result_t Vexc.dataReady(uint16_t data) {
      if(state!=EXC)return FAIL;
	  Ve[AvrgCnt] = data;
 
  	  AvrgCnt++; 
  	  if(AvrgCnt<MAX_CNT_AVRG){
  	 	call Vexc.getData();
  	}else{
  	  state = SENSE;	  	
  		AvrgCnt = 0;
	  	call Vsense.getData();
		}	  
      return SUCCESS;
    }
    
    event result_t Vsense.dataReady(uint16_t data) {
      if(state!=SENSE)return FAIL; 

	  Vs[AvrgCnt] = data;
  	  AvrgCnt++; 
  	  if(AvrgCnt<MAX_CNT_AVRG){
  	 	call Vsense.getData();
  	}else{
      state=RTN;   	  	
  		AvrgCnt = 0;
	  	call Vrtn.getData();
		}	  
      return SUCCESS;
    }
    
    event result_t Vrtn.dataReady(uint16_t data) {
      
      uint8_t i;
      
      if(state!=RTN)return FAIL;     
	  Vr[AvrgCnt] = data;
	  AvrgCnt++;

  	  if(AvrgCnt<MAX_CNT_AVRG){
  	 	call Vrtn.getData();
  	  }else{
      	state = IDLE;      	  
  	  	AVe =AVs=AVr=AVd=0;
  	    for(i=0;i<MAX_CNT_AVRG;i++){
  	     	AVe += (uint32_t)Ve[i];
  	     	AVs += (uint32_t)Vs[i];  
  	     	AVr += (uint32_t)Vr[i];  	
  	     	AVd += (uint32_t)Vd[i];  	     	     		     	
  	     }
//  	     AVe/=MAX_CNT_AVRG;
//  	     AVs/=MAX_CNT_AVRG;  	
//  	     AVr/=MAX_CNT_AVRG;  	 
//  	     AVd/=MAX_CNT_AVRG;  	     
  	     AVe=AVe>>5;
  	     AVs=AVs>>5;  	
  	     AVr=AVr>>5;  	 
  	     AVd=AVd>>5;  	     

	     signal Sample.dataReady(curent_channel,(uint16_t)AVe,(uint16_t)AVs,(uint16_t)AVr);
		}		  
      return SUCCESS;
    }
    
    default async event result_t Sample.dataReady(uint8_t channel,uint16_t data1,uint16_t data2,uint16_t data3)
        {
          return SUCCESS;
        }
}
