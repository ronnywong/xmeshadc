/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: XMTS420M.nc,v 1.1.2.5 2007/04/26 20:20:45 njain Exp $
 */

/**
 * XSensor multi-hop application for MTS420 sensorboard.
 *
 *
 * Measures MTS400/420 weatherboard sensors & gps and converts to engineering
 * units were possible.
 *-----------------------------------------------------------------------------
 * Output results through mesh network to BaseStation(nodeid:0)
 * Use Xlisten.exe program to view data from nodeid:0's uart port:
 *        mount mica2 with nodeid:0 on mib510 with MTS400/420
 *        Turn on other nodes to connect as a mesh netwrok
 *        connect MIB510 through serial cable to PC
 *        run xlisten.exe on PC at 57600 baud
 *-----------------------------------------------------------------------------
 * NOTES:
 * -Intersema pressure sensor control lines are shared with gps control lines
 * -Cannot enable gps rx/tx and intersema at same time
 *
 * - gps is always enabled, work for both  MTS420  and MTS400 sensor boards.
 * - if gps not present (MTS400) then additional ~2sec gps timeout will occur
 *
 * Strategy:
 * 1. Turn on gps power and leave on
 * 2. sequentially read  all weather sensors (green led on).
 *    - xmit weather sensor data
 * 3. get gps packet (red led on):
 *    - enable gps Rx,Tx lines to cpu
 *    - wait up to 1 sec to receive a packet (toggle yellow if no pkt)
 *    - xmit gps packet
 *    - disable gps Rx,Rx lines
 * 4. repeat 2,3
 * NOTE:
 * No real power strategy; just turns sensors on sequentially, gps always on.
 * Need I2C BusArbitration routines for better power control
 *
 * @author Alan Broad, David M. Doolin, Hu Siquan, Mao Shifeng
 */

// gps.h file should eventually by split into
// a leadtek9546.h for the control of the gps
// hardware unit, and an nmea.h for handling
// the data going in and out of the unit.

#include "appFeatures.h"
includes XCommand;
#ifdef MTS420
includes gps;
#endif

module XMTS420M {
  provides interface StdControl;
#ifdef MTS420
  provides command void load_gps_struct();
  provides command result_t parse_gga_message(GPS_MsgPtr gps_data);
#endif
  
  uses {
//gps
#ifdef MTS420
    interface GpsCmd;
    interface StdControl as GpsControl;
//  interface BareSendMsg as GpsSend;
    interface ReceiveMsg as GpsReceive;
    interface Timer as GpsTimer;
#endif

// RF Mesh Networking
    interface MhopSend as Send;
    interface RouteControl;
    interface XCommand;
    interface XEEControl;
// Battery
    interface ADC as ADCBATT;
    interface StdControl as BattControl;

//Accels
    interface StdControl as AccelControl;
    interface I2CSwitchCmds as AccelCmd;
    interface ADC as AccelX;
    interface ADC as AccelY;

//Intersema
    interface SplitControl as PressureControl;
    //interface StdControl as PressureControl;
    interface ADC as IntersemaTemp;
    interface ADC as IntersemaPressure;
    interface Calibration as IntersemaCal;

//Sensirion
    interface SplitControl as TempHumControl;
    interface ADC as Humidity;
    interface ADC as Temperature;
    interface ADCError as HumidityError;
    interface ADCError as TemperatureError;
//Taos
    interface SplitControl as TaosControl;
    interface ADC as TaosCh0;
    interface ADC as TaosCh1;

    interface ADCControl;
    interface Timer;
    interface Leds;

#if FEATURE_UART_SEND
	interface SendMsg as SendUART;
	command result_t PowerMgrEnable();
	command result_t PowerMgrDisable();
#endif
    command void health_packet(bool enable, uint16_t intv);
    command HealthMsg* HealthMsgGet();
  }
}
implementation
{
  // This enum records the current state for the state machine
  // int Timer.fired();
  enum {START, BUSY, GPS_DONE};

  enum
  {
    SENSOR_NONE = 0,
    SENSOR_BATT_START = 10,

	  SENSOR_HUMIDITY_START = 20,
	  SENSOR_HUMIDITY_GETHUMDATA = 21,
	  SENSOR_HUMIDITY_GETTEMPDATA = 22,
	  SENSOR_HUMIDITY_STOP = 23,

	  SENSOR_PRESSURE_START = 30,
	  SENSOR_PRESSURE_GETCAL = 31,
	  SENSOR_PRESSURE_GETPRESSDATA = 32,
	  SENSOR_PRESSURE_GETTEMPDATA = 33,
	  SENSOR_PRESSURE_STOP = 34,

	  SENSOR_LIGHT_START = 40,
    SENSOR_LIGHT_GETCH0DATA = 41,
    SENSOR_LIGHT_GETCH1DATA = 42,
    SENSOR_LIGHT_STOP = 43,

    SENSOR_ACCEL_START = 50,
    SENSOR_ACCEL_GETXDATA = 51,
    SENSOR_ACCEL_GETYDATA = 52,
    SENSOR_ACCEL_STOP = 53,

#ifdef MTS420
    SENSOR_GPS_START =54,
    SENSOR_GPS_DONE=55
#endif
  };



// timer period in msec
//#define XSENSOR_SAMPLE_RATE 1000
// max wait time for gps packet = GPS_MAX_WAIT*TIMER_PERIOD
#define GPS_MAX_WAIT 10

  char count;
  norace uint32_t   timer_rate;
  bool       sleeping;	       // application command state

  uint16_t calibration[4];           // intersema calibration words
  norace uint8_t  main_state;        // main state of the schedule
  norace uint8_t  sensor_state;             // debug only


#ifdef MTS420
	bool gps_pwr_on;                // true if gps power on
	uint8_t gps_wait_cnt;           // cnts wait periods for gps pkt to arrive
	uint16_t gps_sleep_cnt;
 	uint8_t gps_work_factor;
	char gga_fields[GGA_FIELDS][GPS_CHAR_PER_FIELD]; // = {{0}};
#endif

  TOS_Msg msg_buf_radio;
  TOS_MsgPtr msg_radio;
  norace XDataMsg pack;
  HealthMsg *h_msg;
  norace uint8_t iNextPacketID;

  norace bool sending_packet,sensinginsession;

  // Zero out the accelerometer, chrl@20061208
  norace uint16_t accel_ave_x, accel_ave_y;
  norace uint8_t accel_ave_points;
  bool accel_ave_end;
//  uint8_t pressure_cnt;

//////////////////////////////////////////////////////////////////////////////////////////
  task void Battstop()
  {
  	call BattControl.stop();
  }
  task void TempHumstart()
  {
    call TempHumControl.start();
  }

  task void stopPressureControl()
  {
    atomic sensor_state = SENSOR_PRESSURE_STOP;
   	call PressureControl.stop();
   	return;
  }

  task void stopTempHumControl()
  {
   	atomic sensor_state = SENSOR_HUMIDITY_STOP;
  	call TempHumControl.stop();
   	return;
  }

  task void stopTaosControl()
  {
 	  atomic sensor_state = SENSOR_LIGHT_STOP;
 	  call TaosControl.stop();
 	  return;
  }

  task void powerOffAccel()
  {
    atomic sensor_state = SENSOR_ACCEL_STOP;
 	  call AccelCmd.PowerSwitch(0);                            //power off
    return;
  }

  task void send_radio_msg()
  {
    uint8_t i;
    uint16_t len;
    XDataMsg *data;

    // Fill the given data buffer.
    data = (XDataMsg *)call Send.getBuffer(msg_radio, &len);

    for (i = 0; i < sizeof(XDataMsg); i++)
	    ((uint8_t*)data)[i] = ((uint8_t*)&pack)[i];

	data->xmeshHeader.board_id  = SENSOR_BOARD_ID;
	data->xmeshHeader.packet_id = iNextPacketID;
	//data->xmeshHeader.node_id   = TOS_LOCAL_ADDRESS;
	data->xmeshHeader.parent    = call RouteControl.getParent();
	data->xmeshHeader.packet_id = data->xmeshHeader.packet_id | 0x80;

#if FEATURE_UART_SEND
  	if (TOS_LOCAL_ADDRESS != 0)
  	{
  	    call PowerMgrDisable();
  	    TOSH_uwait(1000);
  	    if (call SendUART.send(TOS_UART_ADDR, sizeof(XDataMsg), msg_radio) != SUCCESS)
  	    {
  		    atomic sending_packet = FALSE;
  		    call PowerMgrEnable();
  	    }
  	}
  	else
#endif
  	// Send the RF packet!
  	if (call Send.send(BASE_STATION_ADDRESS,MODE_UPSTREAM,msg_radio, sizeof(XDataMsg)) != SUCCESS)
  	{
  		call Leds.yellowOn();
  	    atomic
  	    {
  	    	sending_packet = FALSE;
  	    	main_state = START;
  	    }
  	}
    return;
  }

//////////////////////////////////////////////////////////////////////////////////////////
  command result_t StdControl.init()
  {
    atomic
    {
      msg_radio = &msg_buf_radio;
      sending_packet = FALSE;
#ifdef MTS420
			gps_pwr_on = FALSE;
			gps_work_factor = 0;
#endif
      // Zero out the accelerometer, chrl@20061208
      accel_ave_x = 0;
      accel_ave_y = 0;
      accel_ave_points = ACCEL_AVERAGE_POINTS;
      accel_ave_end = FALSE;
    }

    call BattControl.init();
    // usart1 is also connected to external serial flash
    // set usart1 lines to correct state
    TOSH_MAKE_FLASH_OUT_OUTPUT();             //tx output
    TOSH_MAKE_FLASH_CLK_OUTPUT();             //usart clk

    call ADCControl.init();
    call Leds.init();

#ifdef MTS420
    call GpsControl.init();
#endif

    call TaosControl.init();
    call AccelControl.init();      //initialize accelerometer
    call TempHumControl.init();    //init Sensirion
    call PressureControl.init();   // init Intersema

    return SUCCESS;
  }

  command result_t StdControl.start()
  {
    //in case Sensirion doesn't respond
    call HumidityError.enable();
    call TemperatureError.enable();

#ifdef MTS420
		call GpsControl.start();
		atomic gps_wait_cnt = 0;
		atomic gps_sleep_cnt = 0;
#endif

    atomic main_state = START;
    atomic sensor_state= SENSOR_NONE;
#ifdef APP_RATE
	timer_rate = XSENSOR_SAMPLE_RATE;
#else
#ifdef USE_LOW_POWER
	timer_rate = XSENSOR_SAMPLE_RATE  + ((TOS_LOCAL_ADDRESS%255) << 7);
#else
	timer_rate = XSENSOR_SAMPLE_RATE + ((TOS_LOCAL_ADDRESS%255) << 2);
#endif
#endif
    h_msg = call HealthMsgGet();
    h_msg->rsvd_app_type = SENSOR_BOARD_ID;
    call health_packet(TRUE,TOS_HEALTH_UPDATE);
    call Timer.start(TIMER_REPEAT, 1024);
    return SUCCESS;
  }

  command result_t StdControl.stop()
  {
    call BattControl.stop();
#ifdef MTS420
     call GpsControl.stop();
     call GpsCmd.TxRxSwitch(0);
#endif
    call Timer.stop();
    return SUCCESS;
  }

/******************************************************************************
 * Timer fired, test GPS, humidity/temp
 * async for test only
 * If gps_wait_cnt > 0 then gps is active, waiting for a packet
 *****************************************************************************/
  event result_t Timer.fired()
  {
    uint8_t l_state;
    // Zero out the accelerometer, chrl@20061208
    if (accel_ave_points >0)
    {
      call Leds.greenOn();
      call AccelCmd.PowerSwitch(1);
      if (accel_ave_points == 1)
      {
        call Timer.stop();
        call Timer.start(TIMER_REPEAT, timer_rate);
      }
      return SUCCESS;
    }
  
    call Leds.redToggle();

#ifdef MTS420
    gps_sleep_cnt++;
		if (!gps_pwr_on)
		{
		    if (gps_sleep_cnt > GPS_SLEEP_INTERVAL * gps_work_factor) 
		    {
		    	if (GPS_WORK_INTERVAL>0) 
			    {	//turn on GPS power
			    	call GpsCmd.PowerSwitch(1);
			    }
			    else
			    {
			    	atomic gps_sleep_cnt = 0;
			    }
			    return SUCCESS;
		    }
//		    else
//		    {
//		        gps_sleep_cnt++;
//		    }
		}
		else
		{
		    if (gps_sleep_cnt > GPS_WORK_INTERVAL * gps_work_factor)
		    {
		    	if (GPS_SLEEP_INTERVAL>0)
			    {	//turn off GPS power
			    	call GpsCmd.PowerSwitch(0);
			    }
			    else
			    {
			    	atomic gps_sleep_cnt = 0;
			    }
			    return SUCCESS;
		    }
//		    else
//		    {
//		        gps_sleep_cnt++;
//		    }
		}
#endif

    if(sending_packet) return SUCCESS;
    
    atomic l_state = main_state;
    switch(l_state)
    {
    case BUSY:
	    break;
    case START:
        call Leds.yellowOff();
        atomic
        {
           main_state = BUSY;
           sensor_state = SENSOR_BATT_START;
        }
        call Leds.greenOn();
        call Leds.redToggle();
        call BattControl.start();
        if (!sensinginsession)
        {
          call ADCBATT.getData();
          atomic sensinginsession = TRUE;
        } //get sensor data;
        break;
    }
    return SUCCESS;
  }

 /****************************************************************************
 * Battery Ref  or thermistor data ready
 ****************************************************************************/
  async event result_t ADCBATT.dataReady(uint16_t data)
  {
  	if (!sensinginsession) return FAIL;
  	atomic sensinginsession = FALSE;
    #ifndef MTS420
    pack.xData.data6.vref = data;
    #else
    pack.xData.data7.vref = data;
    #endif
    post Battstop();
    atomic
    {
	  main_state = BUSY;
	  sensor_state = SENSOR_HUMIDITY_START;
    }
    call Leds.redToggle();
    post TempHumstart();      //voltage reference data

    return SUCCESS;
  }


/******************************************************************************
 * Sensirion SHT11 humidity/temperature sensor
 * - Humidity data is 12 bit:
 *     Linear calc (no temp correction)
 *        fRH = -4.0 + 0.0405 * data -0.0000028 * data^2     'RH linear
 *     With temperature correction:
 *        fRH = (fTemp - 25) * (0.01 + 0.00008 * data) + fRH        'RH true
 * - Temperature data is 14 bit
 *     Temp(degC) = -38.4 + 0.0098 * data
 *****************************************************************************/
  async event result_t Temperature.dataReady(uint16_t data)
  {
#ifndef MTS420
    pack.xData.data6.temp = data;
#else
    pack.xData.data7.temp = data;
#endif
    post stopTempHumControl();
    return SUCCESS;
  }

  async event result_t Humidity.dataReady(uint16_t data)
  {
#ifndef MTS420
    pack.xData.data6.humidity = data;
#else
    pack.xData.data7.humidity = data;
#endif
    atomic sensor_state = SENSOR_HUMIDITY_GETTEMPDATA;
    call Temperature.getData();
    return SUCCESS;
  }

  event result_t TempHumControl.startDone()
  {
    atomic sensor_state = SENSOR_HUMIDITY_GETHUMDATA;
    call Humidity.getData();
    return SUCCESS;
  }

  event result_t TempHumControl.initDone()
  {
    return SUCCESS;
  }

  event result_t TempHumControl.stopDone()
  {
    //atomic main_state = HUMIDITY_DONE;
    atomic
    {
	  main_state = BUSY;
	  sensor_state  = SENSOR_PRESSURE_START;
    }
    call Leds.redToggle();
//    pressure_cnt=2;
    call PressureControl.start();
    return SUCCESS;
  }

  event result_t HumidityError.error(uint8_t token)
  {
    call Temperature.getData();
    return SUCCESS;
  }

  event result_t TemperatureError.error(uint8_t token)
  {
    call TempHumControl.stop();
    return SUCCESS;
  }

 /******************************************************************************
 * Intersema MS5534A barometric pressure/temperature sensor
 *  - 6 cal coefficients (C1..C6) are extracted from 4, 16 bit,words from sensor
 * - Temperature measurement:
 *     UT1=8*C5+20224
 *     dT=data-UT1
 *     Temp=(degC x10)=200+dT(C6+50)/1024
 * - Pressure measurement:
 *     OFF=C2*4 + ((C4-512)*dT)/1024
 *     SENS=C1+(C3*dT)/1024 + 24576
 *     X=(SENS*(PressureData-7168))/16384 - OFF
 *     Press(mbar)= X/32+250
 *****************************************************************************/
  async event result_t IntersemaPressure.dataReady(uint16_t data)
  {
#ifndef MTS420
    pack.xData.data6.intersemapressure = data;
#else
    pack.xData.data7.intersemapressure = data;
#endif

/*    if (pressure_cnt==1)
    {
      call IntersemaPressure.getData();
      pressure_cnt = 2;
      return SUCCESS; 
    }*/
    atomic atomic sensor_state = SENSOR_PRESSURE_GETTEMPDATA;
    call IntersemaTemp.getData();
    return SUCCESS;
  }


  async event result_t IntersemaTemp.dataReady(uint16_t data)
  {
#ifndef MTS420
    pack.xData.data6.intersematemp = data;
#else
    pack.xData.data7.intersematemp = data;
#endif
    post stopPressureControl();
    return SUCCESS;
  }


  event result_t IntersemaCal.dataReady(char word, uint16_t value)
  {
    // make sure we get all the calibration bytes
    count++;

    calibration[word-1] = value;

    if (count == 4)
    {
#ifndef MTS420
      pack.xData.data6.cal_word1 = calibration[0];
      pack.xData.data6.cal_word2 = calibration[1];
      pack.xData.data6.cal_word3 = calibration[2];
      pack.xData.data6.cal_word4 = calibration[3];
#else
      pack.xData.data7.cal_word1 = calibration[0];
      pack.xData.data7.cal_word2 = calibration[1];
      pack.xData.data7.cal_word3 = calibration[2];
      pack.xData.data7.cal_word4 = calibration[3];
#endif
      atomic sensor_state = SENSOR_PRESSURE_GETPRESSDATA;
      call IntersemaPressure.getData();
    }

    return SUCCESS;
  }

  event result_t PressureControl.initDone()
  {
    return SUCCESS;
  }

  event result_t PressureControl.startDone()
  {
    uint16_t i;
    for (i=0; i<300;i++)
    {
      TOSH_uwait(1000);
    }
    count = 0;
    atomic sensor_state = SENSOR_PRESSURE_GETCAL;
    call IntersemaCal.getData();
    return SUCCESS;
  }

  event result_t PressureControl.stopDone()
  {
    //atomic main_state = PRESSURE_DONE;
    atomic
    {
	  main_state = BUSY;
	  sensor_state = SENSOR_LIGHT_START;
    }
//    pressure_cnt=2;
    call TaosControl.start();
    return SUCCESS;
  }

/******************************************************************************
 * Taos- tsl2250 light sensor
 * Two ADC channels:
 *    ADC Count Value (ACNTx) = INT(16.5*[CV-1]) +S*CV
 *    where CV = 2^^C
 *          C  = (data & 0x7) >> 4
 *          S  = data & 0xF
 * Light level (lux) = ACNT0*0.46*(e^^-3.13*R)
 *          R = ACNT1/ACNT0
 *****************************************************************************/
  async event result_t TaosCh1.dataReady(uint16_t data)
  {
#ifndef MTS420
    pack.xData.data6.taosch1 = data;
#else
    pack.xData.data7.taosch1 = data;
#endif
    post stopTaosControl();
    return SUCCESS;
  }

  async event result_t TaosCh0.dataReady(uint16_t data)
  {
#ifndef MTS420
    pack.xData.data6.taosch0 = data;
#else
    pack.xData.data7.taosch0 = data;
#endif
    atomic sensor_state = SENSOR_LIGHT_GETCH1DATA;
    call TaosCh1.getData();
    return SUCCESS;
  }

  event result_t TaosControl.startDone()
  {
    atomic sensor_state = SENSOR_LIGHT_GETCH0DATA;
    call TaosCh0.getData();
    return SUCCESS;
  }

  event result_t TaosControl.initDone()
  {
    return SUCCESS;
  }

  event result_t TaosControl.stopDone()
  {
    //atomic main_state = LIGHT_DONE;
    atomic
    {
	  main_state = BUSY;
	  sensor_state = SENSOR_ACCEL_START;
    }
    call Leds.redToggle();
    call AccelCmd.PowerSwitch(1);
    return SUCCESS;
  }

/******************************************************************************
 * ADXL202E Accelerometer
 * At 3.0 supply this sensor's sensitivty is ~167mv/g
 *        0 g is at ~1.5V or ~VCC/2 - this varies alot.
 *        For an accurate calibration measure each axis at +/- 1 g and
 *        compute the center point (0 g level) as 1/2 of difference.
 * Note: this app doesn't measure the battery voltage, it assumes 3.2 volts
 * To getter better accuracy measure the battery voltage as this effects the
 * full scale of the Atmega128 ADC.
 * bits/mv = 1024/(1000*VBATT)
 * bits/g  = 1024/(1000*VBATT)(bits/mv) * 167(mv/g)
 *         = 171/VBATT (bits/g)
 * C       = 0.171/VBATT (bits/mg)
 * Accel(mg) ~ (ADC DATA - 512) /C
 *****************************************************************************/

async event result_t AccelY.dataReady(uint16_t data)
{
    // Zero out the accelerometer, chrl@20061208
    if (accel_ave_points>0)
    {
      accel_ave_y = accel_ave_y + data;
      accel_ave_points --;
      call Leds.greenOff();
      if(accel_ave_points == 0)
      {
        accel_ave_x = accel_ave_x / ACCEL_AVERAGE_POINTS - 450;
        accel_ave_y = accel_ave_y / ACCEL_AVERAGE_POINTS - 450;        
        post powerOffAccel();
      }
      return SUCCESS;
    }
    accel_ave_end = TRUE;
     
	  #ifndef MTS420
    pack.xData.data6.accel_y = data - accel_ave_y;
    #else
    pack.xData.data7.accel_y = data - accel_ave_y;
    #endif
    
    post powerOffAccel();
    return SUCCESS;
}


/***************************************************/
async  event result_t AccelX.dataReady(uint16_t  data)
{
    // Zero out the accelerometer, chrl@20061206
    if (accel_ave_points>0)
    {
      accel_ave_x = accel_ave_x + data;
      call AccelY.getData();
      return SUCCESS;
    }  
      
	  #ifndef MTS420    
    pack.xData.data6.accel_x = data - accel_ave_x;
    #else
    pack.xData.data7.accel_x = data - accel_ave_x;
    #endif
    
    atomic sensor_state = SENSOR_ACCEL_GETYDATA;
    call AccelY.getData();
    return SUCCESS;
}

/************power on/off**********************************************/
 event result_t AccelCmd.SwitchesSet(uint8_t PowerState)
 {
  if (PowerState)
  {
     call AccelX.getData();                     //start measuring X accel axis
     atomic sensor_state = SENSOR_ACCEL_GETXDATA;
  }
  else
  {
    if(accel_ave_end==FALSE)
    {
      return SUCCESS;
    }
#ifdef MTS420
  	sensor_state = SENSOR_GPS_START;
    call GpsCmd.TxRxSwitch(1);           //enable gps tx/rx
    atomic gps_wait_cnt = 0;
    call GpsTimer.start(TIMER_REPEAT,1000);
#else
    iNextPacketID = 6;  // issue 1st sensors packet xmit
    call Leds.greenOff();
    if(!sending_packet)
    {
    	sending_packet = TRUE;
      	post send_radio_msg();
    }
#endif
  }
  return SUCCESS;
}

/******************************************************************************
 * Packet received from GPS - ASCII msg
 * 1st byte in pkt is number of ascii bytes
 * async used only for testing
 GGA - Global Positioning System Fix Data
        GGA,123519,4807.038,N,01131.324,E,1,08,0.9,545.4,M,46.9,M, , *42
           123519       Fix taken at 12:35:19 UTC
           4807.038,N   Latitude 48 deg 07.038' N
           01131.324,E  Longitude 11 deg 31.324' E
           1            Fix quality: 0 = invalid
                                     1 = GPS fix
                                     2 = DGPS fix
           08           Number of satellites being tracked
           0.9          Horizontal dilution of position
           545.4,M      Altitude, Metres, above mean sea level
           46.9,M       Height of geoid (mean sea level) above WGS84
                        ellipsoid
           (empty field) time in seconds since last DGPS update
           (empty field) DGPS station ID number
 *****************************************************************************/
#ifdef MTS420
  event TOS_MsgPtr GpsReceive.receive(TOS_MsgPtr data)
  {
    char *packet_format;

    //change to GPS packet!!
    GPS_MsgPtr gps_data = (GPS_MsgPtr)data;

    // if gps_state = TRUE then waiting to xmit gps uart/radio packet
    if (main_state == GPS_DONE) return data;

    // check for NMEA format, gga_fields[0]
    packet_format = gps_data->data;

    if (is_gga_string_m(packet_format))
    {
       call parse_gga_message(gps_data);
       call load_gps_struct();
    }
    else
    {
      return data;
    }

    if (gps_pwr_on)
    {
    	call GpsCmd.TxRxSwitch(0); // stop receive from gpsuart
    }
    atomic main_state = GPS_DONE;
    atomic sensor_state = SENSOR_GPS_DONE;
    iNextPacketID = 7;  // issue gga packet xmit
//    if (sending_packet || (main_state == BUSY)) return SUCCESS ;
		if( (pack.xData.data7.dataGps.valid!=0) && 
		(pack.xData.data7.dataGps.valid!=1) && (pack.xData.data7.dataGps.valid!=2))
		{
			memset(&pack.xData.data7.dataGps,0,sizeof(GGAMsg));
		}

    if(!sending_packet)
    {
    	sending_packet = TRUE;
      post send_radio_msg();
    }
    return data;
  }


  // This command is scheduled for replacement by the appropriate
  // gga parsing service, which is implemented but not yet wired.
  command result_t parse_gga_message(GPS_MsgPtr gps_data)
  {
    uint8_t i,j,k;
    bool end_of_field;
    uint8_t length;

    // parse comma delimited fields to gga_filed[][]
    end_of_field = FALSE;
    i=0;
    k=0;
    length = gps_data->length;
		memset(gga_fields, '0', GGA_FIELDS*GPS_CHAR_PER_FIELD);
    while (i < GGA_FIELDS)
    {
      // assemble gga_fields array
      end_of_field = FALSE;
      j = 0;
      while ((!end_of_field) &( k < length))
      {
  	    if (gps_data->data[k] == GPS_DELIMITER)
	      {
	        end_of_field = TRUE;
	      }
	      else
	      {
	        gga_fields[i][j] = gps_data->data[k];
	      }
  	    j++;
  	    k++;
      }
      i++;
    }
    return SUCCESS;
  }

  command void load_gps_struct()
  {
    char * pdata;
    uint8_t NS,EW;

    // This code is not very useful because the same line
    // is executed whether the if statement is evaluated
    // true or false.  The valid field of the array/struct
    // should be replaced by a number_of_satellites field,
    // which provides the more information: no fix if less
    // 3 satellites, and bad fix if less than 5 sats.
    if((gga_fields[6][0]-'0')<=0)
    {
      pack.xData.data7.dataGps.valid = (uint8_t)(gga_fields[6][0]-'0');
    }
    else
    {
      pack.xData.data7.dataGps.valid = (uint8_t)(gga_fields[6][0]-'0');
    }

    /** Extract Greenwich time. */
    pdata=gga_fields[1];
    pack.xData.data7.dataGps.hours = extract_hours_m(pdata);
    pack.xData.data7.dataGps.minutes = extract_minutes_m(pdata);
    pack.xData.data7.dataGps.dec_sec = (uint32_t)(1000*extract_dec_sec_m(pdata));
//    pack.xData.dataGps.dec_sec = (uint32_t)(extract_dec_sec_m(pdata));
    pdata=gga_fields[2];
    pack.xData.data7.dataGps.Lat_deg = extract_Lat_deg_m(pdata);
    pack.xData.data7.dataGps.Lat_dec_min = (uint32_t)(10000*extract_Lat_dec_min_m(pdata));
//    pack.xData.dataGps.Lat_dec_min = (uint32_t)(extract_Lat_dec_min_m(pdata));
    pdata = gga_fields[4];
    pack.xData.data7.dataGps.Long_deg = extract_Long_deg_m(pdata);
    pack.xData.data7.dataGps.Long_dec_min = (uint32_t)(10000*extract_Long_dec_min_m(pdata));
//    pack.xData.dataGps.Long_dec_min = (uint32_t)((int)(extract_Long_dec_min_m(pdata)));
    NS = (gga_fields[3][0] == 'N') ? 1 : 0;
    EW = (gga_fields[5][0] == 'W') ? 1 : 0;
    pack.xData.data7.dataGps.NSEWind = EW | (NS<<4); // eg. Status = 000N000E = 00010000

    // Add code for extracting satellites here.
  }


event result_t GpsCmd.PowerSet(uint8_t PowerState)
{
		if(PowerState)
		{
			atomic  gps_pwr_on = TRUE;
			if (gps_work_factor == 0)
			atomic gps_work_factor = FIRST_WORK_FACTOR;
		}
		else
		{
			atomic gps_pwr_on = FALSE;
			if (gps_work_factor != NORMAL_WORK_FACTOR)
			atomic gps_work_factor = NORMAL_WORK_FACTOR;
		}
    atomic gps_sleep_cnt = 0;
    return SUCCESS;
 }

event result_t GpsCmd.TxRxSet(uint8_t rtstate)
{
  // gps tx/rx switches set to on or off
  if (rtstate)
  {
    //reinit gps uart since its shared with pressure sensor
    call GpsControl.start();
    //start counting time intervals, waiting for gps pkt
    atomic gps_wait_cnt = 0;
    call Leds.redOn();
  }
  else
  {
    // gps rx,tx control line switched off, restart weather sensors
    //atomic main_state = START;
    call Leds.redOff();
  }
  return SUCCESS;
 }
 
 event result_t GpsTimer.fired()
 {
 	  if(sensor_state != SENSOR_GPS_START)
 	  {
 		  call GpsTimer.stop();
 		  return SUCCESS;
 	  }
 	  gps_wait_cnt++;
    if (gps_wait_cnt >= GPS_MAX_WAIT || !gps_pwr_on)
    {      // gps rcvd pkt before time out?
	    call GpsCmd.TxRxSwitch(0);           // no,disable gps tx/rx switches
	    call GpsTimer.stop();
      iNextPacketID = 7;  // issue 1st sensors packet xmit
      memset(&pack.xData.data7.dataGps,0,sizeof(GGAMsg));
      if(!sending_packet)
      {
    	  sending_packet = TRUE;
      	post send_radio_msg();
      }
    }
 	  return SUCCESS;
 }
#endif

//////////////////////////////////////////////////////////////////////////////////////////

/****************************************************************************
 * Radio msg xmitted.
 ****************************************************************************/
  event result_t Send.sendDone(TOS_MsgPtr msg, result_t success)
  {
    atomic
    {
      msg_radio = msg;
      sending_packet = FALSE;
    }

   if(sensor_state == SENSOR_ACCEL_STOP)
   {
      call Leds.greenOff();
      atomic main_state = START;
      return SUCCESS;
   }
#ifdef MTS420
   if(sensor_state == SENSOR_GPS_DONE)
   {
  	  call Leds.greenOff();
      atomic main_state = START;
      return SUCCESS;
   }
   if(sensor_state == SENSOR_GPS_START)
   {
      call Leds.greenOff();
      atomic main_state = START;
   	  return SUCCESS;
   }
#endif

#if FEATURE_UART_SEND
    if (TOS_LOCAL_ADDRESS != 0) // never turn on power mgr for base
	call PowerMgrEnable();
#endif
    return SUCCESS;
  }

#if FEATURE_UART_SEND
 /**
  * Handle completion of sent UART packet.
  *
  * @author    Martin Turon
  * @version   2004/7/21      mturon       Initial revision
  */
  event result_t SendUART.sendDone(TOS_MsgPtr msg, result_t success)
  {
      atomic msg_radio = msg;
      msg_radio->addr = TOS_BCAST_ADDR;
      if (call Send.send(BASE_STATION_ADDRESS,MODE_UPSTREAM,msg_radio, sizeof(XDataMsg)) != SUCCESS)
      {
	     atomic sending_packet = FALSE;
      }
      if (TOS_LOCAL_ADDRESS != 0) // never turn on power mgr for base
	  call PowerMgrEnable();
      return SUCCESS;
  }
#endif

  static void initialize()
  {
      atomic
      {
	  sleeping = FALSE;
	  main_state = START;
	  sending_packet = FALSE;
#ifdef APP_RATE
	timer_rate = XSENSOR_SAMPLE_RATE;
#else
#ifdef USE_LOW_POWER
	timer_rate = XSENSOR_SAMPLE_RATE  + ((TOS_LOCAL_ADDRESS%255) << 7);
#else
	timer_rate = XSENSOR_SAMPLE_RATE + ((TOS_LOCAL_ADDRESS%255) << 2);
#endif
#endif
	  sensinginsession=FALSE;
      }
  }

 /**
  * Handles all broadcast command messages sent over network.
  *
  * NOTE: Bcast messages will not be received if seq_no is not properly
  *       set in first two bytes of data payload.  Also, payload is
  *       the remaining data after the required seq_no.
  *
  * @version   2004/10/5   mturon     Initial version

  */
  event result_t XCommand.received(XCommandOp *opcode)
  {
      switch (opcode->cmd)
      {
	  case XCOMMAND_SET_RATE:
	      // Change the data collection rate.
	      timer_rate = opcode->param.newrate;
	      call Timer.stop();
	      call Timer.start(TIMER_REPEAT, timer_rate);
	      break;

	  case XCOMMAND_SLEEP:
	      // Stop collecting data, and go to sleep.
	      sleeping = TRUE;
	      call Timer.stop();
	      call Leds.set(0);
              break;

	  case XCOMMAND_WAKEUP:
	      // Wake up from sleep state.
	      if (sleeping) {
		  initialize();
		  call Timer.start(TIMER_REPEAT, timer_rate);
		  sleeping = FALSE;
	      }
	      break;

	  case XCOMMAND_RESET:
	      // Reset the mote now.
	      break;

	  default:
	      break;
      }
      return SUCCESS;
  }

   event result_t XEEControl.restoreDone(result_t result)
   {
 	 if(result)
 	 {
        call Timer.stop();
	    call Timer.start(TIMER_REPEAT, timer_rate);
   	 }
 	 return SUCCESS;
   }

}