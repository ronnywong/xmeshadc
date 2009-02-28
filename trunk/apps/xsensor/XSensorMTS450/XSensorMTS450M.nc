/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: XSensorMTS450M.nc,v 1.4.4.1 2007/04/26 20:36:17 njain Exp $
 */

/** 
 * XSensor single-hop application for MTS450 sensorboard.
 *
 * @author Tang Junhua, Pi Peng
 */


 //for debugging using serial port
//#define SODBGON 1
//includes SOdebug;

module XSensorMTS450M {
    provides interface StdControl;
    uses {
    interface Leds;
	interface Timer;
	 
	//communication interface
    interface StdControl as CommControl;
	interface SendMsg as Send;
	interface ReceiveMsg as Receive;
	
	//humidity and temp sensor interface
	interface SplitControl as ADCControl;
    interface ADC as Humidity;
    interface ADC as Temperature;
    interface ADCError as HumidityError;
    interface ADCError as TemperatureError;

	//eeprom interface
	interface StdControl as MTS450EEPROMControl;
	interface MTS450EEPROM;

	//7828 ADC interface for CTS sensor 
	interface StdControl as MTS450CTSControl;
	interface MTS450CTS;
	
	//voltage interface
	interface StdControl as BattControl;
	interface ADC as ADCBATT;
	
	
    }
}
implementation {
  /**
   * Initialize this and all low level components used in this application.
   * 
   * @return returns <code>SUCCESS</code> or <code>FAIL</code>
   */
   uint8_t i;
   uint16_t temp1;
   uint16_t temp2;
   TOS_Msg msg_buf;
   TOS_MsgPtr msg_ptr;
   XDataMsg *pack;
   bool end;
/****************************************************************************
 * Task to uart as message
 *
 ****************************************************************************/
   task void send_uart_msg(){
    //if(sending_packet) return;    
    //atomic sending_packet=TRUE;
    //atomic bIsUart=TRUE;
    call Send.send(TOS_UART_ADDR,sizeof(XDataMsg),msg_ptr);
    return;
  }
  task void send_radio_msg(){
    //if(sending_packet) return;    
    //atomic sending_packet=TRUE;
    //atomic bIsUart=TRUE;
    end=TRUE;
    call Send.send(TOS_BCAST_ADDR,sizeof(XDataMsg),msg_ptr);
    return;
  }
  
  task void start()
  {
      call BattControl.start();
      call HumidityError.enable();
      call TemperatureError.enable();
      call CommControl.start();
      call MTS450EEPROMControl.start();
      call MTS450CTSControl.start();
      call ADCControl.start();
  }
  
  task void Battstop()
  {
      call BattControl.stop();
  }

  task void Adcstart()
  {
      call ADCControl.start();
  }
  task void Adcstop()
  {
      call ADCControl.stop();
  }

  task void EEPROMRead()
  {
      call MTS450EEPROM.readPacket(0,10,0x03);
  }

   
  
  command result_t StdControl.init() 
  {
	  
	atomic 
	{
		msg_ptr = &msg_buf;
		pack=(XDataMsg *)msg_ptr->data;
	}
    call ADCControl.init();
    call MTS450EEPROMControl.init();
    call MTS450CTSControl.init();
    call CommControl.init();
    call BattControl.init();
    call Leds.init();
    
    return SUCCESS;
  }

  /**
   * Start this component.
   * 
   * @return returns <code>SUCCESS</code>
   */
  command result_t StdControl.start()
  {
    
    //call BattControl.start();
    pack->xSensorHeader.board_id = SENSOR_BOARD_ID;
    pack->xSensorHeader.packet_id = 1;     // Only one packet for MDA500
    pack->xSensorHeader.node_id = TOS_LOCAL_ADDRESS;
	
	//start a timer repeating  to get samples every 2 seconds
    call BattControl.start();
	call Timer.start(TIMER_REPEAT, 2000);
    return SUCCESS;
  }

  /**
   * Stop this component.
   * 
   * @return returns <code>SUCCESS</code>
   */
  command result_t StdControl.stop() 
  {
    call ADCControl.stop();
    call CommControl.stop();
    call MTS450EEPROMControl.stop();
    call MTS450CTSControl.stop();
    call BattControl.stop();
    call Timer.stop();
    return SUCCESS;
  }

  event result_t ADCControl.initDone() 
  {
    
	return SUCCESS;
  }

  event result_t ADCControl.stopDone() 
  {
    return SUCCESS;
  }
  
  

  event result_t Timer.fired() {
    // sample
    end=FALSE;
    call ADCBATT.getData();
    return SUCCESS;
  }
   async event result_t ADCBATT.dataReady(uint16_t data) 
  {
      //voltage data      
      pack->xData.datap1.vref = data;
      post Battstop();
      post start();
      return SUCCESS;
  } 
   

  event result_t ADCControl.startDone() {
    //start to sample humidity data	
//    TOSH_uwait(1500);
    call MTS450CTS.getData();
    return SUCCESS;
  }
  
  event result_t MTS450CTS.dataReady(char* data)  {
	//CO data
	call Leds.greenOn(); 
//	call MTS450CTSControl.stop();
	temp1=data[0];
	temp1=temp1&0x0f;
	temp1=temp1<<8;
	temp2=data[1];
	temp2=temp2&0xff;
	pack->xData.datap1.gas = temp1|temp2;
	if(SOUNDER)
	{
		if(pack->xData.datap1.gas>0xB4)
		{
		TOSH_SET_PW2_PIN();
		}
		else
		{
		TOSH_CLR_PW2_PIN();
		}
	}
    call Humidity.getData();
    return SUCCESS;
   }

  event result_t HumidityError.error(uint8_t token)
  {
	//humidity invalid;
	call Leds.yellowToggle();
	pack->xData.datap1.humid = 0;
    call Temperature.getData();
    return SUCCESS;
  }

  
  async event result_t Humidity.dataReady(uint16_t data)
  {
    //humidity data
    
    pack->xData.datap1.humid = data;
    call Temperature.getData();
    return SUCCESS;
  }
  event result_t TemperatureError.error(uint8_t token)
  {
    
    //temp invalid
    call ADCControl.stop();
    pack->xData.datap1.temp = 0;    
    call MTS450EEPROM.readPacket(0,10,0x03);
    return SUCCESS;
  }

 async event result_t Temperature.dataReady(uint16_t data)
  { 
    //temp data
    post Adcstop();
    pack->xData.datap1.temp = data;    
    post EEPROMRead();
    return SUCCESS;
  }
    
 
  event result_t MTS450EEPROM.readPacketDone(char length, char* data) 
  {
     //eeprom data
     call MTS450EEPROMControl.stop();
     if(length==10)
     {
	     for(i=0;i<5;i++)
	     {
		     temp1=data[2*i];
		     temp1=temp1<<8;
		     temp1=temp1&0xff00;
		     temp2=data[2*i+1];
		     temp2=temp2&0xff;
		     pack->xData.datap1.cal[i] = temp1|temp2;		     
		 }
	 }
     else
     {
	     for(i=0;i<5;i++)
	     {
		     pack->xData.datap1.cal[i] = 0;	
		 }
	 }
     
     call Leds.greenOff();
     call Leds.redOn();
     post send_uart_msg();
     return SUCCESS;
  }
  
  event result_t Send.sendDone(TOS_MsgPtr sent_msgptr, result_t success)
  { 
	if(end)
	{
		call CommControl.stop();
		call BattControl.start();
        call Leds.redOff();    
    }
    else
    {
	    post send_radio_msg();
	}
    return SUCCESS;
  }
  
  event TOS_MsgPtr Receive.receive(TOS_MsgPtr data) {
      return data;
  }
  event result_t MTS450EEPROM.writePacketDone(bool result)
  {
	  //actually no read operation
	  return SUCCESS;	  
  }

}
