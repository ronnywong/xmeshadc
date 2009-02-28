/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: DioM.nc,v 1.2.4.2 2007/04/27 05:13:53 njain Exp $
 */
 
/* 
 * $Id: DioM.nc,v 1.2.4.2 2007/04/27 05:13:53 njain Exp $
 * 
 *
 * Authors:   Mohammad Rahimi mhr@cens.ucla.edu
 * History:   created 08/14/2003
 * History:   modified 11/14/2003
 *
 * driver for PCF8574APWR on mda320ca
 *
 */

module DioM {
    provides {
        interface StdControl;
        interface Dio[uint8_t channel];
    }
    uses {
        interface StdControl as I2CPacketControl;
        interface Leds;
        interface I2CPacket;
    }
}

implementation {

  //Note we have no async code here so there is no possibility of any race condition

  uint8_t state;      //keep state of our State Machine 
  uint8_t io_value;         //keep track of what is actually on the chip
  uint8_t mode[8];      //keep track of the mode of each channel
  uint16_t count[8];   //we can count the number of pulses 
  uint8_t bitmap_high,bitmap_low,bitmap_toggle;   //the param setting we get this is for channel number
  uint8_t i2c_data;    //the data read from the chip
  uint8_t intflag=0;
  uint8_t i2cwflag=0;
  uint8_t i2crflag=0;

#define XOR(a,b)  ((a) & ~(b))|(~(a) & (b))

    //set of bitwise functions
#define  testbit(var, bit)   ((var) & (1 <<(bit)))      //if zero then return zero and if one not equal zero
#define  setbit(var, bit)    ((var) |= (1 << (bit)))
#define  clrbit(var, bit)    ((var) &= ~(1 << (bit)))

    //Interrupt definition
#define INT_ENABLE()  sbi(EIMSK , 4)
#define INT_DISABLE() cbi(EIMSK , 4)


    enum {GET_DATA, SET_OUTPUT_HIGH, SET_OUTPUT_LOW, SET_OUTPUT_TOGGLE , GET_THEN_SET_INPUT, IDLE , INIT};


    command result_t StdControl.init() {
          mode[0] = RISING_EDGE;
          mode[1] = RISING_EDGE;
          mode[2] = RISING_EDGE;
          mode[3] = RISING_EDGE;
          mode[4] = RISING_EDGE;
          mode[5] = RISING_EDGE;
          mode[6]=DIG_OUTPUT;
          mode[7]=DIG_OUTPUT;
          io_value=0xff;         //set all inputs to high and relays OFF (we know chip boots to 0xff)
          state=INIT;             
        call I2CPacketControl.init();
        return SUCCESS;
    }
    


    task void init_io()
      {
      		 atomic i2crflag=1;
           if(call I2CPacket.readPacket(1,0x03) == FAIL)
             {
		      		 atomic i2crflag=0;
               post init_io();
             }        
      }
      
    task void read_io();

    command result_t StdControl.start() {
        cbi(DDRE,4);            //Making INT pin input
        //cbi(EICRB,ISC40);       //Making INT sensitive to falling edge
        //sbi(EICRB,ISC41);
        //INT_ENABLE();           //probably bus is stable and now we are ready 
        post init_io();
        return SUCCESS;
    }
    
    command result_t StdControl.stop() {
     return SUCCESS;
    }
        
    command result_t Dio.setparam[uint8_t channel](uint8_t modeToSet)
        {    
            //we only set INT flag if we set any channel to input otherwise we do not touch it.
            mode[channel]=modeToSet;
            if( ((modeToSet & RISING_EDGE) == 0) & ((modeToSet & FALLING_EDGE) == 0) ) mode[channel] |= RISING_EDGE;
            if((modeToSet & DIG_LOGIC)!=0)
            {
            	if(intflag==0)
            	{
            		state=IDLE;
            		post read_io();
            	}
            }
            return FAIL;
        }
    
    task void set_io_high()
      {
        uint8_t status;
        uint8_t i;
        status = FALSE;
        if(state==IDLE) state= SET_OUTPUT_HIGH; 
        else { status=TRUE; post set_io_high(); }
        if(status==TRUE) return; 
        i2c_data=io_value;
        for(i=0;i<=7;i++) {
          if(testbit(bitmap_high,i)) {    
            setbit(i2c_data,i);
          }
          if(!(mode[i] & DIG_OUTPUT)) setbit(i2c_data,i);           //if we set them to High as week input
        }
        //we should leave inputs as high and outputs either high or low
        atomic i2cwflag=1;
        if( (call I2CPacket.writePacket(1,(char*) &i2c_data, 0x01)) == FAIL)
          {
		        atomic i2cwflag=0;
            state=IDLE;
            post set_io_high();
          }
        else bitmap_high=0x0;
      }
    
    task void set_io_low()
      {
        uint8_t status;
        uint8_t i;
        status = FALSE;
        if(state==IDLE) state= SET_OUTPUT_LOW; 
        else { status=TRUE; post set_io_low(); }
        if(status==TRUE) return; 
        i2c_data=io_value;
        //we should leave inputs as high and outputs either high or low
        for(i=0;i<=7;i++) {
          if(testbit(bitmap_low,i)) {
            clrbit(i2c_data,i);
          }
          if(!(mode[i] & DIG_OUTPUT)) setbit(i2c_data,i);             //if we set them to High as week input
        }
        atomic i2cwflag=1;
        if( (call I2CPacket.writePacket(1,(char*) &i2c_data, 0x01)) == FAIL)
          {
		        atomic i2cwflag=0;
            state=IDLE;
            post set_io_low();
          }
        else bitmap_low=0x0;
      }
    
    task void set_io_toggle()
      {
        uint8_t i;
        if(state==IDLE) state= SET_OUTPUT_TOGGLE; 
        else { post set_io_toggle(); return; }
        i2c_data=io_value;
        //we should leave inputs as high and outputs either high or low
        for(i=0;i<=7;i++) {
          if(testbit(bitmap_toggle,i)) {
            if (testbit(i2c_data,i)) {
              clrbit(i2c_data,i);
            } else {
              setbit(i2c_data,i);
            }
          }
          if(!(mode[i] & DIG_OUTPUT)) setbit(i2c_data,i);            //if we set them to High as week input
        }
        atomic i2cwflag=1;                     
        if( (call I2CPacket.writePacket(1,(char*) &i2c_data, 0x01)) == FAIL)
          {
		        atomic i2cwflag=0;                     
            state=IDLE;
            post set_io_toggle();
          }
        else bitmap_toggle=0x0;
      }
    
    command result_t Dio.Toggle[uint8_t channel]()
      {
        if(DIG_OUTPUT & mode[channel])
          {
            setbit(bitmap_toggle,channel); 
            post set_io_toggle();
            return SUCCESS;
          }
        else return FALSE;
      }
    
    command result_t Dio.high[uint8_t channel]()
      {
        if(DIG_OUTPUT & mode[channel])
          {
            setbit(bitmap_high,channel);            
            post set_io_high();
            return SUCCESS;
          }
        else return FALSE;
      }
    
    command result_t Dio.low[uint8_t channel]()
      {
        if(DIG_OUTPUT & mode[channel])
          {
            setbit(bitmap_low,channel);
            post set_io_low();
            return SUCCESS;
          }
        else return FALSE;
      }
    
    command result_t Dio.getData[uint8_t channel]()
      {    
        uint16_t counter;
        counter = count[channel];
        if(RESET_ZERO_AFTER_READ & mode[channel]) {count[channel]=0;}
        signal Dio.dataReady[channel](counter);
        return SUCCESS;
      } 
    
    default event result_t Dio.dataReady[uint8_t channel](uint16_t data) 
        {
            return SUCCESS;
        } 
    /*        
    command result_t Dio.getValue[uint8_t channel]()
      {    
        bool value;
        value = (testbit(io_value,channel) != 0);
        signal Dio.valueReady[channel](io_value);
        return SUCCESS;
      } 
    */

    task void read_io()
        {
           uint8_t status;
           status = FALSE;
               if(state==IDLE) state=GET_DATA; 
               else { status=TRUE; post read_io(); }
           if(status==TRUE) return; 
           	atomic i2crflag=1;
           if(call I2CPacket.readPacket(1,0x03) == FAIL)
               {
							           	 atomic i2crflag=0;
                           state=IDLE;
                           post read_io();
               }
        }

    event result_t I2CPacket.writePacketDone(bool result) {
    	  if(i2cwflag==0) return SUCCESS;
    	  atomic i2cwflag=0;
        if(result) {
            if ( state == SET_OUTPUT_HIGH || state == SET_OUTPUT_LOW || state == SET_OUTPUT_TOGGLE) {
              //io_value=i2c_data;
              state = IDLE;
              //INT_DISABLE();
              //if(!post read_io()) INT_ENABLE();

            }
        }
        return SUCCESS;
    }
    
    event result_t I2CPacket.readPacketDone(char length, char* data) {
       uint8_t ChangedState;
       int i;
       if(i2crflag==0) return SUCCESS;
       atomic i2crflag=0;
       i2c_data=*data;
       if (length != 1)
           {
             state = IDLE;
               INT_ENABLE();
               return FALSE;
           } 

       
       if(state==INIT)
         {
             io_value=i2c_data;
             state=IDLE;
             INT_ENABLE();
         }
       
       if(state==GET_DATA) {
         intflag=1;
         ChangedState = XOR(io_value,i2c_data);     //see those one who has changed               
         for(i=0;i<8;i++){
           if( !( mode[i] & DIG_OUTPUT) ){       //we only care about channels which are not output (input channels)
             if((mode[i] & DIG_LOGIC))
             {
                 if(testbit(i2c_data,i)!=0)    
                    count[i]=1;
                 else
                    count[i]=0;
                 signal Dio.dataReady[i](count[i]);
                 continue;
             }
             if(testbit(ChangedState,i)) {       //find the channels which are realy changed
               if( mode[i] & RISING_EDGE )
                 {
                   if(testbit(io_value,i)==0 && testbit(i2c_data,i)!=0) { 
                     if(EVENT & mode[i]) signal Dio.dataReady[i](count[i]);
                     //                           if (count[i] == 0xffff) signal Dio.dataOverflow[i]();
                     count[i]++; 
                   }
                 }
               if( mode[i] & FALLING_EDGE )
                 {
                   if(testbit(io_value,i)!=0 && testbit(i2c_data,i)==0) {
                     if(EVENT & mode[i]) signal Dio.dataReady[i](count[i]);
                     //                           if (count[i] == 0xffff) signal Dio.dataOverflow[i]();
                     count[i]++;
                   }
                 }
             }               
           }
         }
           io_value=i2c_data;
           INT_ENABLE();
           state = IDLE;
       }
       return SUCCESS;
    }
                
   TOSH_SIGNAL(SIG_INTERRUPT4)
       {
         INT_DISABLE();
         if(!post read_io()) INT_ENABLE();
         return;
       }   

}
