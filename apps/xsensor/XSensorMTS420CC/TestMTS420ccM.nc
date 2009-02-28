/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: TestMTS420ccM.nc,v 1.1.2.3 2007/04/26 20:35:31 njain Exp $
 */

/**
 * XSensor single-hop application for MTS420 sensorboard.
 *
 * Measures MTS400/420 weatherboard sensors & gps and converts to engineering units
 * were possible.
 *-----------------------------------------------------------------------------
 * Output results through mica2 uart port and radio.
 * Use Xlisten.exe program to view data from either port:
 *  uart: mount mica2 on mib510 with MTS400/420
 *        connect serial cable to PC
 *        run xlisten.exe at 57600 baud
 *  radio: run mica2 with  MTS400/420,
 *         run mica2 with TOSBASE
 *         run xlisten.exe at 57600 baud
 *------------------------------------------------------------------------------
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

/******************************************************************************
 *-----------------------------------------------------------------------------
 * Data packet structure  :
 *
 * * PACKET #1 (of 2)
 * ----------------
 *  msg->data[0] : sensor id, MTS400 = 0x85,MTS420 = 0x86
 *  msg->data[1] : packet id = 1
 *  msg->data[2] : node id
 *  msg->data[3] : reserved
 *  msg->data[4,5] : battery ADC data
 *  msg->data[6,7] : humidity data
 *  msg->data[8,9] : temperature data
 *  msg->data[10,11] : cal_word1
 *  msg->data[12,13] : cal_word2
 *  msg->data[14,15] : cal_word3
 *  msg->data[16,17] : cal_word4
 *  msg->data[18,19] : intersematemp
 *  msg->data[20,21] : pressure
 *  msg->data[22,23] : taosch0
 *  msg->data[24,25] : taosch1
 *  msg->data[26,27] : accel_x
 *  msg->data[28, 3] : accel_y   TOS packet is 29 bytes 0..28

 *
 * PACKET #2 (of 2)
 * ----------------
 *  msg->data[0] : sensor id, MTS400 = 0x85,MTS420 = 0x86
 *  msg->data[1] : packet id = 2
 *  msg->data[2] : node id
 *  msg->data[3] : reserved
 *  msg->data[4] : Hours
 *  msg->data[5] : Minutes
 *  msg->data[6] : Latitude degrees
 *  msg->data[7] : Longitude degrees
 *  msg->data[8,9,10,11] : Decimal seconds
 *  msg->data[12,13,14,15] : Latitude decimal minutes
 *  msg->data[16,17,18,19] : Longitude decimal minutes
 *  msg->data[20] : NSEWind
 *  msg->data[21] : whether the packet is valid
 *
 *------------------------------------------------------------------------------
 *****************************************************************************/

includes gps;
#include "appFeatures.h"



module TestMTS420ccM {
  provides interface StdControl;
  uses {

  	//communication
	interface StdControl as CommControl;
	interface SendMsg as Send;
	interface ReceiveMsg as Receive;

#ifdef MTS420
//gps
    interface GpsCmd;
    interface StdControl as GpsControl;
    interface ReceiveMsg as GpsReceive;
#endif
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

    interface Timer;
    interface Leds;

#if FEATURE_EEPROM_TEST
//	EEPROM
	interface MTS420EEPROM;
	interface StdControl as MTS420EEPROMControl;
#endif
  }
}

implementation
{
  enum {START,
        BUSY,
        EEPROM_WRITE,
        EEPROM_READ,
        GPS_BUSY,
        BATT_DONE,
        HUMIDITY_DONE,
        PRESSURE_DONE,
        LIGHT_DONE,
        ACCEL_DONE,
        GPS_DONE,
        };
  enum {SENSOR_NONE = 0,
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
		SENSOR_ACCEL_STOP = 53
		};

#define TIMER_PERIOD 2000         	// timer period in msec
	char count;

	uint16_t calibration[4];        // intersema calibration words
	norace uint8_t  state;          //
	uint8_t  sensor_state;          // debug only

#ifdef MTS420
	uint8_t gps_wait_cnt;           // cnts wait periods for gps pkt to arrive
	uint16_t gps_sleep_cnt;
	bool gps_pwr_on;                // true if gps power on
  	uint8_t gps_work_factor;
	char gga_fields[GGA_FIELDS][GPS_CHAR_PER_FIELD]; // = {{0}};
#endif
	TOS_Msg msg_buf;
	TOS_MsgPtr msg_ptr;
	bool sending_packet, WaitingForSend, IsUART;
	norace XDataMsg *pack;
	norace uint8_t iNextPacketID;


#if FEATURE_EEPROM_TEST
	// test EEPROM, chrl 20060724
    uint8_t WData[10];
    uint8_t test;
    uint8_t EEPROMwf;
    uint8_t EEPROMchkover;
//    uint16_t counter;
#endif
/****************************************************************************
 * Task to send uart and rf message
 ****************************************************************************/
    task void send_msg()
	{
		if (sending_packet) return;
		atomic sending_packet = TRUE;
		pack->xSensorHeader.board_id  = SENSOR_BOARD_ID;
		pack->xSensorHeader.packet_id = iNextPacketID;
		pack->xSensorHeader.node_id   = TOS_LOCAL_ADDRESS;
//		pack->xSensorHeader.rsvd    = 0;

		call Leds.yellowOn();
		if (IsUART)
		{
			if(call Send.send(TOS_UART_ADDR,sizeof(XDataMsg)-1,msg_ptr)!=SUCCESS)
			{
				atomic sending_packet = FALSE;
				call Leds.greenToggle();
			}
		}
		else
		{
			if(call Send.send(TOS_BCAST_ADDR,sizeof(XDataMsg)-1,msg_ptr)!=SUCCESS)
			{
				atomic sending_packet = FALSE;
				call Leds.greenToggle();
			}
		}
		return;
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

	command result_t StdControl.init()
	{
		atomic
		{
			msg_ptr = &msg_buf;
			sending_packet = FALSE;
			WaitingForSend = FALSE;
#ifdef MTS420
			gps_pwr_on = FALSE;
			gps_work_factor = 0;
#endif
		}
		pack = (XDataMsg *)msg_ptr->data;
      // usart1 is also connected to external serial flash
      // set usart1 lines to correct state
		TOSH_MAKE_FLASH_OUT_OUTPUT();             //tx output
		TOSH_MAKE_FLASH_CLK_OUTPUT();             //usart clk

		call BattControl.init();
		call CommControl.init();
		call Leds.init();
		call Leds.greenOn();
#ifdef MTS420
		call GpsControl.init();
#endif
		call TaosControl.init();
		call AccelControl.init();      //initialize accelerometer
		call TempHumControl.init();    //init Sensirion
		call PressureControl.init();   // init Intersema

#if FEATURE_EEPROM_TEST
		call MTS420EEPROMControl.init();

		// test EEPROM, chrl 20060724
		for(test=0; test<10;test++)
		{
			WData[test]=test;
		}
		test = 1;
		EEPROMwf=0;
		EEPROMchkover = 0;
//		counter =0;
#endif
		return SUCCESS;
  }

	command result_t StdControl.start()
	{
		call HumidityError.enable();                 //in case Sensirion doesn't respond
		call TemperatureError.enable();              // same as above
		call CommControl.start();
		call BattControl.start();
#ifdef MTS420
		call GpsControl.start();
		atomic gps_wait_cnt = 0;
		atomic gps_sleep_cnt = 0;
#endif

		atomic state = START;
		atomic sensor_state= SENSOR_NONE;

		IsUART = TRUE;
		call Timer.start(TIMER_REPEAT, TIMER_PERIOD);    //start up sensor measurements
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
		call CommControl.stop();
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
		call Leds.redToggle();

		atomic l_state = state;
		if (sending_packet || (l_state == BUSY))
			return SUCCESS ;      //don't overrun buffers

#ifdef MTS420
		if (!gps_pwr_on)
		{
		    if (gps_sleep_cnt > GPS_SLEEP_INTERVAL * gps_work_factor) 
		    {
		    	if (GPS_WORK_INTERVAL>0) 
			    {	//turn on GPS power
			    	return call GpsCmd.PowerSwitch(1);
			    }
			    else
			    {
			    	atomic gps_sleep_cnt = 0;
			    }
			    return SUCCESS;
		    }
		    else
		    {
		        gps_sleep_cnt++;
		    }
		}
		else
		{
		    if (gps_sleep_cnt > GPS_WORK_INTERVAL * gps_work_factor)
		    {
		    	if (GPS_SLEEP_INTERVAL>0)
			    {	//turn off GPS power
			    	return call GpsCmd.PowerSwitch(0);
			    }
			    else
			    {
			    	atomic gps_sleep_cnt = 0;
			    }
			    return SUCCESS;
		    }
		    else
		    {
		        gps_sleep_cnt++;
		    }
		}
#endif

#if FEATURE_EEPROM_TEST
	  // chrl 20060810
      	if(EEPROMchkover==0)
    	{
        	call MTS420EEPROMControl.start();
        	atomic EEPROMchkover=1;
        	return SUCCESS;
    	}
    	TOSH_uwait(10);
    	if (test != 0)
    	{
	   		test=0;
	  		if(EEPROMwf==0)
	 		{
	 			atomic state = BUSY;
	   			call MTS420EEPROM.writePacket(0,10,(char*)(WData),0x01);
	   			return SUCCESS;
	   		}
     	}
     	else
     	{
	   		test=1;
	   		if(EEPROMwf==1)
	   		{
	   			atomic state = BUSY;
				call MTS420EEPROM.readPacket(0,10,0x03);
				return SUCCESS;
	   		}
     	}
#endif
		if (WaitingForSend)
		{
/*
 * The GPS modules DC-DC booster can interfere with radio communication.
 * If the GPS module must be continually powered and monitored during radio
 * communication, then 3.3-3.6 volt lithium batteries are recommended to
 * power the mote. Normal alkaline batteries are not recommended unless
 * the GPS module is powered down during radio communication.
 *
 * If GPS module is to be powered down during radio communication,
 *         uncomment following GpsCmd.PowerSwitch(0) line
 * If the GPS module must be continually powered and monitored during radio
 *         communication, comment following GpsCmd.PowerSwitch(0) line
 */
 			/*
            if (gps_pwr_on)
            {
               // if (gps_sleep_cnt > GPS_WORK_INTERVAL*gps_work_factor)
                    call GpsCmd.PowerSwitch(0);
               // else
               //     gps_sleep_cnt++;

            }*/
			post send_msg();
			return SUCCESS;
		}

		switch(l_state)
		{
		case START:
#if FEATURE_GPS_ONLY
	      call Leds.greenOff();
#ifdef MTS420
	      atomic state = GPS_BUSY;
	      return call GpsCmd.TxRxSwitch(1);  //enable gps tx/rx
#else
	      atomic state = START;
	      return SUCCESS;
#endif
#else
	      atomic{
		  state = BUSY;
		  sensor_state = SENSOR_BATT_START;
	      }
	      call Leds.greenToggle();
	      return call ADCBATT.getData();           //get vref data;
#endif
			break;
		case BATT_DONE:
			atomic
			{
				state = BUSY;
				sensor_state = SENSOR_HUMIDITY_START;
			}
			return call TempHumControl.start();
		case HUMIDITY_DONE:
			atomic
			{
				state = BUSY;
				sensor_state  = SENSOR_PRESSURE_START;
			}
			return call PressureControl.start();
		case PRESSURE_DONE:
			atomic
			{
				state = BUSY;
				sensor_state = SENSOR_LIGHT_START;
			}
			return call TaosControl.start();
		case LIGHT_DONE:
			atomic
			{
				state = BUSY;
				sensor_state = SENSOR_ACCEL_START;
			}
			return call AccelCmd.PowerSwitch(1);  //power on
		case ACCEL_DONE:
			call Leds.greenOff();
#ifdef MTS420
			if (gps_pwr_on)
	      	{
	      		atomic state = GPS_BUSY;
	      		return call GpsCmd.TxRxSwitch(1);  //enable gps tx/rx
	      	}
	      	else
	      	{
		      atomic state = START;
		      return SUCCESS;
	      	}
#else
	      atomic state = START;
	      return SUCCESS;
#endif
			break;

#ifdef MTS420
		case GPS_BUSY:
			if (gps_wait_cnt >= GPS_MAX_WAIT)
			{      // gps rcvd pkt before time out?
				call Leds.greenOn();
				call GpsCmd.TxRxSwitch(0);   // no,disable gps tx/rx switches
				atomic state = START;        		
				return SUCCESS;
			}
			else 
			{
				call Leds.yellowToggle();
				gps_wait_cnt++;              //keep waiting for gps pkt
				return SUCCESS;
			}
			break;
		case GPS_DONE:
			atomic state = START;
			return call GpsCmd.TxRxSwitch(0);
			break;
#endif
		}
		return SUCCESS;
	}

#ifdef MTS420
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
	event TOS_MsgPtr GpsReceive.receive(TOS_MsgPtr data)
	{
		uint8_t i,j,m,length,NS,EW;
		uint16_t k;
		uint32_t temp;
		bool end_of_field;
		char *packet_format;
		char *pdata;
		float dec_secs,dec_min;

		//change to GPS packet!!
		GPS_MsgPtr gps_data = (GPS_MsgPtr)data;

		// if gps have been scaned then stop receiving gps uart packet
		if (state == GPS_DONE)
			return data;

		// check for NMEA format, gga_fields[0]
		packet_format = gps_data->data;
		//
		if ( !((packet_format[3] == 'G') &&
			(packet_format[4] == 'G') &&
			(packet_format[5] == 'A')))
		{
			//SODbg(DBG_USR2, "No NEMA format, gps packet parese failed!!  \n");
			return data;
		}
		
		call GpsCmd.TxRxSwitch(0);

		// parse comma delimited fields to gga_filed[][]
		end_of_field = FALSE;
		i=0;
		k=0;
		length = gps_data->length;
		memset(gga_fields, '0', GGA_FIELDS*GPS_CHAR_PER_FIELD);
		memset(pack,0,sizeof(XDataMsg));
		while (i < GGA_FIELDS)
		{
		// assemble gga_fields array
			end_of_field = FALSE;
			j = 0;
			while ((!end_of_field) & (k < length))
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
			/*
			// two commas (,,) indicate empty field
			// if field is empty, set it equal to 0
			if (j <= 1)
			{
				for (m=0; m<10; m++)
					gga_fields[i][m] = '0';
			}
			*/
			i++;
		}


		// gga_msg.hours = call extract_hours(gga_fields[1]);
		pdata=gga_fields[1];
		pack->xData.dataGps.hour=10*(pdata[0]-'0') + (pdata[1]-'0');

		// gga_msg.minutes = call extract_minutes(gga_fields[1]);
		pack->xData.dataGps.minute=10*(pdata[2]-'0') + (pdata[3]-'0');

		// uint32_t
		// gga_msg.dec_sec = call extract_dec_sec(gga_fields[1]);
		dec_secs = 10*(pdata[4]-'0') +  (pdata[5]-'0') + 0.1*(pdata[7]-'0')
					+ 0.01*(pdata[8]-'0') + 0.001*(pdata[9]-'0');
		temp = (uint32_t)(dec_secs * 1000);
		pack->xData.dataGps.dec_sec = temp;

		// gga_msg.Lat_deg = call extract_Lat_deg(gga_fields[2]);
		pdata=gga_fields[2];
		pack->xData.dataGps.lat_deg= (uint16_t)(10*(pdata[0]-'0') + (pdata[1]-'0'));

		// gga_msg.Lat_dec_min = call extract_Lat_dec_min(gga_fields[2]);
		dec_min = 10*(pdata[2]-'0') +  (pdata[3]-'0') + 0.1*(pdata[5]-'0')
					+ 0.01*(pdata[6]-'0') + 0.001*(pdata[7]-'0') + 0.0001*(pdata[8]-'0');
		temp = (uint32_t)(dec_min * 10000);
		pack->xData.dataGps.lat_dec_min = temp;

		// gga_msg.Long_deg = call extract_Long_deg(gga_fields[4]);
		pdata = gga_fields[4];
		pack->xData.dataGps.long_deg  = (100*(pdata[0]-'0') + 10*(pdata[1]-'0') + (pdata[2]-'0'));

		// gga_msg.Long_dec_min = call extract_Long_dec_min(gga_fields[4]);
		dec_min = 10*(pdata[3]-'0') +  (pdata[4]-'0') + 0.1*(pdata[6]-'0')
					+ 0.01*(pdata[7]-'0') + 0.001*(pdata[8]-'0') + 0.0001*(pdata[9]-'0');
		temp = (uint32_t)(dec_min * 10000);
		pack->xData.dataGps.long_dec_min= temp;

		NS = (gga_fields[3][0] == 'N') ? 1 : 0;
		EW = (gga_fields[5][0] == 'W') ? 1 : 0;
		pack->xData.dataGps.nsewind= EW | (NS<<4); // eg. Status= 000N000E = 00010000

		// uint8_t
		pack->xData.dataGps.fixed=(uint8_t)(gga_fields[6][0]-'0'); // invalid

      	pdata =gga_fields[7];
//      	pack->xData.dataGps.SVs = 10*(pdata[0]-'0') + (pdata[1]-'0');

      	/*
        if (gps_pwr_on)
        {
            if (gps_sleep_cnt > GPS_WORK_INTERVAL*gps_work_factor)
                call GpsCmd.PowerSwitch(0);
            else
                gps_sleep_cnt++;
        }
        */
		atomic state = GPS_DONE;
		if( (pack->xData.dataGps.fixed==0) || 
		(pack->xData.dataGps.fixed==1) || (pack->xData.dataGps.fixed==2))
		{
			iNextPacketID = 2;  // issue gga packet xmit
			WaitingForSend =  TRUE;
		}
		else
		{
			memset(pack,0,sizeof(XDataMsg));
		}
		return data;
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
		if (rtstate)  //reinit gps uart since its shared with pressure sensor
		{
			call GpsControl.start();
			//start counting time intervals, waiting for gps pkt
			atomic gps_wait_cnt = 0;
		}
		return SUCCESS;
	}
#endif

/****************************************************************************
 * Battery Ref  or thermistor data ready
 ****************************************************************************/
	async event result_t ADCBATT.dataReady(uint16_t data)
	{
		pack->xData.data1.vref = data ;
		atomic state = BATT_DONE;
		return SUCCESS;
	}

 /*****************************************************************************
 * Intersema MS5534A barometric pressure/temperature sensor
 *  - 6 cal coefficients (C1..C6) are extracted from 4,16 bit,words from sensor
 * - Temperature measurement:
 *     UT1=8*C5+20224
 *     dT=data-UT1
 *     Temp=(degC x10)=200+dT(C6+50)/1024
 * - Pressure measurement:
 *     OFF=C2*4 + ((C4-512)*dT)/1024
 *     SENS=C1+(C3*dT)/1024 + 24576
 *     X=(SENS*(PressureData-7168))/16384 - OFF
 *     Press(mbar)= X/32+250
 ****************************************************************************/
	async event result_t IntersemaPressure.dataReady(uint16_t data)
	{
		pack->xData.data1.pressure = data ;
		atomic atomic sensor_state = SENSOR_PRESSURE_GETTEMPDATA;
		return call IntersemaTemp.getData();
	}

	async event result_t IntersemaTemp.dataReady(uint16_t data)
	{
		pack->xData.data1.intersematemp = data ;
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
			pack->xData.data1.cal_word1 = calibration[0];
			pack->xData.data1.cal_word2 = calibration[1];
			pack->xData.data1.cal_word3 = calibration[2];
			pack->xData.data1.cal_word4 = calibration[3];

			atomic sensor_state = SENSOR_PRESSURE_GETPRESSDATA;
			call IntersemaPressure.getData();
		}
		return SUCCESS;
	}

	event result_t PressureControl.initDone()
	{
		return SUCCESS;
	}

	event result_t PressureControl.stopDone()
	{
		atomic state = PRESSURE_DONE;
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
		pack->xData.data1.temperature = data ;
		post stopTempHumControl();
		return SUCCESS;
	}

	async event result_t Humidity.dataReady(uint16_t data)
	{
		pack->xData.data1.humidity = data ;
		atomic sensor_state = SENSOR_HUMIDITY_GETTEMPDATA;
		return call Temperature.getData();
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
		atomic state = HUMIDITY_DONE;
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
		atomic state = HUMIDITY_DONE;
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
		pack->xData.data1.taoch1 = data & 0x00ff;
		post stopTaosControl();
		return SUCCESS;
	}

	async event result_t TaosCh0.dataReady(uint16_t data)
	{
		pack->xData.data1.taoch0 = data & 0x00ff;
		atomic sensor_state = SENSOR_LIGHT_GETCH1DATA;
		return call TaosCh1.getData();
	}

	event result_t TaosControl.startDone()
	{
		atomic sensor_state = SENSOR_LIGHT_GETCH0DATA;
		return call TaosCh0.getData();
	}

	event result_t TaosControl.initDone()
	{
		return SUCCESS;
	}

	event result_t TaosControl.stopDone()
	{
		atomic state = LIGHT_DONE;
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
		pack->xData.data1.accel_y = data & 0xff;
		pack->xSensorHeader.rsvd = data >> 8;
		post powerOffAccel();
		return SUCCESS;
	}


/***************************************************/
	async  event result_t AccelX.dataReady(uint16_t  data)
	{
		pack->xData.data1.accel_x = data;
		atomic sensor_state = SENSOR_ACCEL_GETYDATA;
		call AccelY.getData();
		return SUCCESS;
	}

/***************************************************/
	event result_t AccelCmd.SwitchesSet(uint8_t PowerState)
	{
		// power on/off
		if (PowerState)
		{
			call AccelX.getData();              //start measuring X accel axis
			atomic sensor_state = SENSOR_ACCEL_GETXDATA;
		}
		else
		{
			atomic state = ACCEL_DONE;
			iNextPacketID = 1;  // issue 1st sensors packet xmit
			atomic WaitingForSend = TRUE;
		}
		return SUCCESS;
	}

/****************************************************************************
 * Radio msg xmitted.
 ****************************************************************************/
	event result_t Send.sendDone(TOS_MsgPtr msg, result_t success)
	{
		call Leds.yellowOff();
		if(IsUART)
		{
			msg_ptr = msg;
			IsUART = !IsUART;        // change to radio send
			WaitingForSend = TRUE;   // uart sent, issue radio send
			sending_packet = FALSE;
		}
		else
		{
			IsUART = !IsUART;  // change to uart send
			atomic
			{
				WaitingForSend = FALSE;  // both uart and radio sent, done for current msg
				sending_packet = FALSE;
			}
		}
		return SUCCESS;
	}

  /****************************************************************************
 * Uart msg rcvd.
 * This app doesn't respond to any incoming uart msg
 * Just return
 ****************************************************************************/
	event TOS_MsgPtr Receive.receive(TOS_MsgPtr data)
	{
		return data;
	}

#if FEATURE_EEPROM_TEST
  /****************************************************************************
 *
 * test EEPROM, chrl 20060724
 *
 ****************************************************************************/
    event result_t MTS420EEPROM.writePacketDone(bool result)
	{
        if(result)
        {
            atomic EEPROMwf=1;
        	atomic EEPROMchkover=1;
         	atomic state = EEPROM_READ;
            return SUCCESS;
        }
        return FAIL;
    }

    event result_t MTS420EEPROM.readPacketDone(char length, char* data)
	{
        int i;
        if(length!=10)
        	return FAIL;
        if(EEPROMwf>1)
             return SUCCESS;
        EEPROMwf=EEPROMwf+1;
    	if(sending_packet)
        	return SUCCESS;

		call MTS420EEPROMControl.stop();
        atomic pack->xSensorHeader.rsvd =1;
        for(i=0;i<10;i++)
        {
            atomic {((uint8_t*)pack)[i+4]=WData[i];}
            atomic {((uint8_t*)pack)[i+14]=data[i];}
            if ((uint8_t)data[i] != WData[i])
                pack->xSensorHeader.rsvd = 0;

            WData[i] = WData[i]+1;
        }
//        ((uint8_t*)pack)[25]= ((counter>>8)&0xff);
//        ((uint8_t*)pack)[24]= (counter&0xff);

//        counter++;
		atomic iNextPacketID = 3;  // issue 3rd sensors packet xmit
		atomic WaitingForSend = TRUE;
        atomic EEPROMchkover=1;
		atomic state = START;
		return SUCCESS;
    }
#endif
}

