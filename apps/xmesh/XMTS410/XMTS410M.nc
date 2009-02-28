/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: XMTS410M.nc,v 1.5.2.19 2007/04/26 20:20:00 njain Exp $
 */

/**
 * XSensor multi-hop application for MTS410 sensorboard.
 *
 * @author PiPeng
 */

/******************************************************************************
 *
 *****************************************************************************/
#include "appFeatures.h"
includes XCommand;

includes sensorboard;

module XMTS410M
{
  provides
  {
    interface StdControl;
  }
  uses
  {
    interface Leds;

    interface MhopSend as Send;
    interface RouteControl;
/*#ifdef XMESHSYNC
    interface Receive as DownTree;
#endif    */
    interface XCommand;
    interface XEEControl;

// Battery
    interface ADC as ADCBATT;
    interface StdControl as BattControl;

//Accels
    interface StdControl as AccelControl;
    interface ADC as AccelX;
    interface ADC as AccelY;

//Intersema
    interface SplitControl as PressureControl;
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


//Relay
    interface StdControl as RelayControl;
    interface Relay as relay_normally_closed;
    interface Relay as relay_normally_open;

#if SENSOR_MIC
    interface StdControl as MicControl;
    interface Mic;
#endif
    interface StdControl as PirControl;

    interface ADC as ADC5;
    interface ADC as ADC6;
    interface ADCControl;
    interface Sounder;

    interface PIR;
    interface Timer as PIRTimer;
    interface Timer;
// EEPROM
    interface MTS410EEPROM;
    interface StdControl as MTS410EEPROMControl;

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
  enum { START, BUSY, BATT_DONE, TEMP_DONE, LIGHT_DONE};

  char count;

  uint8_t pir_history_window[PIR_WINDOW_SIZE];
  uint8_t active_pir_window_size;
  uint16_t pir_running_sum;

  uint16_t calibration[4];           //intersema calibration words
  norace uint8_t  state;

  TOS_Msg msg_buf;
  TOS_MsgPtr msg_ptr;
  norace bool sending_packet,sleeping,sensinginsession;
  norace XDataMsg pack;
  HealthMsg *h_msg;

//mic
  uint16_t  mic_g;
//pir
  uint16_t  pir_g;
  uint16_t  PIR_trigger_count;                  //cnts pirs interrupt in a given period
  uint16_t  pir_event_count;
  uint16_t  pir_calib_bias;
  uint16_t  pir_calib_threshold;
  uint16_t  pir_calib_N;
  uint16_t  pir_calib_T;
  uint16_t  pir_adjust_threshold;
  uint8_t   WData[10];
  uint8_t   pirParamChanged;
  uint8_t   bPirParam;
  uint8_t   bPirSample;
  uint16_t  reajust_counter;
  uint16_t  pir_adc_init_thresh;
  norace uint16_t  volt;
  norace uint8_t   bReadjust;
  norace uint16_t  pir_readjust;
//sounder
  bool        bSounder;                 //true if sounder activated for detect events
  uint16_t     detectcnt;

  // Zero out the accelerometer, chrl@20061206
  norace uint16_t accel_ave_x, accel_ave_y;
  norace uint8_t accel_ave_points;

  static void getPirParam();
  static void storePirParam();
  void sendPirParam();
  task void DetectFunc();
  task void SendMsgFunc();
  void setMicParam();

  static void initialize()
  {
    atomic
    {
      sending_packet=FALSE;

      detectcnt=0;
//init pir params
      pir_g = 0;
      PIR_trigger_count = 0;
      pir_event_count = 0;
      pir_calib_bias = PIR_DEF_BIAS;
      pir_calib_threshold = PIR_DEF_THRESHOLD;
      pir_calib_N = PIR_VALID_CNT;
      pir_calib_T = PIR_MONITOR_TIMER;
      pir_adjust_threshold = PIR_DEF_ADJUST_THRESHOLD;
      memset((char*)WData, 0, 10);
      pirParamChanged = FALSE;
      bPirParam = FALSE;
      bPirSample = FALSE;
      volt = 0;
      reajust_counter = 0;
      bReadjust = TRUE;
      pir_readjust = 0;
      pir_adc_init_thresh = pir_calib_threshold;
// sounder
      bSounder = FALSE;            //set true for sounder activation on sensor event
#ifdef APP_RATE
      timer_rate = XSENSOR_SAMPLE_RATE;
#else
#ifdef USE_LOW_POWER
      timer_rate = XSENSOR_SAMPLE_RATE  + ((TOS_LOCAL_ADDRESS%255) << 7);
#else
      timer_rate = XSENSOR_SAMPLE_RATE + ((TOS_LOCAL_ADDRESS%255) << 2);
#endif
#endif
      atomic sensinginsession=FALSE;
    }
  }

  static void start()
  {
    atomic state = START;
    call HumidityError.enable();                 //in case Sensirion doesn't respond
    call TemperatureError.enable();              // same as above
    call BattControl.start();
  }

  task void stop()
  {
    call StdControl.stop();
  }
  task void Accelstart()
  {
    uint8_t i;
    call AccelControl.start();
    for(i=0;i<10;i++)
    {
      TOSH_uwait(1000);
    }
    call AccelX.getData();
  }
  task void Accelstop()
  {
    call AccelControl.stop();
    call TaosControl.start();
  }
  task void Taosstop()
  {
    call TaosControl.stop();
  }
  task void TempHumstart()
  {
    call TempHumControl.start();
  }
  task void TempHumstop()
  {
    call TempHumControl.stop();
  }
  task void Pressurestart()
  {
    call PressureControl.start();
  }
  task void Pressurestop()
  {
    call PressureControl.stop();
  }
  task void Micstart()
  {
    call Mic.MicOn();
    TOSH_uwait(100);
    setMicParam();
  }

 /**
  * Task to xmit radio message
  * @return SUCCESS
  *
  * @author    PiPeng, chenrl
  * @version   2006/12/20      chenrl
  */
  task void send_radio_msg()
  {
    uint16_t  len;
    XDataMsg *data;
    uint8_t i;
    if(sending_packet) return;
    call Leds.yellowOn();
    atomic sending_packet=TRUE;

    data = (XDataMsg*)call Send.getBuffer(msg_ptr, &len);
    for (i=0; i<= sizeof(XDataMsg)-1; i++)
    ((uint8_t*) data)[i] = ((uint8_t*)&pack)[i];
    data->xMeshHeader.board_id = SENSOR_BOARD_ID;
    data->xMeshHeader.packet_id = XSENSOR_XMTS410_PACKET_20E;
    //data->xMeshHeader.node_id = TOS_LOCAL_ADDRESS;
    data->xMeshHeader.parent    = call RouteControl.getParent();
    data->xMeshHeader.packet_id = data->xMeshHeader.packet_id | 0x80;
    atomic data->xData.data1.pir = pir_event_count;
// compute the sum of the pir_history_window
    i = 0;
    pir_running_sum = 0;
    while (i < active_pir_window_size) {
      pir_running_sum += pir_history_window[i++];
    }
  // cap the running sum at 255, sinc e we have only one byte to hold it in the packet
    if (pir_running_sum > 255) { pir_running_sum = 255; } 
    atomic data->xData.data1.pir_sum = pir_running_sum;

    atomic data->xData.data1.pir_max = pir_g ;
    atomic data->xData.data1.audio = mic_g ;
    pir_g = 0;
    mic_g = 0;

    PIR_trigger_count = 0;
  // if the windows is not filled up, we expand the window
    if (active_pir_window_size < PIR_WINDOW_SIZE)
     {
       active_pir_window_size++;
     }
  //otherwise we slide the window
    else 
     {
       memmove((uint8_t *)pir_history_window, (uint8_t *)&pir_history_window[1], PIR_WINDOW_SIZE-1);
     }
    pir_history_window[active_pir_window_size-1] = pir_event_count;
    pir_event_count = 0;
    call PIRTimer.stop();

#if FEATURE_UART_SEND
    if (TOS_LOCAL_ADDRESS != 0)
    {
      call Leds.yellowOn();
      call PowerMgrDisable();
      TOSH_uwait(1000);
      if (call SendUART.send(TOS_UART_ADDR, sizeof(XDataMsg),msg_ptr) != SUCCESS)
      {
        atomic sending_packet = FALSE;
        call Leds.greenToggle();
        call PowerMgrEnable();
      }
     }
     else
#endif
     {
      // Send the RF packet!
      if (call Send.send(BASE_STATION_ADDRESS,MODE_UPSTREAM,msg_ptr, sizeof(XDataMsg)) != SUCCESS)
      {
        atomic sending_packet = FALSE;
        call Leds.yellowOn();
        call Leds.greenOff();
      }
    }
    return;
  }


 /**
  * Initialize the component. Initialize ADCControl, Leds
  * @return SUCCESS
  *
  * @author    PiPeng, chenrl
  * @version   2006/12/20      chenrl
  */
  command result_t StdControl.init()
  {
    atomic
    {
      msg_ptr = &msg_buf;
      sending_packet=FALSE;
      // Zero out the accelerometer, chrl@20061207
      accel_ave_x = 0;
      accel_ave_y = 0;
      accel_ave_points = ACCEL_AVERAGE_POINTS;
    }
    // usart1 is also connected to external serial flash
    // set usart1 lines to correct state
    TOSH_MAKE_FLASH_OUT_OUTPUT();             //tx output
    TOSH_MAKE_FLASH_CLK_OUTPUT();             //usart clk

    memset((uint8_t *)pir_history_window, 0, PIR_WINDOW_SIZE);
    active_pir_window_size = 0;
      
    call Sounder.Off();
    call ADCControl.bindPort(TOS_ADC5_PORT, TOSH_ACTUAL_ADC5_PORT);
    call ADCControl.bindPort(TOS_ADC6_PORT, TOSH_ACTUAL_ADC6_PORT);
    call BattControl.init();
    call ADCControl.init();
    call Leds.init();
#if SENSOR_MIC
    call MicControl.init();
#else
    TOSH_MAKE_PW3_OUTPUT(); TOSH_SET_PW3_PIN();
#endif
    call PirControl.init();
    call TaosControl.init();
    call AccelControl.init();
    call TempHumControl.init();    //init Sensirion
    call PressureControl.init();   // init Intersema
    call RelayControl.init();
    call MTS410EEPROMControl.init();

    initialize();
    getPirParam();
    return SUCCESS;
  }


 /**
 * Start the component. Start the clock.
 * @return SUCCESS
 *
 * @author    PiPeng, chenrl
 * @version   2006/12/20      chenrl
 */
  command result_t StdControl.start()
  {
    call StdControl.stop();
    h_msg = call HealthMsgGet();
    h_msg->rsvd_app_type = SENSOR_BOARD_ID;
    call health_packet(TRUE,TOS_HEALTH_UPDATE);
    // Zero out the accelerometer, chrl@20061207
    call Timer.start(TIMER_REPEAT, 1024);
    call AccelControl.start();
    call PIR.On();
    TOSH_uwait(100);
    return SUCCESS;
  }


 /**
  * Stop the component.
  * @return SUCCESS
  *
  * @author    PiPeng, chenrl
  * @version   2006/12/20      chenrl
  */
  command result_t StdControl.stop()
  {
    call BattControl.stop();
    call AccelControl.stop();
    call TaosControl.stop();
    call TempHumControl.stop();
    call PressureControl.stop();
    return SUCCESS;
  }


 /**
  * Measure the sensors
  * @return SUCCESS
  *
  * @author    PiPeng, chenrl
  * @version   2007/01/18      chenrl
  */
  event result_t Timer.fired()
  {
    if (bReadjust)
    {
      call BattControl.start();
      call ADCBATT.getData();
      atomic sensinginsession = TRUE;
      return SUCCESS;
    }
    // Zero out the accelerometer, chrl@20061207
    if (accel_ave_points >0)
    {
      call Leds.greenOn();
      call AccelX.getData();
      if (accel_ave_points == 1)
      {
        call Timer.stop();
        call Timer.start(TIMER_REPEAT, timer_rate);
      }
      return SUCCESS;
    }

    reajust_counter++;
    if(sending_packet) return SUCCESS;

    call PIR.IntDisable();
    if (pir_g == 0)
    {
      call PIR.sampleNow();
    }
    post SendMsgFunc();

    return SUCCESS;
  }

  task void SendMsgFunc()
  {
    start();
    if (!sensinginsession)
    {
      call ADCBATT.getData();
      atomic sensinginsession = TRUE;
    }           //get sensor data;
    return;
  }

 /**
  * Battery Ref data ready
  *
  * @param data: battery reading
  * @return SUCCESS
  *
  * @author    PiPeng, chenrl
  * @version   2007/01/18      chenrl
  */
  async event result_t ADCBATT.dataReady(uint16_t data)
  {
    if (!sensinginsession) return FAIL;
    atomic sensinginsession = FALSE;
    atomic pack.xData.data1.vref = data ;
    atomic volt = data;
    if (bReadjust && volt<= LOWER_VREF && volt >= UPPER_VREF) // volt is the raw data of voltage
    {
      call BattControl.stop();
      pir_calib_threshold = volt * pir_adc_init_thresh / STANDARD_VREF;
      pir_readjust = (261888/(pir_calib_bias - pir_calib_threshold)) - 512;
      bReadjust = FALSE;
      atomic call PIR.IntDisable();
      call PIR.detectAdjust((uint8_t)pir_readjust);
      sendPirParam();
      return SUCCESS;
    }
    atomic state = BATT_DONE;
    call ADC5.getData();
    return SUCCESS;
  }

  async event result_t ADC5.dataReady(uint16_t data)
  {
    atomic pack.xData.data1.adc5 = data ;
    call ADC6.getData();
    return SUCCESS;
  }
  async event result_t ADC6.dataReady(uint16_t data)
  {
    atomic pack.xData.data1.adc6 = data ;
    post Accelstart();
    return SUCCESS;
  }

 /**
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
  *
  * @param data: X coordinate reading form accelerometer sensor
  * @return SUCCESS
  *
  * @author    PiPeng, chenrl
  * @version   2006/12/20      chenrl
  */
  async  event result_t AccelX.dataReady(uint16_t  data)
  {
    // Zero out the accelerometer, chrl@20061207
    if (accel_ave_points>0)
    {
      accel_ave_x = accel_ave_x + data;
      call AccelY.getData();
      return SUCCESS;
    }

    atomic pack.xData.data1.accelx = data - accel_ave_x;
    call AccelY.getData();
    return SUCCESS;
  }

 /**
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
  *
  * @param data: Y coordinate reading form accelerometer sensor
  * @return SUCCESS
  *
  * @author    PiPeng, chenrl
  * @version   2006/12/20      chenrl
  */
  async event result_t AccelY.dataReady(uint16_t data)
  {
    // Zero out the accelerometer, chrl@20061207
    if (accel_ave_points>0)
    {
      accel_ave_y = accel_ave_y + data;
      accel_ave_points --;
      call Leds.greenOff();
      if(accel_ave_points == 0)
      {
        accel_ave_x = (accel_ave_x / ACCEL_AVERAGE_POINTS) - 450;
        accel_ave_y = (accel_ave_y / ACCEL_AVERAGE_POINTS) - 450;
        call AccelControl.stop();
      }
      return SUCCESS;
    }

    atomic pack.xData.data1.accely = data - accel_ave_y;
    post Accelstop();
    return SUCCESS;
}

  event result_t TaosControl.startDone()
  {
    return call TaosCh0.getData();
  }

  event result_t TaosControl.initDone()
  {
    return SUCCESS;
  }

  event result_t TaosControl.stopDone()
  {
    return SUCCESS;
  }

 /**
  * Taos- tsl2250 light sensor
  * Two ADC channels:
  *    ADC Count Value (ACNTx) = INT(16.5*[CV-1]) +S*CV
  *    where CV = 2^^C
  *          C  = (data & 0x7) >> 4
  *          S  = data & 0xF
  * Light level (lux) = ACNT0*0.46*(e^^-3.13*R)
  *          R = ACNT1/ACNT0
  *
  * @param data: channel_0 reading form photo sensor
  * @return SUCCESS
  *
  * @author    PiPeng, chenrl
  * @version   2006/12/20      chenrl
  */
  async event result_t TaosCh0.dataReady(uint16_t data)
  {
    atomic pack.xData.data1.taoch0 = data & 0x00ff;
    return call TaosCh1.getData();
  }

 /**
  * Taos- tsl2250 light sensor
  * Two ADC channels:
  *    ADC Count Value (ACNTx) = INT(16.5*[CV-1]) +S*CV
  *    where CV = 2^^C
  *          C  = (data & 0x7) >> 4
  *          S  = data & 0xF
  * Light level (lux) = ACNT0*0.46*(e^^-3.13*R)
  *          R = ACNT1/ACNT0
  *
  * @param data: channel_1 reading form photo sensor
  * @return SUCCESS
  *
  * @author    PiPeng, chenrl
  * @version   2006/12/20      chenrl
  */
  async event result_t TaosCh1.dataReady(uint16_t data)
  {
    atomic pack.xData.data1.taoch1 = data & 0x00ff;
    post Taosstop();
    post TempHumstart();
    return SUCCESS;
  }

  event result_t TempHumControl.startDone()
  {
    TOSH_uwait(200);
    call Humidity.getData();
    return SUCCESS;
  }

  event result_t TempHumControl.initDone()
  {
    return SUCCESS;
  }

  event result_t TempHumControl.stopDone()
  {
      return SUCCESS;
  }

  event result_t HumidityError.error(uint8_t token)
  {
      call Temperature.getData();
      return SUCCESS;
  }

  event result_t TemperatureError.error(uint8_t token)
  {
    TOSH_uwait(10);
    call TempHumControl.stop();
    TOSH_uwait(10);
    call PressureControl.start();
    return SUCCESS;
  }

 /**
  * Sensirion SHT11 humidity/temperature sensor
  * - Humidity data is 12 bit:
  *     Linear calc (no temp correction)
  *        fRH = -4.0 + 0.0405 * data -0.0000028 * data^2     'RH linear
  *     With temperature correction:
  *        fRH = (fTemp - 25) * (0.01 + 0.00008 * data) + fRH        'RH true
  * - Temperature data is 14 bit
  *     Temp(degC) = -38.4 + 0.0098 * data
  *
  * @param data: Temperature reading form humidity sensor
  * @return SUCCESS
  *
  * @author    PiPeng, chenrl
  * @version   2006/12/20      chenrl
  */
  async event result_t Temperature.dataReady(uint16_t data)
  {
    atomic pack.xData.data1.temperature = data ;
    TOSH_uwait(10);
    post TempHumstop();
    TOSH_uwait(10);
    post Pressurestart();
    return SUCCESS;
  }

 /**
  * Sensirion SHT11 humidity/temperature sensor
  * - Humidity data is 12 bit:
  *     Linear calc (no temp correction)
  *        fRH = -4.0 + 0.0405 * data -0.0000028 * data^2     'RH linear
  *     With temperature correction:
  *        fRH = (fTemp - 25) * (0.01 + 0.00008 * data) + fRH        'RH true
  * - Temperature data is 14 bit
  *     Temp(degC) = -38.4 + 0.0098 * data
  *
  * @param data: humidity reading form humidity sensor
  * @return SUCCESS
  *
  * @author    PiPeng, chenrl
  * @version   2006/12/20      chenrl
  */
  async event result_t Humidity.dataReady(uint16_t data)
  {
    atomic pack.xData.data1.humidity = data ;
    call Temperature.getData();
    return SUCCESS;
  }

  event result_t PressureControl.initDone()
  {
    return SUCCESS;
  }

  event result_t PressureControl.stopDone()
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
    call IntersemaCal.getData();
    return SUCCESS;
  }

 /**
  * Intersema MS5534A barometric pressure/temperature sensor
  *  - 6 cal coefficients (C1..C6) are extracted from 4,16 bit,words from sensor
  *
  * @param word: the number of pressure calibration data
  * @param value: pressure calibration data
  * @return SUCCESS
  *
  * @author    PiPeng, chenrl
  * @version   2006/12/20      chenrl
  */
  event result_t IntersemaCal.dataReady(char word, uint16_t value)
  {
    // make sure we get all the calibration bytes
    count++;
    calibration[word-1] = value;

    if (count == 4)
    {
      atomic
      {
        pack.xData.data1.cal_wrod1 = calibration[0];
        pack.xData.data1.cal_wrod2 = calibration[1];
        pack.xData.data1.cal_wrod3 = calibration[2];
        pack.xData.data1.cal_wrod4 = calibration[3];
      }
      call IntersemaPressure.getData();
    }
    return SUCCESS;
  }

 /**
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
  *
  * @param data: pressure reading form pressure sensor
  * @return SUCCESS
  *
  * @author    PiPeng, chenrl
  * @version   2006/12/20      chenrl
  */
  async event result_t IntersemaPressure.dataReady(uint16_t data)
  {
    pack.xData.data1.pressure = data ;
    return call IntersemaTemp.getData();
  }

 /**
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
  *
  * @param data: temperatur reading form pressure sensor
  * @return SUCCESS
  *
  * @author    PiPeng, chenrl
  * @version   2007/01/18      chenrl
  */
  async event result_t IntersemaTemp.dataReady(uint16_t data)
  {
    atomic pack.xData.data1.intersematemp = data ;
    post Pressurestop();
    post stop();
#if SENSOR_MIC
    post Micstart();
#else
    post send_radio_msg();
#endif
    return SUCCESS;
  }

///////////////////////////////////////////////////////////////////////////////////////
// The following functions are microphone related procedures.
//
///////////////////////////////////////////////////////////////////////////////////////

#if SENSOR_MIC
  void setMicParam()
  {
    atomic
    {
      call Mic.LPFsetFreq(MIC_LPF);
      call Mic.HPFsetFreq(MIC_HPF);
      call Mic.gainAdjust(MIC_GAIN);
      call Mic.detectAdjust(MIC_DETECT_ADJUST);
      call Mic.setting();
    }
  }

 /**
  * Microphone operation control procedure.
  * @return SUCCESS
  *
  * @author    PiPeng, chenrl
  * @version   2007/01/18      chenrl
  */
  event result_t Mic.InterruptEvent()
  {
//    call Mic.sampleNow();
    return SUCCESS;
  }
 /**
  * Handle completion of microphone parameters set.
  * @return SUCCESS
  *
  * @author    PiPeng, chenrl
  * @version   2007/01/18      chenrl
  */
  event result_t Mic.SetDone()
  {
//    call Mic.IntEnable();
    uint8_t i;
    for(i=0;i<100;i++)
    {
      TOSH_uwait(5000);
    }
    call Mic.sampleNow();

    return SUCCESS;
  }
 /**
  * Data ready from microphone. Keep the greatest value ever read.
  * - Microphone bias is ~512
  * - Enable microphone interruption after handle the data.
  *
  * @param value: data from microphone detect
  * @return SUCCESS
  *
  * @author    PiPeng, chenrl
  * @version   2007/01/18      chenrl
  */
  event result_t Mic.DataDone(uint16_t value)
  {
    mic_g=value;
    call Mic.MicOff();
    TOSH_uwait(100);
    post send_radio_msg();
    return SUCCESS;
  }
#endif

///////////////////////////////////////////////////////////////////////////////////////
// The following functions are PIR related procedures.
//
///////////////////////////////////////////////////////////////////////////////////////

  inline uint8_t crc8r(uint8_t crcbyte, uint8_t crc)
  {
    uint8_t i;
    for(i = 0; i < 8; i++)
    {
      if(((crc ^ crcbyte) & 0x01) == 0)
        crc >>= 1;
      else
      {
        crc ^= 0x18;//CRC=X8+X5+X4+1
        crc >>= 1;
        crc |= 0x80;
      }
      crcbyte >>= 1;
    }
    return crc;
  }

  static uint8_t calCRC(uint8_t* data)
  {
    uint8_t crc, i;
    crc = 0;
    for (i=1;i<9;i++)
    {
      crc = crc8r((uint8_t)data[i],crc);
    }
    return crc;
  }

  void sendPirParam()
  {
    uint16_t  len;
    XDataMsg *pirpack;

    // notify the user of the PIR parameters.
    if(sending_packet)
      return ;

    call PIR.IntDisable();
    atomic sending_packet=TRUE;
    pirpack = (XDataMsg*)call Send.getBuffer(msg_ptr, &len);
    pirpack->xMeshHeader.board_id = SENSOR_BOARD_ID;
    pirpack->xMeshHeader.packet_id = 5;
    pirpack->xMeshHeader.parent    = call RouteControl.getParent();
    pirpack->xMeshHeader.packet_id = pirpack->xMeshHeader.packet_id | 0x80;

    atomic pirpack->xData.pirInfo.pir_bias = pir_calib_bias;
    atomic pirpack->xData.pirInfo.pir_threshold = pir_calib_threshold;
    atomic pirpack->xData.pirInfo.pir_T = pir_calib_T ;
    atomic pirpack->xData.pirInfo.pir_N = pir_calib_N ;
    //atomic pirpack->xData.pirInfo.vref = volt ;

    // Send the RF packet!
    if (call Send.send(BASE_STATION_ADDRESS,MODE_UPSTREAM,msg_ptr, sizeof(XDataMsg)) != SUCCESS)
    {
      atomic sending_packet = FALSE;
    }
  }

  static void getPirParam()
  {
    call MTS410EEPROMControl.start();
    TOSH_uwait(1000);
    atomic bPirParam = TRUE;
    call MTS410EEPROM.readPacket(0,10,0x03);
  }
 /**
  * Handle completion of reading EEPROM for the PIR parameters
  *
  * @param length: data length read from EEPROM
  * @param data: parameter structure
  * @return SUCCESS when get the right data, else return FAIL
  *
  * @author    PiPeng, chenrl
  * @version   2007/01/18      chenrl
  */
  event result_t MTS410EEPROM.readPacketDone(char length, char* data)
  {
    uint8_t crc;

    // data length unmatch
    if (length != 10)
    {
      // retry to read the parameters.
      call MTS410EEPROM.readPacket(0,10,0x03);
      return FAIL;
    }
    // to get rid of strange periodic PIRInfo packet
    if (bPirParam == FALSE)
    {
      return SUCCESS;
    }
    atomic bPirParam = FALSE;
    call MTS410EEPROMControl.stop();
    // check the data read from EEPROM
    if ((uint8_t)data[0] == 0x24)
    {
      // CRC match
      crc = (uint8_t)data[9];
      if (crc == calCRC(data))
      {
        atomic
        {
          pir_calib_bias      = (uint16_t)( (((uint8_t)data[2])<<8) | ((uint8_t)data[1]) );
          pir_calib_threshold = (uint16_t)( (((uint8_t)data[4])<<8) | ((uint8_t)data[3]) );
          pir_calib_N         = (uint16_t)( (((uint8_t)data[6])<<8) | ((uint8_t)data[5]) );
          pir_calib_T         = (uint16_t)( (((uint8_t)data[8])<<8) | ((uint8_t)data[7]) );
          pir_adc_init_thresh = pir_calib_threshold;

        // calculate the VR value
        /***********************************************************************************
         Value of the variable resistor used by PIR:
           VR = pir_adjust_threshold*100/256 + 0.06 (Kohm)
         PIR threshold of INT7(lower limit):
           100(Kohm)*1023(ADCs)/(100 + (100+VR))(Kohm)= pir_calib_bias - pir_calib_threshold
         So we can get:
           pir_adjust_threshold ~= 1023*256/(pir_calib_bias - pir_calib_threshold) - 512
                                 = (261888/(pir_calib_bias - pir_calib_threshold)) - 512
        ************************************************************************************/
          pir_adjust_threshold = (261888/(pir_calib_bias - pir_calib_threshold)) - 512;
          if (pir_adjust_threshold >255)
          {
            pir_adjust_threshold = 255;
          }
        }
      }
    }
    // set pir parameter
    // if the reference voltage is obtained, i.e. not the first time to set pir parameter
    if (volt<= LOWER_VREF && volt >= UPPER_VREF)
    {
      atomic pir_calib_threshold = volt * pir_adc_init_thresh / STANDARD_VREF;
      atomic pir_readjust = (261888/(pir_calib_bias - pir_calib_threshold)) - 512;
      atomic call PIR.IntDisable();
      call PIR.detectAdjust((uint8_t)pir_readjust);
    }
    else
    {
      atomic call PIR.IntDisable();
      call PIR.detectAdjust((uint8_t)pir_adjust_threshold); // lower value => more sensitive
    }
    // send back the current parameters.
    sendPirParam();

    if(pirParamChanged)
    {
      atomic pirParamChanged = FALSE;
      call Timer.start(TIMER_REPEAT, timer_rate);
    }
    call Leds.redOff();
    return SUCCESS;
  }

  static void storePirParam()
  {
    call Leds.redOn();
    call Timer.stop();
    call PIRTimer.stop();
    PIR_trigger_count = 0;
    pir_event_count = 0;

#if SENSOR_MIC
    call Mic.MicOff();
#endif
    // start flag
    WData[0] = 0x24;
    // pir_calib_bias
    WData[1] = (uint8_t)pir_calib_bias;
    WData[2] = (uint8_t)((pir_calib_bias>>8) & 0xff);
    // pir_calib_threshold
    WData[3] = (uint8_t)pir_calib_threshold;
    WData[4] = (uint8_t)((pir_calib_threshold>>8) & 0xff);
    // pir_calib_N
    WData[5] = (uint8_t)pir_calib_N;
    WData[6] = (uint8_t)((pir_calib_N>>8) & 0xff);
    // pir_calib_T
    WData[7] = (uint8_t)pir_calib_T;
    WData[8] = (uint8_t)((pir_calib_T>>8) & 0xff);
    // crc
    WData[9] = calCRC(WData);

    call MTS410EEPROMControl.start();
    TOSH_uwait(100);
    call MTS410EEPROM.writePacket(0,10,(char*)(WData),0x01);
  }

 /**
  * Handle completion of writing EEPROM for the PIR parameters
  *
  * @param result: the write operation success or fail
  * @return SUCCESS or FAIL
  *
  * @author    PiPeng, chenrl
  * @version   2006/12/20      chenrl
  */
  event result_t MTS410EEPROM.writePacketDone(bool result)
  {
    if(result)
    {
      atomic pirParamChanged = TRUE;
      TOSH_uwait(3000);
      atomic bPirParam = TRUE;
      call MTS410EEPROM.readPacket(0,10,0x03);
      return SUCCESS;
    }
    else
    {
      // retry to write the parameters.
      call MTS410EEPROM.writePacket(0,10,(char*)(WData),0x01);
    }
    return FAIL;
  }

 /**
  * Data ready from PIR
  * - test value when the interruption is valid.
  * - Keep the value with the greatest offset from 512, except 0 value
  * - PIR bias is ~512
  *
  * @param value: data from PIR window detect
  * @return SUCCESS
  *
  * @author     PiPeng, chenrl
  * @version   2006/12/20      chenrl
  */
  event result_t PIR.DataDone(uint16_t value)
  {
    uint16_t val1;
    call Leds.redOff();
    atomic 
    {
      val1 = abs(value - pir_calib_bias);
    }
    if(val1>pir_g)
    {
      pir_g = val1;
      if (pir_g >512) pir_g = 512;
    }
    if (val1 >= pir_calib_threshold)
    {
      if (PIR_trigger_count==0)
      {
        call PIRTimer.start(TIMER_ONE_SHOT,pir_calib_T);
        PIR_trigger_count=1;
      }
    }
    if (bPirSample)
    {
      bPirSample = FALSE;
    }
    else
    {
      call PIR.IntEnable();
    }
    return SUCCESS;
  }

 /**
  * PIR window threshold crossed.
  *
  * Interrupt driver disables interrupt before signaling this event
  * - Increase the PIR interruption count.
  * - Enable PIR interruption.
  * @return SUCCESS
  *
  * @author    PiPeng, chenrl
  * @version   2006/12/20      chenrl
  */
  event result_t PIR.InterruptEvent()
  {
    call Leds.redOn();
    atomic
    {
      call PIR.sampleNow();
      if (PIR_trigger_count >0)
      {
        PIR_trigger_count++;
      }
    }
    return SUCCESS;
   }

 /**
  * PIR interruption validation timer.
  * @return SUCCESS
  *
  * @author    PiPeng, chenrl
  * @version   2006/12/20      chenrl
  */
  event result_t PIRTimer.fired()
  {
    atomic call PIR.IntDisable();

    if (PIR_trigger_count >= pir_calib_N)
    {
      pir_event_count++;
    }
    PIR_trigger_count = 0;
    call PIR.IntEnable();
    return SUCCESS;
  }

 /**
  * Handle completion of PIR threshold set.
  * @return SUCCESS
  *
  * @author    PiPeng, chenrl
  * @version   2006/12/20      chenrl
  */
  event result_t PIR.detectAdjustDone()
  {
    call PIR.IntEnable();
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
    // if (msg->addr == TOS_UART_ADDR) {
    atomic msg_ptr = msg;
    msg_ptr->addr = TOS_BCAST_ADDR;

    if (call Send.send(BASE_STATION_ADDRESS,MODE_UPSTREAM,msg_ptr, sizeof(XDataMsg)) != SUCCESS)
    {
      atomic sending_packet = FALSE;
      call Leds.yellowOff();
    }

    if (TOS_LOCAL_ADDRESS != 0) // never turn on power mgr for base
    call PowerMgrEnable();

    //}
    return SUCCESS;
  }
#endif

 /**
  * Handle completion of sent RF packet.
  *
  * @author    Martin Turon
  * @version   2007/01/18     chenrl
  */
  event result_t Send.sendDone(TOS_MsgPtr msg, result_t success)
  {
    atomic
    {
      msg_ptr = msg;
      sending_packet = FALSE;
    }
    call Leds.yellowOff();

    if (reajust_counter >= (uint16_t)(RE_ADJUST_INTERVAL/timer_rate) )
    { 
      if (volt<= LOWER_VREF && volt >= UPPER_VREF)
      {
        reajust_counter = 0;
//        pir_readjust = volt * pir_calib_threshold / STANDARD_VREF;
//        pir_readjust = (261888/(pir_calib_bias - pir_readjust)) - 512;
        pir_calib_threshold = volt * pir_adc_init_thresh / STANDARD_VREF;
        pir_readjust = (261888/(pir_calib_bias - pir_calib_threshold)) - 512;
        atomic call PIR.IntDisable();
        call PIR.detectAdjust((uint8_t)pir_readjust);
        sendPirParam();
      }
    }
    else
    {
      call PIR.IntEnable();
    }

#if FEATURE_UART_SEND
    if (TOS_LOCAL_ADDRESS != 0) // never turn on power mgr for base
    call PowerMgrEnable();
#endif
    return SUCCESS;
  }

 /**
  * Handles all broadcast command messages sent over network.
  *
  * NOTE: Bcast messages will not be received if seq_no is not properly
  *       set in first two bytes of data payload.  Also, payload is
  *       the remaining data after the required seq_no.
  *
  * @version   2007/01/18   chenrl
  */
  event result_t XCommand.received(XCommandOp *opcode)
  {
    bool bPirChanged = FALSE;
    switch (opcode->cmd)
    {
    case XCOMMAND_CUSTOM_ACTION: // customized parameters for MTS410
      switch (opcode->param.custom_data.type)
      {
      case 0: // reset to default value
        atomic
        {
          pir_calib_bias = PIR_DEF_BIAS;
          pir_calib_threshold = PIR_DEF_THRESHOLD;
          pir_calib_N = PIR_VALID_CNT;
          pir_calib_T = PIR_MONITOR_TIMER;
          bPirChanged = TRUE;
        }
        break;
      case 1: // pir_calib_bias
        if (pir_calib_bias != opcode->param.custom_data.value)
        {
          pir_calib_bias = opcode->param.custom_data.value;
          bPirChanged = TRUE;
        }
        break;
      case 2: // pir_calib_threshold
        if (pir_calib_threshold != opcode->param.custom_data.value)
        {
          pir_calib_threshold = opcode->param.custom_data.value;
          if (pir_calib_threshold > 511)
          {
            pir_calib_threshold = 511;
          }
          // calculate the VR value
          /***********************************************************************************
           Value of the variable resistor used by PIR:
             VR = pir_adjust_threshold*100/256 + 0.06 (Kohm)
           PIR threshold of INT7(lower limit):
             100(Kohm)*1023(ADCs)/(100 + (100+VR))(Kohm)= pir_calib_bias - pir_calib_threshold
           So we can get:
             pir_adjust_threshold ~= 1023*256/(pir_calib_bias - pir_calib_threshold) - 512
                                   = (261888/(pir_calib_bias - pir_calib_threshold)) - 512
          ************************************************************************************/
          pir_adjust_threshold = (261888/(pir_calib_bias - pir_calib_threshold)) - 512;
          if (pir_adjust_threshold >255)
          {
            pir_adjust_threshold = 255;
          }
          bPirChanged = TRUE;
        }
        break;
      case 3: // pir_calib_N
        if (pir_calib_N != opcode->param.custom_data.value)
        {
          pir_calib_N = opcode->param.custom_data.value;
          bPirChanged = TRUE;
        }
        break;
      case 4: // pir_calib_T
        if (pir_calib_T != opcode->param.custom_data.value)
        {
          pir_calib_T = opcode->param.custom_data.value;
          bPirChanged = TRUE;
        }
        break;
      default:
        break;
      }
      if (bPirChanged)
      {
       atomic storePirParam();
      }
      else
      {
        atomic sendPirParam();
      }
      break;
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
      call StdControl.stop();
      break;

    case XCOMMAND_WAKEUP:
      // Wake up from sleep state.
      if (sleeping)
      {
        initialize();
        call Timer.start(TIMER_REPEAT, timer_rate);
        sleeping = FALSE;
      }
      break;

    case XCOMMAND_RESET:
      // Reset the mote now.
      break;

    case XCOMMAND_ACTUATE:
      state = opcode->param.actuate.state;
      if (opcode->param.actuate.device != XCMD_DEVICE_SOUNDER)
      break;

    default:
      break;
    }

    return SUCCESS;
  }
/*
#ifdef XMESHSYNC
  task void SendPing()
  {
    XDataMsg *pReading;
    uint16_t Len;

    if ((pReading = (XDataMsg *)call Send.getBuffer(msg_ptr,&Len)))
    {
      pReading->xMeshHeader.parent = call RouteControl.getParent();
      if ((call Send.send(msg_ptr,sizeof(XDataMsg))) != SUCCESS)
        atomic sending_packet = FALSE;
    }
  }

  event TOS_MsgPtr DownTree.receive(TOS_MsgPtr pMsg, void* payload, uint16_t payloadLen)
  {
    if (!sending_packet)
    {
      call Leds.yellowToggle();
      atomic sending_packet = TRUE;
      post SendPing();  //  pMsg->XXX);
    }
    return pMsg;
  }
#endif
*/

  event result_t XEEControl.restoreDone(result_t result)
  {
    if(result)
    {
      call Timer.stop();
      call Timer.start(TIMER_REPEAT, timer_rate);
    }
    return SUCCESS;
  }

// end of implementation
}
