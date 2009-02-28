/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: CounterM.nc,v 1.1.4.1 2007/04/27 05:13:27 njain Exp $
 */
 
/*
 *
 * Authors:   Mohammad Rahimi mhr@cens.ucla.edu
 * History:   created 08/14/2003
 *
 * High speed counter channel
 * Also detects the presence of the Board.For plug and play application.
 */

module CounterM {
    provides {
        interface StdControl as CounterControl;
        interface Dio as Counter;
        command result_t Plugged();
    }
    uses {
        interface Leds;
    }
}

implementation {

#define INT_ENABLE()  sbi(EIMSK , 5)
#define INT_DISABLE() cbi(EIMSK , 5)

    uint16_t count;
    uint8_t state;
    uint8_t mode;
    result_t boardConnected;

    command result_t CounterControl.init() {
        char c;
        INT_DISABLE();
        TOSH_MAKE_PW4_OUTPUT();
        TOSH_CLR_PW4_PIN();
        TOSH_uwait(1);
        c =(inp(PINE) >> 5) & 0x1;          //PORTE pin 5
        TOSH_SET_PW4_PIN();
        TOSH_uwait(1);
        if(c == ((inp(PINE) >> 5) & 0x1) ) boardConnected=FALSE;
        else boardConnected=TRUE;
        TOSH_CLR_PW4_PIN();
        atomic {
        mode=RISING_EDGE;
        count=0;
        state=0;
        }
        cbi(DDRE,5);            //Making INT pin input
        sbi(PORTE,5);           //and pull-up so that when the board is not there still operates
        //cbi(EICRB,ISC50);       //Making INT sensitive to falling edge
        //sbi(EICRB,ISC51);

        return SUCCESS;
    }
    
    command result_t CounterControl.start() {
        TOSH_CLR_PW4_PIN();
        atomic {
        count=0;
        state=0;
        }
        INT_ENABLE();
        return SUCCESS;
    }
    
    command result_t CounterControl.stop() {
        INT_DISABLE();
     return SUCCESS;
    }
    
  command result_t Counter.setparam(uint8_t modeToSet)
      {    
          //The available INT that is IN0-INT4 are not configurable
          //io is always input
          atomic{
          mode=modeToSet;
            if( ((mode & RISING_EDGE) == 0) & ((mode & FALLING_EDGE) == 0) ) 
                mode |= RISING_EDGE;
          }
          return SUCCESS;  
      }
  command result_t Plugged(){
      return boardConnected;
  }
  
  command result_t Counter.high()
      {
          return SUCCESS;
      }
  
  command result_t Counter.low()
      {
          return SUCCESS;
      }

  command result_t Counter.Toggle()
      {
          return SUCCESS;
      }
  
  command result_t Counter.getData()
      {             
            uint16_t counter;
            atomic { 
                counter = count;
                if(RESET_ZERO_AFTER_READ & mode) count=0;
            }
            signal Counter.dataReady(counter);
            return SUCCESS;
      } 
  
  default event result_t Counter.dataReady(uint16_t data) 
      {
           return SUCCESS;
      } 
  
  task void count_ready()
      {
            uint16_t counter;
            atomic { 
                counter = count;
            }
          signal Counter.dataReady(counter);
      }

  TOSH_SIGNAL(SIG_INTERRUPT5)
      {           
          atomic {
              //INT_DISABLE();
          if(state==0){
               TOSH_CLR_PW4_PIN();
               state=1;
               if(mode & FALLING_EDGE) {
                   count++;
                   if(EVENT & mode) post count_ready();
               }
           }
           else {
               TOSH_SET_PW4_PIN();
               state=0;
               if(mode & RISING_EDGE) {
                   count++;
                   if(EVENT & mode) post count_ready();
               }
           }
          //INT_ENABLE();
          }
           return;
      }      
}
