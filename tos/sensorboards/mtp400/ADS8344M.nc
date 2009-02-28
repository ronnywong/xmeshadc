/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: ADS8344M.nc,v 1.1.4.1 2007/04/27 05:31:26 njain Exp $
 */

/**
 *
 * driver for ADS8344 on mtp400ca
 *
 */



module ADS8344M
{
  provides {
    interface StdControl;
    interface ADConvert[uint8_t port];
  }
}
implementation
{
  enum {IDLE, START_CONVERSION_PROCESS,SAMPLING};
  uint8_t state;
  uint16_t adcVal;
  uint8_t curPort;
  uint16_t adc_bitmap;  
  uint8_t ctlByte;
  
#define MAX_CHNNELS 8  

  
    //set of bitwise functions
#define  testbit(var, bit)   ((var) & (1 <<(bit)))      //if zero then return zero and if one not equal zero
#define  setbit(var, bit)    ((var) |= (1 << (bit)))
#define  clrbit(var, bit)    ((var) &= ~(1 << (bit)))  

// power control assignments
TOSH_ASSIGN_PIN(PG0, G, 0);
TOSH_ASSIGN_PIN(PG1, G, 1);
TOSH_ASSIGN_PIN(PG2, G, 2);
TOSH_ASSIGN_PIN(PB4, B, 4);

  // hardware pin functions
  void SET_CLOCK() { TOSH_SET_PG2_PIN(); }
  void CLEAR_CLOCK() { TOSH_CLR_PG2_PIN(); }
  void MAKE_CLOCK_OUTPUT() { TOSH_MAKE_PG2_OUTPUT(); }
  void MAKE_CLOCK_INPUT() { TOSH_MAKE_PG2_INPUT(); }

  void SET_DIN_DATA() { TOSH_SET_PB4_PIN(); }
  void CLEAR_DIN_DATA() { TOSH_CLR_PB4_PIN(); }
  void MAKE_DIN_OUTPUT() { TOSH_MAKE_PB4_OUTPUT(); }
  
  void MAKE_DOUT_INPUT() { TOSH_MAKE_PG1_INPUT(); }
  char GET_DOUT_DATA() { return TOSH_READ_PG1_PIN(); }
  
  void MAKE_ADCBUSY_INPUT() {TOSH_MAKE_PG0_INPUT();}
  char GET_ADCBUSY_DATA() { return TOSH_READ_PG0_PIN(); } 



  void pulse_clock() {
//	TOSH_uwait(5);
	SET_CLOCK();
//	TOSH_uwait(5);
	CLEAR_CLOCK();
  }


/*
Since one clock cycle of the serial clock is consumed with
BUSY going HIGH (while the MSB decision is being
made), 16 additional clocks must be given to clock out all 16
bits of data; thus, one conversion takes a minimum of 25
clock cycles to fully read the data. Since most microprocessors
communicate in 8-bit transfers, this means that an
additional transfer must be made to capture the LSB.
There are two ways of handling this requirement. One is
where the beginning of the next control byte appears at the
same time the LSB is being clocked out of the ADS8344
(see Figure 3). This method allows for maximum throughput
and 24 clock cycles per conversion.
*/
  
  void wait_adc_free() {
      
      MAKE_ADCBUSY_INPUT();
/*      while(1){
      	if(GET_ADCBUSY_DATA()==0x1) {break;}
		TOSH_uwait(5);
      }
      
      while(1){
      	if(GET_ADCBUSY_DATA()!=0x1) {break;}
		TOSH_uwait(5);     	
      }
 */
    pulse_clock();  
      return;  	  	
  	}

  char read_bit() {
      uint8_t i;
      
      MAKE_DOUT_INPUT();
      pulse_clock();
      i = GET_DOUT_DATA();

      return i;
  }
  
  void setChannel(uint8_t channel)
  {
  
   switch(channel)	
   { 
   	default:
   	case 0:
   		ctlByte = 0x87;
     	break;
	 case 1:
	 	ctlByte = 0xC7;
     	break;
     case 2:
	 	ctlByte = 0x97;     
     	break;
     case 3:
	 	ctlByte = 0xD7;     
     	break;
   	}
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
  
  void ctrlbyte_write(char c) { 
      uint8_t i;
      MAKE_DIN_OUTPUT();
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
	return;
  } 
 
 // need to change to round-robin fasion 
   void task adc_get_data(){
   	
     uint8_t myIndex;
     uint8_t count;
     uint16_t my_bitmap;
     atomic { my_bitmap = adc_bitmap; }     
//    if(state != IDLE) {
//    	if(my_bitmap) {    post adc_get_data();    } // Try next time
//    	return; 
//    	}

     adcVal=0;    
     state=START_CONVERSION_PROCESS; 

     //it gaurantees a round robin fair scheduling of ADC conversions.
     count=0;
     myIndex=curPort+1;
     if(myIndex > MAX_CHNNELS) myIndex=0;
     while(!testbit(my_bitmap,myIndex))
       {
         myIndex++;
         if(myIndex > MAX_CHNNELS) myIndex=0;
         count++;
         if(count > MAX_CHNNELS) {state=IDLE; return; }   //no one waiting for conversion
       }

     curPort=myIndex;
     setChannel(curPort);
     state = SAMPLING;
 
 // send control byte to ads8344 to start conversion   	
   	ctrlbyte_write(ctlByte);

 // wait for one clock to make MSB decision
//   	wait_adc_free();
   	
   	adcVal = adc_read();
    atomic clrbit(adc_bitmap,curPort);   	
    state = IDLE;   
    if(adc_bitmap) {    post adc_get_data();    } // check if other channel in request
   	signal ADConvert.dataReady[curPort](adcVal);
   	
   	}

/* When power is first applied to the ADS8344, the user must
set the desired clock mode. It can be set by writing PD1
= 1 and PD0 = 0 for internal clock mode or PD1 = 1 and PD0
= 1 for external clock mode. After enabling the required
clock mode, only then should the ADS8344 be set to powerdown
between conversions (i.e., PD1 = PD0 = 0). The
ADS8344 maintains the clock mode it was in prior to
entering the power-down modes.
*/

// pins definition
// Vsensor <-> pin 12 (VCC1) <-> pin 20 (VCC2) <-> pin 10 (SHDN)

command result_t StdControl.init() {

// init params
  state = IDLE;
  adc_bitmap=0;
return SUCCESS;
	}

command result_t StdControl.start() {

   MAKE_CLOCK_OUTPUT();
   return SUCCESS;  
}

command result_t StdControl.stop() {

  	state = IDLE;
		adc_bitmap=0;  	
		return SUCCESS;  	
}

 command result_t ADConvert.getData[uint8_t port]()
 {
		uint8_t tmp_port;
		tmp_port = port;
   	if (tmp_port>7) return FAIL;
   	atomic setbit(adc_bitmap,tmp_port);
   	post adc_get_data();
   	return SUCCESS;
 }

 default event result_t ADConvert.dataReady[uint8_t port](uint16_t data)
 {
 	return SUCCESS;
 }


  
}
