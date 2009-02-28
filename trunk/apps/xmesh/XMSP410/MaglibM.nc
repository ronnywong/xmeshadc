/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: MaglibM.nc,v 1.2.4.1 2007/04/26 20:14:42 njain Exp $
 */


/******************************************************************************
 * MagLibM
 *  - Nulls magx and magy digital pots on startup so that signal is between
 *    MAGMAX and MAGMIN
 *  - The digital pots that control the bias offset have the following specs:
 *    - output between 0.5 -> 2.5 volts (2000 mv range)
 *    - resolution of 255 steps => 2000mv/255steps = 7.8mv/step
 *    - there is a post gain after the pot of about 80x
 *    - so each pot step generate 7.8*80 mv = ~625 mv/step at the Atemga adc input
 *    - the Atemga adc spans about 3.0 volts or about 3mv/bit (10 bit adc)
 *    - so each pot step generates about 210 adc bit change
 *  - Measures magx and magy every timer interval (INTRVL_MEAS).
 *  - Updates to application are posted INTRVAL_MEAS*2
 *  - A running average of each signal is maintained over last 2^^MAGAVECNT 
 *    timer intervals * 2. For 5msec timer, MAGAVECNT = 6, this is 640msec.
 *
 *  - Digital pots updates while measuring mags:
 *    - When the pot is changed this generates a very large bias change
 *    - Pot changes should not occur for large transient magnetic fields
 *    - Pot changes should occur for large peremenant magnetic field.
 *    - Strategy to update pot:
 *      - If magx_avg, magy_avy outside window then inc/dec pot
 *      - Wait for mag_avg to clear before another inc/dec
 *      - magx_dead_cnt, magy_dead_cnt tracks dead time before another pot change
 *      - magx_dead = 2^^MAGAVECNT 
 ******************************************************************************/


#define INTRVL_MEAS   5      //mag measurement interval (msec)
#define MAGAVECNT 6          //control running average
#define NULL_DEAD_CNTS 16    //only update pots 1 of every NULL_DEAD_CNTS
#define RADIO_DEAD_CNTS 16   //# of samples to wait after radio has xmitted
#define POTAJST_DEAD_CNTS 16  //min interval between pot adjusts
 
// define upper and lower ADC limits to adjust mag bias
// if MAGMAX-MAGMIN = 400 adc counte then this corresponds to about 2 pot steps
#define MAGMAX 700
#define MAGMIN 300



includes sensorboard;
module MaglibM 
{
  provides interface StdControl;
  provides interface Maglib;
  uses 
  {
    interface ADCControl;
    interface StdControl as PotControl;
    interface Mag;
    interface Timer;
	interface ADC as MagX;
	interface ADC as MagY;
//	interface RadioPower;
   }
}
implementation 
{

  #define SO_NO_DEBUG 0   // 1 => turn off debug printf
  #include "SODebug.h"
  

enum{                     //enums for I2C digital pot
 POT_IDLE = 0,            //not busy
 POT_BUSY = 1,            //busy
};

enum{                       //enum to control measurement state
 MAGXSENSE  =9,             //process x mag data
 MAGYSENSE  =10,            //process y mag data
 MAGXDCNULL =21,            //null x mag signal
 MAGYDCNULL =22,            //null y mag signal
};

enum{
  IDLE =  0,
};

  norace uint8_t state;
  uint8_t samplecount;
  long magy_sum;  // accumulator for average
  long magx_sum;  // accumulator for average
  long magx_avg;  // floating average for detects
  long magy_avg;  // floating average for detects
  
  uint8_t  MagDCx;          // dc offset for x
  uint8_t  MagDCy;          // dc offset for y
  uint16_t magx_dead_cnt;   // dead time cnts between pot changes
  uint16_t magy_dead_cnt;   // dead time cnts between pot changes
  bool bmagx_pot_change;    // true if magx pot being changed
  bool bmagy_pot_change;    // true if magx pot being changed
  bool bAutoBias;           //enable/disable pot changes
  uint8_t  pot_state;
  uint8_t  radio_dead_cnts; //cnts number of timter counts before adc reenable
  bool bRadioDeadTime;
  norace uint16_t magx_data;   //last magx data
  norace uint16_t magy_data;   //last magy data
/*******************************************************/
/* local functions  */
/*******************************************************/

/******************************************************
 * magX_null
 *  - called only during start-up phase
 *  -if magx data out of tracking limit then adjust
 *   DC offset pot
 *  - offset has very slow reponse, ~40msec
 *  - this routine called every 10 msec use 1 of
 *    8 readings before making a pot change
 *  -stay in this mode until adjust within limits
 *  -then do MAGYNULL
 ******************************************************/ 
  task void magX_null()
  {

    samplecount++;
    if (samplecount < NULL_DEAD_CNTS)return;
    magx_avg = magx_data;
    samplecount = 0;
   // SODbg(DBG_USR2, "magx_avg : %i  data: %i \n",magx_avg,magx_data);

    if (magx_avg > MAGMAX) // too positive
    {
      MagDCx ++;                        //asb
      pot_state = POT_BUSY;
      //SODbg(DBG_USR2, "magXnull data: %i magx_sum: %i MagDCx %i  \n",magx_data,magx_avg,MagDCx);
      call Mag.DCAdjustX(MagDCx);
      return;
    }
    if (magx_avg < MAGMIN) // too negative
    {
	  MagDCx --;                         //asb
	  pot_state = POT_BUSY;
      SODbg(DBG_USR2, "magXnull data: %i magx_sum: %i MagDCx %i  \n",magx_data,magx_avg,MagDCx);
      call Mag.DCAdjustX(MagDCx);
	  return;
    }
    
	// offset in tolerance
      SODbg(DBG_USR2, "magXnull - null done data: %i  MagDCx %i  \n",magx_data,MagDCx);
   
	  magx_avg = magx_data;
      magx_sum = magx_avg<<MAGAVECNT;

	  atomic {state = MAGYDCNULL;}
	  samplecount = 0;
	  return;
  }

/*******************************************************/

  task void magY_null()
  {

    samplecount++;
    if (samplecount < NULL_DEAD_CNTS)return;
    atomic {magy_avg = magy_data;}
    samplecount = 0;
    //SODbg(DBG_USR2, "magy_avg : %i  data: %i \n",magy_avg,magy_data);


    if (magy_avg > MAGMAX) // too positive
    {
      MagDCy++;
      pot_state = POT_BUSY;
	  SODbg(DBG_USR2, "magYnull data: %i magy_sum: %i MagDCy %i  \n",magy_data,magy_sum,MagDCy);
      call Mag.DCAdjustY(MagDCy);
      return;
	}
    if (magy_avg < MAGMIN) // too negative
    {
      MagDCy--;
	  pot_state = POT_BUSY;
      SODbg(DBG_USR2, "magYnull data: %i magy_sum: %i MagDCy %i  \n",magy_data,magy_sum,MagDCy);
	  call Mag.DCAdjustY(MagDCy);
      return;
	}
      
	  SODbg(DBG_USR2, "magYnull - null done data: %i  MagDCy %i  \n",magy_data,MagDCy);
	  magy_avg = magy_data;

      magy_sum = magy_avg<<MAGAVECNT;
	  atomic {state = MAGYSENSE;}

    return;
  }
/*****************************************************************************/
  task void SignalData(){
   	signal Maglib.MagxReady(magx_data);
    signal Maglib.MagyReady(magy_data);
	return;
  }
/*****************************************************************************
 * magX_sense - chk for pot adjust
 * - if bAutoBias = FALSE then application commands no pot changes
 * - only allow changes to pot when magx_dead_cnt expires
 * - if pot change then
 *   - notify application of impending bias change
 *   - set bmagx_pot_change = TRUE
 *   - if bmagx_pot_change = TRUE then don't send to false until changes done
 *     and notify application level 
 *****************************************************************************/
  task void magX_sense()
  {
    bool bUpdatePot = FALSE;
    long max_dead_cnt = POTAJST_DEAD_CNTS;

    atomic {state = MAGYSENSE;}
    if (!bAutoBias) return;

	magx_sum -= magx_avg;
    magx_sum += magx_data;
	magx_avg = magx_sum>>MAGAVECNT;

	magx_dead_cnt++;
	if (magx_dead_cnt > max_dead_cnt)magx_dead_cnt = 0;
    else return;

    if ((magx_avg > MAGMAX) && (MagDCx < 255)){
	   MagDCx++;
       bUpdatePot = TRUE;
    }
    if ((magx_avg < MAGMIN) && (MagDCx > 0)){
	   MagDCx--;
       bUpdatePot = TRUE;        
    }
    if (bUpdatePot){ 
	    magx_dead_cnt = 0;
        pot_state= POT_BUSY;
        bmagx_pot_change = TRUE;
		signal Maglib.biasx_change(MagDCx);
        call Mag.DCAdjustX(MagDCx);
		
    }
	else{
	    if (bmagx_pot_change){
    	   signal Maglib.biasx_changedone(MagDCx); 
           bmagx_pot_change = FALSE;
        }
          
    }   	
    return;
  }

/*******************************************************/
  task void magY_sense()
  {
    bool bUpdatePot = FALSE;
    long max_dead_cnt = POTAJST_DEAD_CNTS;
   
    magy_sum -= magy_avg;
    magy_sum += magy_data;
	magy_avg = magy_sum>>MAGAVECNT;

	magy_dead_cnt++;
	if (magy_dead_cnt > max_dead_cnt)magy_dead_cnt = 0;

    if (bAutoBias && (magy_dead_cnt == 0)){
      if ((magy_avg > MAGMAX) && (MagDCy < 255)){
		MagDCy++;
        bUpdatePot = TRUE;
      }
      if ((magy_avg < MAGMIN) && (MagDCy > 0)){
	    MagDCy--;
        bUpdatePot = TRUE;
      }
      if (bUpdatePot){ 
	    magy_dead_cnt = 0;
        pot_state= POT_BUSY;
		bmagy_pot_change = TRUE;
		signal Maglib.biasy_change(MagDCy);
        call Mag.DCAdjustY(MagDCy);
      }
      else{
	    if (bmagy_pot_change){
    	   signal Maglib.biasy_changedone(MagDCy); 
           bmagy_pot_change = FALSE;
        }
      }
    }
    atomic {state = MAGXSENSE;}
    post SignalData();
    
  }
/*******************************************************/
/* tos commands  */
/*******************************************************/
  command result_t StdControl.init() 
  {
    return SUCCESS;
  }
  command result_t StdControl.start() 
  {
    return SUCCESS;
  }
  command result_t StdControl.stop() 
  {
    return SUCCESS;
  }
/*****************************************************/
  command result_t Maglib.mag_measure()
  {

    MagDCx = 128;
	MagDCy = 128;
	
    
	atomic{
     bAutoBias = TRUE;
     state = MAGXDCNULL;
    }
	call Mag.On();
	MagDCx = 125;
	MagDCy = 125;
    samplecount = 0;
	call Mag.SetReset();
    magx_avg = 512;
	magy_avg = 512;
	magx_sum = 0;
	magy_sum = 0;
    magx_dead_cnt =0;
	magy_dead_cnt =0;
	radio_dead_cnts = 0;   
    bmagx_pot_change = FALSE;
    bmagy_pot_change = FALSE;
    bRadioDeadTime = FALSE;
  	call Timer.start(TIMER_REPEAT, INTRVL_MEAS);
    return SUCCESS;
  }

  command result_t Maglib.mag_stop()
  {
	call Mag.Off();
    return SUCCESS;
  }

/*****************************************************/
/*  mag_bias_stop : stops the auto bias tracking function
/*****************************************************/
  command result_t Maglib.mag_bias_stop(){
   atomic{
     bAutoBias = FALSE;
   }
   return SUCCESS;
}
/*****************************************************/
/*  mag_bias_start : restarts the auto bias tracking function
/*****************************************************/
  command result_t Maglib.mag_bias_start(){
  atomic{
    bAutoBias = TRUE;
  }
  return SUCCESS;
}
/*****************************************************/


/*****************************************************/
/*  event handlers                                   */
/*****************************************************/

  async event result_t MagX.dataReady(uint16_t  data)
  {
    magx_data = data;
	call MagY.getData();      
	return SUCCESS;
  }

/**********************************************/
  async event result_t MagY.dataReady(uint16_t  data)
  {
    magy_data = data;

    switch (state) {
	  case MAGXDCNULL: post magX_null();
	                   break;
	  case MAGXSENSE:  post magX_sense();
                       break;
      case MAGYDCNULL: post magY_null();
                       break;
      case MAGYSENSE:  post magY_sense();
	                   break;
    }

	return SUCCESS;
  }
/**********************************************/

  event result_t Mag.DCAdjustXdone(result_t ok)
  {
    pot_state = POT_IDLE;
    return ok;
  }

  event result_t Mag.DCAdjustYdone(result_t ok)
  {
    pot_state = POT_IDLE;
	return ok;
  }

/**********************************************************/
  event result_t Timer.fired() 
  {
   // SODbg(DBG_USR2, "Maglib timer: state: %i magxstate: %i  magystate: %i  \n", state,magxstate,magystate);
    if (pot_state == POT_BUSY) return SUCCESS;
    
/*	if (call RadioPower.GetTransmitState() == 1){         //radio xmitting?
	    bRadioDeadTime = TRUE;
	    radio_dead_cnts = 0;
		return SUCCESS;             //exit if radio is transmitting
	}
	else{
	  if (bRadioDeadTime){
	    radio_dead_cnts++;
        if( radio_dead_cnts > RADIO_DEAD_CNTS)bRadioDeadTime = FALSE;		    
	  }  
	  if (!bRadioDeadTime) */
	  call MagX.getData();
	  //else SODbg(DBG_USR2, "Maglib timer: RadioXmit %i  \n",radio_dead_cnts);
//    }
    return SUCCESS;


  }


}

