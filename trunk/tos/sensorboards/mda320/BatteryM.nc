/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: BatteryM.nc,v 1.1.4.1 2007/04/27 05:13:11 njain Exp $
 */
 
/*
 *
 * Authors:   Mohammad Rahimi mhr@cens.ucla.edu
 * History:   created 08/14/2003
 *
 * Note:This components return the battery voltage * 100 so u should have a resolution of
 * about 0.01V in the measurement.
 *
 * NOTE THAT JTAG SHOULD BE DISABLED FOR THIS COMPONENT TO WORK.
 * This is beacause of a hardware problem.U should get the laest version of uisp(u can get it
 * from tinyos website  and try to run
 * fuse_dis--->"uisp -dprog=dapa --wr_fuse_h=0xD9"
 * fuse_en --->"uisp -dprog=dapa --wr_fuse_h=0x19"
 */

module BatteryM {
  provides interface StdControl;
  provides interface ADConvert as Battery;
  uses {
    interface ADCControl;
    interface ADC;
  }
}

implementation {

#define MAKE_BAT_MONITOR_OUTPUT() sbi(DDRA, 5)
#define MAKE_ADC_INPUT() cbi(DDRF, 5)
#define SET_BAT_MONITOR() sbi(PORTA, 5)
#define CLEAR_BAT_MONITOR() cbi(PORTA, 5)

void delay() {
    asm volatile  ("nop" ::);
    asm volatile  ("nop" ::);
    asm volatile  ("nop" ::);
    asm volatile  ("nop" ::);
}
    
  command result_t StdControl.init() {
#ifdef PLATFORM_MICA2
      MAKE_BAT_MONITOR_OUTPUT();
      MAKE_ADC_INPUT();
#endif
      call ADCControl.bindPort(TOS_ADC_VOLTAGE_PORT,TOSH_ACTUAL_VOLTAGE_PORT);
    return call ADCControl.init();
  }
  command result_t StdControl.start() {
    return SUCCESS;
  }

  command result_t StdControl.stop() {
      return SUCCESS;
  }

command result_t Battery.getData(){
      //MAKE_ADC_INPUT();
#ifdef PLATFORM_MICA2
      SET_BAT_MONITOR();      
      delay();
#endif
      return call ADC.getData();
  }
    
command result_t Battery.getContinuousData(){
      return call ADC.getContinuousData();     
  }
  
default event result_t Battery.dataReady(uint16_t data) {
      return SUCCESS;
  }

async event result_t ADC.dataReady(uint16_t data){

#ifdef PLATFORM_MICA2
  	CLEAR_BAT_MONITOR();  
#endif
     	signal Battery.dataReady(data);
	return SUCCESS;
   }

}
