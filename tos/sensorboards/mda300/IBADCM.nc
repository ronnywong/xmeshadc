/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: IBADCM.nc,v 1.1.4.8 2007/04/27 05:10:20 njain Exp $
 */
 
/*
 * Authors:   Mohammad Rahimi mhr@cens.ucla.edu
 * History:   created 08/14/2003
 * update at 11/14/2003 
 *
 *
 * driver for ADS7828EB on mda300ca
 *
 * $Id: IBADCM.nc,v 1.1.4.8 2007/04/27 05:10:20 njain Exp $ 
 */

module IBADCM
{
  provides {
    interface StdControl;
    interface ADConvert[uint8_t port];
    interface SetParam[uint8_t port];
    interface Power as EXCITATION25;
    interface Power as EXCITATION33;
    interface Power as EXCITATION50;
  }
  uses interface I2CPacket;
  uses interface Leds;
  uses interface StdControl as I2CPacketControl;
  uses interface Timer as PowerStabalizingTimer;
  uses interface StdControl as SwitchControl;
  uses interface Switch;
}
implementation
{
  enum {IDLE, PICK_CHANNEL, GET_SAMPLE, CONTINUE_SAMPLE , START_CONVERSION_PROCESS};
#ifndef  VOLTAGE_STABLE_TIME
#define VOLTAGE_STABLE_TIME 100           //Time it takes for the supply voltage to be stable enough
#endif
#define MAX_ANALOG_CHNNELS 13
#define MAX_CHANNELS MAX_ANALOG_CHNNELS + 1 //The last channel is not an analog channel but we keep it only for the sake of exciation.


    /*Note:we do not do anything inside async part so all parts are synchronous and
      there is no synchronization hazard.Now ADC runs in the round-robin fashin so it
      is fair.*/
    
    char state;       /* current state of the i2c request */
    uint16_t value;   /* value of the incoming ADC reading */
    uint8_t chan;
    uint8_t param[MAX_CHANNELS];  /*we reserve last param for excitation of digital channels*/
    uint16_t adc_bitmap;
    uint16_t adc_stopbitmap;
    int8_t conversionNumber;
    //Note "condition" should be a global variable.Since It is passed by address to I2CPacketM.nc and so
    //should be valid even out of the scope of that function since I2CPacketM.nc uses it by its address.
    uint8_t condition;   // set the condition command byte.
    uint8_t sflag;
    uint8_t scount;
    uint8_t initflag;
    uint8_t i2cwflag=0;
    uint8_t i2crflag=0;
    uint8_t swsetallflag=0;
    uint8_t samplecount=0;

    //set of bitwise functions
#define  testbit(var, bit)   ((var) & (1 <<(bit)))      //if zero then return zero and if one not equal zero
#define  setbit(var, bit)    ((var) |= (1 << (bit)))
#define  clrbit(var, bit)    ((var) &= ~(1 << (bit)))
    
    
  //The excitation circuits
#define FIVE_VOLT_ON() TOSH_SET_PW5_PIN()
#define FIVE_VOLT_OFF() TOSH_CLR_PW5_PIN()
    
#define THREE_VOLT_ON()  TOSH_SET_PW3_PIN()
#define THREE_VOLT_OFF() TOSH_CLR_PW3_PIN()

#define TURN_VOLTAGE_BUFFER_ON() TOSH_SET_PW2_PIN()
#define TURN_VOLTAGE_BUFFER_OFF() TOSH_CLR_PW2_PIN()

#define VOLTAGE_BOOSTER_ON() TOSH_CLR_PW1_PIN()
#define VOLTAGE_BOOSTER_OFF() TOSH_SET_PW1_PIN()

  //The instrumentation amplifier
#define TURN_AMPLIFIERS_ON() TOSH_SET_PW6_PIN()
#define TURN_AMPLIFIERS_OFF() TOSH_SET_PW6_PIN()

    /*declareation of function convert*/
    result_t convert();
    task void adc_get_data();
    task void output_ref();
 
    void setExcitation()
      {
      	uint8_t i=0;
        if(param[chan] & EXCITATION_25 ) 
        	{
        		i++;
        		TURN_VOLTAGE_BUFFER_ON();
        	}
        if(param[chan] & EXCITATION_33 ) 
          {
          	i++;
            THREE_VOLT_ON();
          }
        if(param[chan] & EXCITATION_50)
          {
          	i++;
            FIVE_VOLT_ON();
          }
          if(i>0)
          {
						VOLTAGE_BOOSTER_ON();
          }
      }
    
    void resetExcitation()
      {    
        uint8_t i;
        uint8_t flag25=0,flag33=0,flag50=0;
        for(i=0 ; i < MAX_CHANNELS ;i++) 
          {
            if(param[i] & EXCITATION_ALWAYS_ON)
              {
                if(param[i] & EXCITATION_25) flag25=1;
                if(param[i] & EXCITATION_33) flag33=1;
                if(param[i] & EXCITATION_50) flag50=1;
              }
          }
        if(flag25==0) TURN_VOLTAGE_BUFFER_OFF();
        if(flag33==0) THREE_VOLT_OFF();
        if(flag50==0) FIVE_VOLT_OFF();
        if(!flag25 && !flag33 && !flag50)
	  {
	    VOLTAGE_BOOSTER_OFF();
	  }
      }
    
    command void EXCITATION25.on()
      {
        param[MAX_CHANNELS - 1] |= EXCITATION_25;
        param[MAX_CHANNELS - 1] |= EXCITATION_ALWAYS_ON;
        VOLTAGE_BOOSTER_ON();
        TURN_VOLTAGE_BUFFER_ON();
      }
    command void EXCITATION25.off()
      {
        param[MAX_CHANNELS - 1] &= !EXCITATION_25;
        if(state == IDLE) resetExcitation();  //otherwise the fuction will be called at the end of conversion
      }
    command void EXCITATION33.on()
      {
        param[MAX_CHANNELS - 1] |= EXCITATION_33;
        param[MAX_CHANNELS - 1] |= EXCITATION_ALWAYS_ON;
        VOLTAGE_BOOSTER_ON();
        THREE_VOLT_ON();
      }
    command void EXCITATION33.off()
      {
        param[MAX_CHANNELS - 1] &= !EXCITATION_33;
        if(state == IDLE) resetExcitation();  //otherwise the fuction will be called at the end of conversion
      }
    command void EXCITATION50.on()
      {
        param[MAX_CHANNELS - 1] |= EXCITATION_50;
        param[MAX_CHANNELS - 1] |= EXCITATION_ALWAYS_ON;
        VOLTAGE_BOOSTER_ON();
        FIVE_VOLT_ON();
      }
    command void EXCITATION50.off()
      {
        param[MAX_CHANNELS-1] &= !EXCITATION_50;
        if(state == IDLE) resetExcitation();  //otherwise the fuction will be called at the end of conversion
      }

    void setNumberOfConversions()
      {
        conversionNumber = 1;
        if(param[chan] &  AVERAGE_FOUR ) conversionNumber = 4;
        if(param[chan] &  AVERAGE_EIGHT ) conversionNumber = 8;
        if(param[chan] & AVERAGE_SIXTEEN) conversionNumber = 16;
        return;
      }
   
   task void output_ref()
   {
   			 uint8_t val;
		     val=0x08;
			   atomic	i2cwflag=3;
			   if(call I2CPacket.writePacket(1, (char*)(&val), 0x03)==FAIL)
			   {
			   atomic	i2cwflag=0;
	       atomic state = IDLE;
	       TOSH_uwait(100);
	       post output_ref();
	       return;
			   }
			   else
			   {
			   	 atomic sflag=1;
			   	 post adc_get_data();
			   }
   }
  
   task void stopchannel()
   {
   	 uint16_t myflag;
   	 uint8_t  i,conval,val,alwayson_flag;
   	 atomic{
   	 	if(scount>0) scount=0;
	   	 myflag=adc_stopbitmap;
	   	 conval=0;
	   	 alwayson_flag=0;
   	 }
   	 //if EXCITATION_ALWAYS_ON is set,then make ads7828 ref always on
	   for(i=0;i<=MAX_ANALOG_CHNNELS;i++)
	   {
	   	 if(param[i] & EXCITATION_ALWAYS_ON)
	   	 {
		   	alwayson_flag=1;
	   	 	break;
	   	 }
	   }
	   for(i=0;i<=MAX_ANALOG_CHNNELS;i++)
	   {
	   	 if(testbit(myflag,i)==0)
	   	 {
	   	 	//because in output_ref we open channel 11, so now we must close it.
	   	 	if(i!=11)
	   	 	{
	   	 		continue;
	   	  }
	   	 }
	       switch (i) {
	       case 0:
	         conval = 8;
	         break;
	       case 1:
	         conval = 12;
	         break;
	       case 2:
	         conval = 9;
	         break;
	       case 3:
	         conval = 13;
	         break;
	       case 4:
	         conval = 10;
	         break;
	       case 5:
	         conval = 14;
	         break;
	       case 6:
	         conval = 11;
	         break;
	       case 7:
	       case 8:
	       case 9:
	       case 10:
	         //these channels all use ADC channel 7 and multiplex it.
	         conval = 15;
	         break;
	       case 11:
	         conval = 0;
	         break;
	       case 12:
	         conval = 1;
	         break;
	       case 13:
	         conval = 2;
	         break;
	       }
	     
		   val=(conval<<4) & 0xf0;
		   if(alwayson_flag)
		   {
		   	val=val | 0x0f;
		   }
		   atomic	i2cwflag=3;
		   if(call I2CPacket.writePacket(1, (char*)(&val), 0x03)==FAIL)
		   {
			   atomic	{
			   	 i2cwflag=0;
				   if(scount==0)
				   {
				   	post stopchannel();
				   	scount=1;
				   }
				 }
		     TOSH_uwait(10);
		   }
		   else
		   {
		   	atomic {
		   		clrbit(adc_stopbitmap,i);
		    }
		   }
	   }
  }
      
command result_t StdControl.init() {
  int i;
  atomic{
    state = IDLE;
    sflag=0;
    adc_bitmap=0;
    adc_stopbitmap=0;
    initflag=0;
    for(i=0; i < MAX_CHANNELS ; i++) param[i]=0x00;
  }
  call I2CPacketControl.init();
  call SwitchControl.init();
  TOSH_MAKE_PW1_OUTPUT();
  TOSH_MAKE_PW2_OUTPUT();
  TOSH_MAKE_PW3_OUTPUT();
  TOSH_MAKE_PW4_OUTPUT();
  TOSH_MAKE_PW5_OUTPUT();
  TOSH_MAKE_PW6_OUTPUT();
  TURN_AMPLIFIERS_OFF();           
  VOLTAGE_BOOSTER_OFF();
  FIVE_VOLT_OFF();
  THREE_VOLT_OFF();
  TURN_VOLTAGE_BUFFER_OFF();
  return SUCCESS;
}

 command result_t StdControl.start() {
   atomic {
   	adc_stopbitmap=0;
   	samplecount=0;
    chan=MAX_ANALOG_CHNNELS+1;
  }
  post output_ref();
   call SwitchControl.start();
   return SUCCESS;
 }
 
 command result_t StdControl.stop() {
   atomic {
   	sflag=0;
   	state=IDLE;
   	scount=0;
   }
   if(initflag==1)
   {
   	atomic adc_bitmap=0;
   }
   atomic{
   	 	if(scount==0)
   	 	{
   	 		post stopchannel();
	   	 	scount=1;
   	 	}
   }
   
   TURN_AMPLIFIERS_OFF();   
   resetExcitation();        
   if(initflag==0)
   {
   initflag=1;
   }
   call SwitchControl.stop();
   return SUCCESS;
 }


command result_t SetParam.setParam[uint8_t id](uint8_t mode){
  param[id]=mode;
  return SUCCESS;
}


default event result_t ADConvert.dataReady[uint8_t id](uint16_t data) {
      return SUCCESS;
  }  

 task void adc_get_data()
   {
     uint8_t myIndex;
     uint8_t count;
     uint8_t val;
     uint16_t my_bitmap;
     if(state != IDLE) return; //That means the component is busy in a conversion process.When conversion done either successfull or
                               //fail it is gauranteed that this task will be posted so we can safely return.     
     atomic state=START_CONVERSION_PROCESS; 
     if(sflag==0) 
     {
     atomic state=IDLE;
     return;
     }
     atomic { 
	    value=0;    
     	my_bitmap = adc_bitmap;
      //it gaurantees a round robin fair scheduling of ADC conversions.
      count=0;
      myIndex=chan+1;
     }
     if(myIndex > MAX_ANALOG_CHNNELS) myIndex=0;
     while(!testbit(my_bitmap,myIndex))
       {
         myIndex++;
         if(myIndex > MAX_ANALOG_CHNNELS) myIndex=0;
         count++;
         if(count > MAX_ANALOG_CHNNELS) {state=IDLE; return; }   //no one waiting for conversion
       }
atomic{
     chan=myIndex; 
   	 setExcitation();
     setNumberOfConversions();
    }
     //if among the instrumentation channels we set the MUX    
     if(chan == 7 || chan==8 || chan==9 || chan==10) 
       {
         char muxChannel;
         TURN_AMPLIFIERS_ON();              
         switch (chan) {
         default:			// should never happen
         case 7:
           muxChannel = MUX_CHANNEL_SEVEN;
           break;
         case 8:
           muxChannel = MUX_CHANNEL_EIGHT;
           break;
         case 9:
           muxChannel = MUX_CHANNEL_NINE;
           break;
         case 10:
           muxChannel = MUX_CHANNEL_TEN;
           break;
         }    
         atomic swsetallflag=1;            
         if ((call Switch.setAll(muxChannel)) == FAIL)
           {     
             // Can not select channel
             atomic {
             	swsetallflag=0;
              state = IDLE;
             }
             TURN_AMPLIFIERS_OFF(); 
             post adc_get_data(); 
             resetExcitation();
           }
       }
     else {
       //If the conversions happens fast there is no need to
       //wait for settling of the power supply,note that power supply should be set ON by user using the excitation command
		       if(param[chan] & DELAY_BEFORE_MEASUREMENT) {
         call PowerStabalizingTimer.start(TIMER_ONE_SHOT, VOLTAGE_STABLE_TIME);
   			}     
       else {
         convert();
       }
     }
   }
 
result_t convert() {
   if (state == START_CONVERSION_PROCESS || state == CONTINUE_SAMPLE)
     {
       atomic state = PICK_CHANNEL;
       // figure out which channel is to be set
       switch (chan) {
       default:			// should never happen
       case 0:
         condition = 8;
         break;
       case 1:
         condition = 12;
         break;
       case 2:
         condition = 9;
         break;
       case 3:
         condition = 13;
         break;
       case 4:
         condition = 10;
         break;
       case 5:
         condition = 14;
         break;
       case 6:
         condition = 11;
         break;
       case 7:
       case 8:
       case 9:
       case 10:
         //these channels all use ADC channel 7 and multiplex it.
         condition = 15;
         break;
       case 11:
         condition = 0;
         break;
       case 12:
         condition = 1;
         break;
       case 13:
         condition = 2;
         break;
       }
     }
   // shift the channel and single-ended input bits over
   condition = (condition << 4) & 0xf0;
   condition = condition | 0x0f;
   //tell the ADC to start converting
   atomic i2cwflag=1;
   if ((call I2CPacket.writePacket(1, (char*)(&condition), 0x03)) == FAIL)
     {
       atomic state = IDLE;
       atomic i2cwflag=0;
       TOSH_uwait(100);
       post adc_get_data();
       resetExcitation();
       return FALSE;
     }
   return SUCCESS;
   TURN_AMPLIFIERS_OFF();
   }
            
// get a single reading from id we
command result_t ADConvert.getData[uint8_t id]() {      
  if(id>13) return FAIL;  //should never happen unless wiring is wrong.
  atomic {
    setbit(adc_bitmap,id);
    setbit(adc_stopbitmap,id);
  }
  post adc_get_data();
  return SUCCESS;
}
 
//Setting the MUX has been done.
 event result_t Switch.setAllDone(bool r) 
   {
   	 if(swsetallflag==0) return SUCCESS;
   	 atomic swsetallflag=0;
     if(!r) {
       atomic state=IDLE;
       TURN_AMPLIFIERS_OFF(); 
       post adc_get_data();
       resetExcitation();
       return FAIL;
     }
     
     //If the conversions happens fast there is no need to
     //wait for settling of the power supply,note that power supply should be set ON by user using the excitation command
     if(param[chan] & DELAY_BEFORE_MEASUREMENT) {
       call PowerStabalizingTimer.start(TIMER_ONE_SHOT, VOLTAGE_STABLE_TIME);
       return SUCCESS;
     }
     else {
       return convert();
     }          
     return SUCCESS;
   }
 
 
 
 event result_t PowerStabalizingTimer.fired() {  
   return convert();
 }
 
 /* not yet implemented */
 command result_t ADConvert.getContinuousData[uint8_t id]() {
   return FAIL;
 }
 
 event result_t I2CPacket.readPacketDone(char length, char* data) {
 	 if(i2crflag==0) return SUCCESS;
 	 atomic	i2crflag=0;
   if (length != 2)
     {
       atomic state = IDLE;
       TURN_AMPLIFIERS_OFF();
       atomic { clrbit(adc_bitmap,chan); }
       signal ADConvert.dataReady[chan](ADC_ERROR);
       post adc_get_data();
       resetExcitation();
       return FAIL;
     }
   
   if (state == GET_SAMPLE)
     {
       value += (data[1] & 0xff) + ((data[0] << 8) & 0x0f00);
       conversionNumber--;
       //value = (data[0] << 8) & 0x0f00;
       //value += (data[1] & 0xff);        
       if (conversionNumber==0) {
         atomic state = IDLE;
         if(param[chan] & AVERAGE_SIXTEEN)
           value = ((value+8) >>4) & 0x0fff;  //the addition is for more percision 
         else if(param[chan] &  AVERAGE_EIGHT )
           value = ((value+4) >>3) & 0x0fff;  //the addition is for more percision 
         else if(param[chan] &  AVERAGE_FOUR ) 
           value = ((value+2) >>2) & 0x0fff;   //the addition is for more percision 
         // else { //do nothing since no averaging}
         TURN_AMPLIFIERS_OFF();
         atomic samplecount++;
         //the first value is not correct for first sample channel.
         if(samplecount!=1)
         {
	         atomic { clrbit(adc_bitmap,chan); }
	         signal ADConvert.dataReady[chan](value);
         }
         post adc_get_data();
         resetExcitation();
       }
       else {
         atomic state = CONTINUE_SAMPLE;
         convert();
       }
     }
   return SUCCESS;
 }
 
 event result_t I2CPacket.writePacketDone(bool result) {
 	 if(i2cwflag==0 ) return SUCCESS;
 	 if(i2cwflag!=1)
 	 {
 	 	atomic	{
 	 		i2cwflag=0;
 	 	}
 	 	return SUCCESS;
 	 }
 	 atomic	i2cwflag=0;
   if (!result)
     {
       state = IDLE;
       TURN_AMPLIFIERS_OFF();
       atomic { clrbit(adc_bitmap,chan); }
       signal ADConvert.dataReady[chan](ADC_ERROR);
       post adc_get_data();
       resetExcitation();
       return FAIL;
     }
   if (state == PICK_CHANNEL)
     {
       state = GET_SAMPLE;
       atomic i2crflag=1;
       if ((call I2CPacket.readPacket(2, 0x03)) == 0)
         {
           //reading from the bus failed
		       atomic i2crflag=0;
           state = IDLE;
           post adc_get_data();
           resetExcitation();
           return FAIL;
         }
     }
   return SUCCESS;            
 }
 
 
  event result_t Switch.getDone(char val) 
    {
      return SUCCESS;
    }
  
  event result_t Switch.setDone(bool r) 
    {
      return SUCCESS;
    }
  
}
