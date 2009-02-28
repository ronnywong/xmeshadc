/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: TestMTS410M.nc,v 1.3.4.2 2007/04/26 20:34:45 njain Exp $
 */

/** 
 * XSensor single-hop application for MTS410 sensorboard.
 *
 * @author PiPeng
 */


#include "appFeatures.h"

includes sensorboard;

module TestMTS410M {
  provides {
    interface StdControl;
  }
  uses {
  
	interface Leds;

  	//communication
	interface StdControl as CommControl;
	interface SendMsg as Send;
	interface ReceiveMsg as Receive;

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
    interface Timer as DetectTimer;
    
    interface Timer;


#if FEATURE_UART_SEND
	interface SendMsg as SendUART;
	command result_t PowerMgrEnable();
	command result_t PowerMgrDisable();
#endif
  command void health_packet(bool enable, uint16_t intv);
  }
}

implementation {
	
  enum { START, BUSY, BATT_DONE, TEMP_DONE, LIGHT_DONE};


    char count;
    uint16_t calibration[4];           //intersema calibration words
    norace uint8_t  state;                    //
    uint8_t  IsSampling;
    
    TOS_Msg msg_buf;
    TOS_MsgPtr msg_ptr;
    norace bool sending_packet,sleeping,IsUART;
    norace XDataMsg* pack;

//mic
    uint16_t	mic_g;
//pir
    uint16_t	pir_g;
    uint8_t     PIR_Detect_State;         //tracks state of pir detection alg
    uint16_t    PIR_cnt;                  //cnts pirs
    uint8_t     bPIRstate;                //tracks pir hi/lo detects
    uint8_t     SetFlag;
    uint8_t     WarmUpFlag;
    
//sounder
    bool        bSounder;                 //true if sounder activated for detect events 
   uint8_t      detectflag;
   uint8_t	bTriggered;
   uint8_t	bStart;
   uint16_t     detectcnt;


  static void initialize() 
    {
    atomic{
        IsSampling=FALSE;
        sending_packet=FALSE;
        detectflag=0;
        WarmUpFlag=0;
        IsUART = TRUE;
        
        SetFlag=SET_PARAM;
#if !SENSOR_MIC
	SetFlag= 0x01;
#endif
        detectcnt=0;
        bTriggered=0;
        bStart=0;
//init pir params       
	pir_g			= 0;
        PIR_Detect_State = PIR_IDLE;
        PIR_cnt = 0;
// sounder
        bSounder = FALSE;            //set true for sounder activation on sensor event
    	timer_rate = 8000;
      }
    }

  task void DetectFunc();
  task void SendMsgFunc();
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
       TOSH_uwait(10000);
       }
       call AccelX.getData();
    }
    task void Accelstop()
    {
    	call AccelControl.stop();
    }
    task void Taosstart()
    {
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
    
#if SENSOR_MIC
  
  void setMicParam()
  {
  atomic{
      call Mic.LPFsetFreq(MIC_LPF);	
      call Mic.HPFsetFreq(MIC_HPF);
      call Mic.gainAdjust(MIC_GAIN);
      call Mic.detectAdjust(MIC_DETECT_ADJUST);	
      call Mic.setting();
      }
  }
#endif
  
  void setPirParam()
  {
      call PIR.detectAdjust(PIR_DETECT_ADJUST); // lower value => more sensitive
  }
  
  void detectBegin()
  {
#if SENSOR_MIC
     call Mic.IntEnable();
#endif
     call PIR.IntEnable();
  }
  
  void detectStop()
  {
     call PIR.IntDisable();
#if SENSOR_MIC
     call Mic.IntDisable();
     TOSH_uwait(10);
     call Mic.MicOff();
#endif
//     call PIR.Off();
  }

/****************************************************************************
 * Task to xmit radio message
 *
 ****************************************************************************/
   task void send_radio_msg(){
    call Send.send(TOS_BCAST_ADDR,sizeof(XDataMsg),msg_ptr);
    return;
  }
    
/****************************************************************************
 * Task to uart as message
 *
 ****************************************************************************/
   task void send_uart_msg(){
    if(sending_packet) return;    
    atomic sending_packet=TRUE;
    call Leds.yellowToggle();
    pack->xSensorHeader.board_id  = SENSOR_BOARD_ID;
    pack->xSensorHeader.packet_id = 1;    
    pack->xSensorHeader.node_id   = TOS_LOCAL_ADDRESS;
//	pack->xSensorHeader.rsvd    = 0;
    pack->xData.data1.pir = pir_g ;
    pack->xData.data1.audio = mic_g ;
    pir_g = 0;
    mic_g = 0;
    call Send.send(TOS_UART_ADDR,sizeof(XDataMsg),msg_ptr);
    return;
  }

 /****************************************************************************
 * Initialize the component. Initialize ADCControl, Leds
 *
 ****************************************************************************/
  command result_t StdControl.init() {
  	
    atomic {
    msg_ptr = &msg_buf;
    sending_packet=FALSE; 
    }
      atomic pack = (XDataMsg *)msg_ptr->data;  
// usart1 is also connected to external serial flash
// set usart1 lines to correct state
    TOSH_MAKE_FLASH_OUT_OUTPUT();             //tx output
    TOSH_MAKE_FLASH_CLK_OUTPUT();             //usart clk
    
      call Sounder.Off();
      call ADCControl.bindPort(TOS_ADC5_PORT, TOSH_ACTUAL_ADC5_PORT);
      call ADCControl.bindPort(TOS_ADC6_PORT, TOSH_ACTUAL_ADC6_PORT);
      call BattControl.init();    
      call AccelControl.init();    
      call CommControl.init();
#if SENSOR_MIC
      call MicControl.init();
#else    
      TOSH_MAKE_PW3_OUTPUT(); TOSH_SET_PW3_PIN();
#endif
      call PirControl.init();    
      call Leds.init();
      call TaosControl.init();
      call TempHumControl.init();    //init Sensirion
      call PressureControl.init();   // init Intersema
      call ADCControl.init();
      call RelayControl.init();

      initialize();
   	return SUCCESS;

  }
 /****************************************************************************
 * Start the component. Start the clock.
 *
 ****************************************************************************/
  command result_t StdControl.start(){
    call CommControl.start();
    call Timer.start(TIMER_REPEAT, timer_rate);
      TOSH_uwait(1000);
    call DetectTimer.start(TIMER_REPEAT, DETECT_INTERVAL);    //start up sensor measurements
    return SUCCESS;	
  }
 /****************************************************************************
 * Stop the component.
 *
 ****************************************************************************/
  command result_t StdControl.stop() {
    call BattControl.stop(); 
    call AccelControl.stop();
    call TaosControl.stop();
    call TempHumControl.stop();
    call PressureControl.stop();
    return SUCCESS;    
  }
/****************************************************************************
 * Measure Temp, Light  
 *
 ****************************************************************************/
event result_t Timer.fired() {
      WarmUpFlag=1;
      if(IsSampling) return SUCCESS;
      bTriggered=1;
      return SUCCESS;  
  }

/****************************************************************************
 * Battery Ref  or thermistor data ready 
 ****************************************************************************/
  async event result_t ADCBATT.dataReady(uint16_t data) {
      atomic pack->xData.data1.vref = data ;
      atomic state = BATT_DONE;
      call ADC5.getData();
      return SUCCESS;
  }
  
  async event result_t ADC5.dataReady(uint16_t data) {
       atomic pack->xData.data1.adc5 = data ;
       call ADC6.getData();
       return SUCCESS;        
  }
  async event result_t ADC6.dataReady(uint16_t data) {
       atomic pack->xData.data1.adc6 = data ;
       post Accelstart();
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
 
/***************************************************/
async  event result_t AccelX.dataReady(uint16_t  data){
    atomic pack->xData.data1.accelx = data;
    call AccelY.getData();
    return SUCCESS;
  }
  
async event result_t AccelY.dataReady(uint16_t data){
    atomic pack->xData.data1.accely = data;
    post Accelstop();
    post Taosstart();
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
  event result_t TaosControl.startDone(){
      return call TaosCh0.getData();
  }
  
  event result_t TaosControl.initDone() {
      return SUCCESS;
  }
  
  event result_t TaosControl.stopDone() {
      return SUCCESS;
  }

  async event result_t TaosCh0.dataReady(uint16_t data) {
      atomic pack->xData.data1.taoch0 = data & 0x00ff;
      return call TaosCh1.getData();
  }
  
  async event result_t TaosCh1.dataReady(uint16_t data) {

      atomic pack->xData.data1.taoch1 = data & 0x00ff;
      post Taosstop();
      post TempHumstart();
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
  event result_t TempHumControl.startDone() {
      TOSH_uwait(200);
      call Humidity.getData();
      return SUCCESS;
  }
  
  event result_t TempHumControl.initDone() {
      return SUCCESS;
  }
  
  event result_t TempHumControl.stopDone() {
      return SUCCESS;
  }
  
  event result_t HumidityError.error(uint8_t token) {
      call Temperature.getData();
      return SUCCESS;
  }
  
  
  event result_t TemperatureError.error(uint8_t token) {
      TOSH_uwait(10);
      call TempHumControl.stop();
      TOSH_uwait(10);
      call PressureControl.start();
      return SUCCESS;
  }

  async event result_t Temperature.dataReady(uint16_t data) {
      atomic pack->xData.data1.temperature = data ;
      TOSH_uwait(10);
      post TempHumstop();
      TOSH_uwait(10);
      post Pressurestart();
      return SUCCESS;
  }
  
  async event result_t Humidity.dataReady(uint16_t data) {
      atomic pack->xData.data1.humidity = data ;
      call Temperature.getData();
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
  event result_t PressureControl.initDone() {
      return SUCCESS;
  }

  event result_t PressureControl.stopDone() {
      return SUCCESS;
  }

  event result_t PressureControl.startDone() {
      count = 0;

      call IntersemaCal.getData();
      return SUCCESS;
  }
  
  event result_t IntersemaCal.dataReady(char word, uint16_t value) {
      // make sure we get all the calibration bytes
      count++;
      
      calibration[word-1] = value;
      
      if (count == 4) {	  
      atomic {
	  pack->xData.data1.cal_wrod1 = calibration[0];
	  pack->xData.data1.cal_wrod2 = calibration[1];
	  pack->xData.data1.cal_wrod3 = calibration[2];
	  pack->xData.data1.cal_wrod4 = calibration[3];
	  }
	  call IntersemaPressure.getData();
      }
      
      return SUCCESS;
  }

  async event result_t IntersemaPressure.dataReady(uint16_t data) {    
      pack->xData.data1.pressure = data ;
      return call IntersemaTemp.getData();
  }
  
  async event result_t IntersemaTemp.dataReady(uint16_t data) {
      atomic pack->xData.data1.intersematemp = data ;
      post Pressurestop();
      post stop();
      post send_uart_msg();
      return SUCCESS;
  }
  
    /**************************************************************************
     * PIRTimer.fired
     * - read a pir adc value
     * @return SUCCESS
     *************************************************************************/
    
    event result_t DetectTimer.fired(){
        if(IsSampling) return SUCCESS;
        detectcnt=detectcnt+1;
        post DetectFunc();
	return SUCCESS;
    }
    
    task void DetectFunc()
    {
        if(detectcnt<TRIGGER_CNT)
        {
        	if(detectcnt==1)
        	{
		     call PIR.On();
#if SENSOR_MIC
		     call Mic.MicOn();
#endif
        	}
	        if(SetFlag > 0)
	        {
	                if((SetFlag & 0x01)!=0)
	                {
	                 setPirParam();
	                }
#if SENSOR_MIC
	                else
	                {
	                 setMicParam();
	                }
#endif
	        	return ;
	        }
	        else
	        {
	                call Leds.greenOn();
	                if(bStart==0)
	                {
        		detectBegin();
        		bStart=1;
        		}
        		if(detectcnt==(TRIGGER_CNT-1))
        		{
#if SENSOR_MIC
//        			if(mic_g==0)
        			{
        			call Mic.sampleNow();
        			}
#endif
		        	if(pir_g==0)
		        	{
		        		call PIR.sampleNow();
		        	}
        		}
        	}
	}
        else if(detectcnt==TRIGGER_CNT)	
        {
	        call Leds.greenOff();
        	detectStop();
        }
        else
        {
        	if(bTriggered==1)// && (!IsSampling))
        	{
        	        if(sending_packet )//|| IsSampling)
        	        {
        	            return ;
        	        }
        		atomic {
        		IsSampling=TRUE;
        		bTriggered=0;
        		}
      			post SendMsgFunc();
        	}
        	if(detectcnt>DETECT_CNT)
        	{
        		IsSampling=FALSE;
        		detectcnt=0;
        		bStart=0;
        	}
        }
	return ;
    }
    
    task void SendMsgFunc()
    {
      	start();
      	call ADCBATT.getData();
      	return;
    }
    /**************************************************************************
     * Data ready from PIR
     * - test value every 1 msec.
     * - test for max time of 500msec
     * - if adc data does not toggle from max to min then reject
     * - PIR interrupt is off  
     * - value = data from PIR window detect
     * - PIR bias is ~512
     * - On first detect: if
     * @return SUCCESS
     ***************************************************************************/
    
    event result_t PIR.DataDone(uint16_t value){
        uint8_t val1,val2;
	call Leds.redOff();
	if(pir_g!=0)
	{
	atomic{
		val1=abs(pir_g-512);
		val2=abs(value-512);
		if(val2 < val1)
		{
		        pir_g = value ;
	        }
	}
	}
	else
	{
		pir_g=value;
	}
	return SUCCESS;	 
    }	
    
    /**************************************************************************
	 * PIR window threshold crossed.
	 * 
	 * Interrupt driver disables interrupt before signaling this event
	 * - keep PIR interrupt off.
	 * - Get PIR data
	 * @return SUCCESS
	 *************************************************************************/
    event result_t PIR.InterruptEvent(){
	//!!!     SODbg(DBG_USR2, "PIR INTERUPT event \n");
	call Leds.redOn();
	if(WarmUpFlag && detectcnt<TRIGGER_CNT)
	{
        	bTriggered=1;
        	call PIR.sampleNow();
        }
	return SUCCESS;
    }
    
    /**************************************************************************
     * PIR detection threshold set
     *************************************************************************/
    event result_t PIR.detectAdjustDone(){
    atomic{
        SetFlag=SetFlag & 0x02;
        }
	return SUCCESS;
    }
    
#if SENSOR_MIC
    event result_t Mic.InterruptEvent(){
//        bTriggered=1;
        call Mic.sampleNow();
	return SUCCESS;
    }
    
    event result_t Mic.SetDone(){
    atomic{
        SetFlag=SetFlag & 0x01;
        }
        return SUCCESS;
    }
    
    event result_t Mic.DataDone(uint16_t value)
    {
			if(mic_g < value)
			{
	  	  atomic{
	        mic_g = value ;
	    		}
      }
   		call Mic.IntEnable();
			return SUCCESS;
    }  
#endif

/****************************************************************************
 * Radio msg xmitted. 
 ****************************************************************************/
  event result_t Send.sendDone(TOS_MsgPtr msg, result_t success) {

    call Leds.yellowOff();

      if(IsUART)
      { 
        IsUART=FALSE;  
        post send_radio_msg();
      }
      else
      {
        IsUART=TRUE;  
        atomic msg_ptr = msg;
      atomic sending_packet=FALSE;
      atomic IsSampling=FALSE;    
      }
    
   return SUCCESS;
  }
  
  /****************************************************************************
 * Uart msg rcvd. 
 * This app doesn't respond to any incoming uart msg
 * Just return
 ****************************************************************************/
  event TOS_MsgPtr Receive.receive(TOS_MsgPtr data) {
      return data;
  }
  
  


}

