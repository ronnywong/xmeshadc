/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: IBADCM.nc,v 1.2.2.4 2007/04/27 05:14:43 njain Exp $
 */
 
/*
 *
 * Authors:   pipeng
 * History:   created 07/14/2005
 * 
 * driver for ADS78344 on mda320
 *
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
  uses interface Leds;
  uses interface StdControl as I2CPacketControl;
  uses interface Timer as PowerStabalizingTimer;
}
implementation
{
  enum {IDLE, PICK_CHANNEL, GET_SAMPLE, CONTINUE_SAMPLE , START_CONVERSION_PROCESS};
  
#ifndef  VOLTAGE_STABLE_TIME
#define VOLTAGE_STABLE_TIME 100           //Time it takes for the supply voltage to be stable enough
#endif
#define MAX_ANALOG_CHNNELS 11
#define MAX_CHANNELS MAX_ANALOG_CHNNELS + 1 //The last channel is not an analog channel but we keep it only for the sake of exciation.


    /*Note:we do not do anything inside async part so all parts are synchronous and
      there is no synchronization hazard.Now ADC runs in the round-robin fashin so it
      is fair.*/
    
    char state;       /* current state of the i2c request */
    uint8_t sflag;
    uint16_t value;   /* value of the incoming ADC reading */
    uint8_t chan;
    uint8_t param[MAX_CHANNELS];  /*we reserve last param for excitation of digital channels*/
    uint16_t adc_bitmap;
    uint16_t adc_stopbitmap;
    int8_t conversionNumber;
    //Note "condition" should be a global variable.Since It is passed by address to I2CPacketM.nc and so
    //should be valid even out of the scope of that function since I2CPacketM.nc uses it by its address.
    uint8_t condition;   // set the condition command byte.

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
#define TURN_AMPLIFIERS_OFF() TOSH_CLR_PW6_PIN()

  // hardware pin functions
  void SET_CLOCK() { TOSH_SET_ALE_PIN(); }
  void CLEAR_CLOCK() { TOSH_CLR_ALE_PIN(); }
  void MAKE_CLOCK_OUTPUT() { TOSH_MAKE_ALE_OUTPUT(); }
  void MAKE_CLOCK_INPUT() { TOSH_MAKE_ALE_INPUT(); }

  void SET_DIN_DATA() { TOSH_SET_PWM0_PIN(); }
  void CLEAR_DIN_DATA() { TOSH_CLR_PWM0_PIN(); }
  void MAKE_DIN_OUTPUT() { TOSH_MAKE_PWM0_OUTPUT(); }
  
  void MAKE_DOUT_INPUT() { TOSH_MAKE_RD_INPUT(); }
  char GET_DOUT_DATA() { return TOSH_READ_RD_PIN(); }
  
  void MAKE_ADCBUSY_INPUT() {TOSH_MAKE_WR_INPUT();}
  char GET_ADCBUSY_DATA() { return TOSH_READ_WR_PIN(); } 



  void pulse_clock() {
	TOSH_uwait(5);
	SET_CLOCK();
	TOSH_uwait(5);
	CLEAR_CLOCK();
  }
  void waitn(uint8_t n)
  {
	  uint8_t i;
	  for(i=0;i<n;i++)
	  {
	  pulse_clock();
	  }
  }
  char read_bit() {
      uint8_t i;
      
      MAKE_DOUT_INPUT();
      pulse_clock();
      i = GET_DOUT_DATA();
      return i;
  }
  
  
  void setPowerMode()
  {
  	
  }
  void wait_adc_free() 
  {      
      while(1){
      	if((GET_ADCBUSY_DATA()|0x01)==1)
      	 {break;}
				pulse_clock();
      }
      
      return;  	  	
  }
  
  uint16_t adc_read(){
      uint16_t data = 0;
      uint8_t i = 0;
      for(i = 0; i < 16; i ++){
          data = (data << 1) & 0xfffe;
          if(read_bit() == 1){
              data |= 0x1;
          }
      }
      return data;
  }
  
  result_t ctrlbyte_write(char c) { 
      uint8_t i;
      for(i = 0; i < 8; i ++){
          pulse_clock();
          if(c & 0x80){
              SET_DIN_DATA();
          }else{
              CLEAR_DIN_DATA();
          }
          c = c << 1;
      }
      pulse_clock();
      CLEAR_DIN_DATA();

      return SUCCESS;
  } 

    /*declareation of function convert*/
    result_t convert();

 
    void setExcitation()
      {
        if(param[chan] & EXCITATION_25 ) 
        {
        	TOSH_SET_PW7_PIN();
					VOLTAGE_BOOSTER_ON();
       		TURN_VOLTAGE_BUFFER_ON();
        }
        if(param[chan] & EXCITATION_33 ) 
        {
        	TOSH_SET_PW7_PIN();
					VOLTAGE_BOOSTER_ON();
          THREE_VOLT_ON();
        }
        if(param[chan] & EXCITATION_50)
        {
        	TOSH_SET_PW7_PIN();
					VOLTAGE_BOOSTER_ON();
          FIVE_VOLT_ON();
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

   task void stopchannel()
   {
   	 uint16_t myflag;
   	 uint8_t  i,val,alwayson_flag;
   	 atomic{
	   	 myflag=adc_stopbitmap;
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
	   	 	continue;
	   	 }
	       switch (i) {
		       case 0:
		         val = 0x87;
		         break;
		       case 1:
		         val = 0xC7;
		         break;
		       case 2:
		         val = 0x97;
		         break;
		       case 3:
		         val = 0xD7;
		         break;
		       case 4:
		         val = 0xA7;
		         break;
		       case 5:
		         val = 0xE7;
		         break;
		       case 6:
		         val = 0xB7;
		         break;
		       case 7:
		         val = 0xF7;
		         break;
		       case 8:
		         val = 0x83;
		         break;
		       case 9:
		         val = 0x93;
		         break;
		       case 10:
		         val = 0xA3;
		         break;
		       case 11:
		         val = 0xB3;
	         break;
	       }
	     
		   val=val & 0xfc;
		   if(alwayson_flag==0)
		   {
		   	TOSH_CLR_PW7_PIN();
		   }
		   ctrlbyte_write(val);
	   	 atomic {
		   		clrbit(adc_stopbitmap,i);
		   }
	   }
	   resetExcitation();
  }

command result_t StdControl.init() {
  int i;
  atomic{
    state = IDLE;
    sflag=0;
    adc_bitmap=0;
    adc_stopbitmap=0;
    for(i=0; i < MAX_CHANNELS ; i++) param[i]=0x00;
  }
  TOSH_MAKE_PW1_OUTPUT();
  TOSH_MAKE_PW2_OUTPUT();
  TOSH_MAKE_PW3_OUTPUT();
  TOSH_MAKE_PW4_OUTPUT();
  TOSH_MAKE_PW5_OUTPUT();
  TOSH_MAKE_PW6_OUTPUT();
  MAKE_CLOCK_OUTPUT();
  MAKE_ADCBUSY_INPUT();
  MAKE_DIN_OUTPUT();
  VOLTAGE_BOOSTER_OFF();
  FIVE_VOLT_OFF();
  THREE_VOLT_OFF();
  TURN_VOLTAGE_BUFFER_OFF();
  TOSH_MAKE_PW0_OUTPUT();
  TOSH_CLR_PW0_PIN();
  return SUCCESS;
}

 command result_t StdControl.start() {
   atomic {
   	sflag=1;
   	adc_stopbitmap=0;
  }
  TOSH_SET_PW6_PIN();
   pulse_clock();
   return SUCCESS;
 }
 
 command result_t StdControl.stop() {
   atomic {
   	sflag=0;
   	state=IDLE;
   }
   TOSH_CLR_PW6_PIN();
  post stopchannel();          
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
     uint16_t my_bitmap;
     if(state != IDLE) return; //That means the component is busy in a conversion process.When conversion done either successfull or
                               //fail it is gauranteed that this task will be posted so we can safely return.     
     if(sflag==0) 
     {
     state=IDLE;
     return;
     }
     value=0;    
     state=START_CONVERSION_PROCESS; 
     atomic { my_bitmap = adc_bitmap; }
     //it gaurantees a round robin fair scheduling of ADC conversions.
     atomic{
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

     atomic { 
     chan=myIndex;
     setExcitation();
     setNumberOfConversions();
     }
       //If the conversions happens fast there is no need to
       //wait for settling of the power supply,note that power supply should be set ON by user using the excitation command
       if(param[chan] & DELAY_BEFORE_MEASUREMENT) {
         call PowerStabalizingTimer.start(TIMER_ONE_SHOT, VOLTAGE_STABLE_TIME);
       }
       else {
         convert();
       }
   }
 
result_t convert() {
   if (state == START_CONVERSION_PROCESS || state == CONTINUE_SAMPLE)
     {
       state = PICK_CHANNEL;
       // figure out which channel is to be set
       switch (chan) {
       default:			// should never happen
       case 0:
         condition = 0x87;
         break;
       case 1:
         condition = 0xC7;
         break;
       case 2:
         condition = 0x97;
         break;
       case 3:
         condition = 0xD7;
         break;
       case 4:
         condition = 0xA7;
         break;
       case 5:
         condition = 0xE7;
         break;
       case 6:
         condition = 0xB7;
         break;
       case 7:
         condition = 0xF7;
         break;
       case 8:
         condition = 0x83;
         break;
       case 9:
         condition = 0x93;
         break;
       case 10:
         condition = 0xA3;
         break;
       case 11:
         condition = 0xB3;
         break;

       }
	     }
	     ctrlbyte_write(condition);
	     value = adc_read();
	     clrbit(adc_bitmap,chan);
	     signal ADConvert.dataReady[chan](value);
	     resetExcitation();
	     state=IDLE;
	     post adc_get_data();
     return SUCCESS;
   }
            
// get a single reading from id we
command result_t ADConvert.getData[uint8_t id]() {  
  if(id>11) return FAIL;  //should never happen unless wiring is wrong.
  atomic {
    setbit(adc_bitmap,id);
    setbit(adc_stopbitmap,id);
  }
  post adc_get_data();
  return SUCCESS;
}
 
 
 
 event result_t PowerStabalizingTimer.fired() {      
   return convert();
 }
 
 /* not yet implemented */
 command result_t ADConvert.getContinuousData[uint8_t id]() {
   return FAIL;
 }
 
  
}
