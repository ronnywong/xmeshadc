/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: DIPSwitchM.nc,v 1.1.4.1 2007/04/27 05:32:08 njain Exp $
 */
 
/*
 * $Log: DIPSwitchM.nc,v $
 * Revision 1.1.4.1  2007/04/27 05:32:08  njain
 * CVS: Please enter a Bugzilla bug number on the next line.
 * BugID: 1100
 *
 * CVS: Please enter the commit log message below.
 * License header modified in each file for MoteWorks_2_0_F release
 *
 * Revision 1.1  2006/01/05 09:14:56  pipeng
 * move mtp400 from xdev to MoteWorks.
 *
 * Revision 1.2  2005/09/16 10:41:30  husq
 * Update licence and rearange chan order
 * 
 */
/*
 * Description:
 *
 * driver for DIP Switch on mtp400ca
 *
 * PW5 control the power of DIP Switch
 * PB5 indicate the sensor type {RTD, CT} of Channel 1
 * PB6 indicate the sensor type {RTD, CT} of Channel 2
 * PE2 indicate the sensor type {RTD, CT} of Channel 3
 * 
 * 
 * Authors: Hu Siquan <husq@xbow.com>
 *
 * $Id: DIPSwitchM.nc,v 1.1.4.1 2007/04/27 05:32:08 njain Exp $  
 */


module DIPSwitchM
{
    provides interface DIP; 
    uses interface  Timer as PowerUpTimer; 
}
implementation
{

  enum { IDLE, POWER_UP, READING };
  
  char state = IDLE;    /* current state of DIP switch */

// power control assignments
TOSH_ASSIGN_PIN(PB5, B, 5);
TOSH_ASSIGN_PIN(PB6, B, 6);
TOSH_ASSIGN_PIN(PE2, E, 2);
 
    // hardware pin functions
  char GET_CH1_SNS_TYPE() { return TOSH_READ_PB5_PIN(); }
  char GET_CH2_SNS_TYPE() { return TOSH_READ_PB6_PIN(); }
  char GET_CH3_SNS_TYPE() { return TOSH_READ_PE2_PIN(); }
 
  command result_t DIP.getSensorType() {
      if (state == IDLE) {
        state = POWER_UP;
				TOSH_SET_PW5_PIN();
				call PowerUpTimer.start(TIMER_ONE_SHOT,10);              
       	return SUCCESS;
      }
      return FAIL;
  }
  
  event result_t PowerUpTimer.fired(){
  	char dip_status;
  	state = READING;
  	dip_status =  0x1 & GET_CH1_SNS_TYPE();
  	dip_status +=  (0x1 & GET_CH2_SNS_TYPE())<<1;
  	dip_status +=  (0x1 & GET_CH3_SNS_TYPE())<<2; 
		TOSH_CLR_PW5_PIN();  	 
  	signal DIP.sensorTypeReady(dip_status); 
  	state = IDLE;	  
  	return SUCCESS; 	
  	}
  
  default event result_t DIP.sensorTypeReady(char data) {
  	
     return SUCCESS;  	
  	}

  
}
