/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: XMDA325M.nc,v 1.7.2.4 2007/04/26 20:10:04 njain Exp $
 */

/** 
 * XSensor multi-hop application for MDA325 sensorboard.
 *
 * @author PiPeng
 */

// include sensorboard.h definitions from tos/mda300 directory
#include "appFeatures.h"
includes XCommand;


includes sensorboard;
module XMDA325M
{
  
    provides interface StdControl;
  
    uses {
	interface Leds;

	interface MhopSend as Send;
	interface RouteControl;
	/*
#ifdef XMESHSYNC
    interface Receive as DownTree; 	
#endif  		*/
	interface XCommand;
	interface XEEControl;

	//Sampler Communication
	interface StdControl as SamplerControl;
	interface Sample;

    
	//Timer
	interface Timer;
	interface Timer as TO_Timer;

	//support for plug and play
	command result_t PlugPlay();

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
#define ANALOG_SAMPLING_TIME    90
#define DIGITAL_SAMPLING_TIME  100
#define MISC_SAMPLING_TIME     110

#define ANALOG_SEND_FLAG  1
#define DIGITAL_SEND_FLAG 1
#define MISC_SEND_FLAG    1
#define ERR_SEND_FLAG     1

#define PACKET_FULL	0x1FF

#define MSG_LEN  29   // excludes TOS header, but includes xbow header
    
    enum {
	PENDING = 0,
	NO_MSG = 1
    };        

    enum {
	MDA300_PACKET1 = 1,
	MDA300_PACKET2 = 2,
	MDA300_PACKET3 = 3,
	MDA300_PACKET4 = 4,
	MDA300_ERR_PACKET = 0xf8	
    };
    
    

/******************************************************
    enum {
	SENSOR_ID = 0,
	PACKET_ID, 
	NODE_ID,
	RESERVED,
	DATA_START
    } XPacketDataEnum;
******************************************************/	
    /* Messages Buffers */	
    bool       sleeping;	       // application command state

    bool sending_packet;
    uint16_t    seqno;
    XDataMsg  *tmppack;

    TOS_Msg packet;
    TOS_Msg msg_send_buffer;    
    TOS_MsgPtr msg_ptr;
    HealthMsg *h_msg;
    


    uint16_t msg_status, pkt_full, sourcedata;
    char runflag;

    int8_t record[25];

  static void initialize() 
    {
      atomic 
      {
    	  sleeping = FALSE;
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
      }
    }
    
   static void start() 
    {
    	    if(runflag==0)
    	    {
	    call SamplerControl.start();
    	    atomic runflag=1;
            
            
	    //channel parameteres are irrelevent
            
	    record[16] = call Sample.getSample(0, BATTERY,MISC_SAMPLING_TIME,SAMPLER_DEFAULT);

            
	    //start sampling  channels. Channels 7-10 with averaging since they are more percise.channels 3-6 make active excitation    
	    record[0] = call Sample.getSample(0,ANALOG,ANALOG_SAMPLING_TIME,SAMPLER_DEFAULT | EXCITATION_33 | DELAY_BEFORE_MEASUREMENT);

	    record[1] = call Sample.getSample(1,ANALOG,ANALOG_SAMPLING_TIME,SAMPLER_DEFAULT  | EXCITATION_25 | DELAY_BEFORE_MEASUREMENT);
            
	    record[2] = call Sample.getSample(2,ANALOG,ANALOG_SAMPLING_TIME,SAMPLER_DEFAULT  | EXCITATION_50 | DELAY_BEFORE_MEASUREMENT);
            
	    record[3] = call Sample.getSample(3,ANALOG,ANALOG_SAMPLING_TIME,SAMPLER_DEFAULT );
            
	    //record[4] = call Sample.getSample(4,ANALOG,ANALOG_SAMPLING_TIME,SAMPLER_DEFAULT);
            
	    //record[5] = call Sample.getSample(5,ANALOG,ANALOG_SAMPLING_TIME,SAMPLER_DEFAULT);
            
	    //record[6] = call Sample.getSample(6,ANALOG,ANALOG_SAMPLING_TIME,SAMPLER_DEFAULT);
            
	    //record[7] = call Sample.getSample(7,ANALOG,ANALOG_SAMPLING_TIME,AVERAGE_FOUR | EXCITATION_25);
            
	    //record[8] = call Sample.getSample(8,ANALOG,ANALOG_SAMPLING_TIME,AVERAGE_FOUR | EXCITATION_25);
            
	    //record[9] = call Sample.getSample(9,ANALOG,ANALOG_SAMPLING_TIME,AVERAGE_FOUR | EXCITATION_25);
            
	    //record[10] = call Sample.getSample(10,ANALOG,ANALOG_SAMPLING_TIME,AVERAGE_FOUR | EXCITATION_25);
         
	    //record[11] = call Sample.getSample(11,ANALOG,ANALOG_SAMPLING_TIME,SAMPLER_DEFAULT);
            
	    //record[12] = call Sample.getSample(12,ANALOG,ANALOG_SAMPLING_TIME,SAMPLER_DEFAULT);
            
	    //record[13] = call Sample.getSample(13,ANALOG,ANALOG_SAMPLING_TIME,SAMPLER_DEFAULT | EXCITATION_50 | EXCITATION_ALWAYS_ON);                                
                        
            
	    //digital chennels as accumulative counter                
            
	    record[17] = call Sample.getSample(0,DIGITAL,DIGITAL_SAMPLING_TIME,DIG_LOGIC | EVENT);
            
	    record[18] = call Sample.getSample(1,DIGITAL,DIGITAL_SAMPLING_TIME,DIG_LOGIC | EVENT);
            
	    record[19] = call Sample.getSample(2,DIGITAL,DIGITAL_SAMPLING_TIME,DIG_LOGIC | EVENT);
            
	    record[20] = call Sample.getSample(3,DIGITAL,DIGITAL_SAMPLING_TIME,DIG_LOGIC | EVENT);
            
	    //record[21] = call Sample.getSample(4,DIGITAL,DIGITAL_SAMPLING_TIME,RISING_EDGE);
            
	    //record[22] = call Sample.getSample(5,DIGITAL,DIGITAL_SAMPLING_TIME,RISING_EDGE | EEPROM_TOTALIZER);                                
            
	    //counter channels for frequency measurement, will reset to zero.
            
	    //record[23] = call Sample.getSample(0, COUNTER,MISC_SAMPLING_TIME,RESET_ZERO_AFTER_READ | RISING_EDGE);
	    call Leds.greenOn();          
	    }
	    else
	    {
	    call TO_Timer.start(TIMER_ONE_SHOT,timer_rate);    
	    }  
	    call Sample.sampleNow(); 
	    
	return;
    
    }

/****************************************************************************
 * Initialize the component. Initialize Leds
 *
 ****************************************************************************/
    command result_t StdControl.init() {
        
	call Leds.init();
        
	atomic {
	    msg_ptr = &msg_send_buffer;
	    //sending_packet = FALSE;
    	msg_status = 0;
    	runflag=0;
    	sourcedata=0;
	}
	pkt_full = PACKET_FULL;

    	MAKE_BAT_MONITOR_OUTPUT();  // enable voltage ref power pin as output
    	MAKE_ADC_INPUT();           // enable ADC7 as input
	TOSH_CLR_PW7_PIN();
      
// usart1 is also connected to external serial flash
// set usart1 lines to correct state
    	TOSH_MAKE_FLASH_OUT_OUTPUT();             //tx output
    	TOSH_MAKE_FLASH_CLK_OUTPUT();             //usart clk

    	call SamplerControl.init();
    	initialize();
    	return SUCCESS;
            
    }


 
/****************************************************************************
 * Start the component. Start the clock. Setup timer and sampling
 *
 ****************************************************************************/
    command result_t StdControl.start() {
     
     h_msg = call HealthMsgGet();
     h_msg->rsvd_app_type = SENSOR_BOARD_ID;
     call health_packet(TRUE,TOS_HEALTH_UPDATE);
     call Timer.start(TIMER_REPEAT, timer_rate);
     return SUCCESS;
    
    }
    
/****************************************************************************
 * Stop the component.
 *
 ****************************************************************************/
 
    command result_t StdControl.stop() {
        
        int i;
 	for(i=0;i<25;i++)
 	{
 		call Sample.stop(i);
	}    
#ifdef USE_LOW_POWER
 	call SamplerControl.stop();
#endif    
	atomic runflag=0;
	atomic sourcedata=0;
    
 	return SUCCESS;
    
    }




/****************************************************************************
 * Task to transmit radio message
 * NOTE that data payload was already copied from the corresponding UART packet
 ****************************************************************************/
    task void send_radio_msg() 
	{
	    uint8_t i;
        uint16_t  len;
	    XDataMsg *data;
	    if(sending_packet)
          return;
        atomic sending_packet=TRUE;
	// Fill the given data buffer.	
    	data = (XDataMsg*)call Send.getBuffer(msg_ptr, &len);
        tmppack=(XDataMsg *)packet.data;  
    	for (i = 0; i <= sizeof(XDataMsg)-1; i++) 
    	    ((uint8_t*)data)[i] = ((uint8_t*)tmppack)[i];

        data->xmeshHeader.packet_id = 6;
    	data->xmeshHeader.board_id  = SENSOR_BOARD_ID;
    	//data->xmeshHeader.node_id   = TOS_LOCAL_ADDRESS;

    	data->xmeshHeader.parent    = call RouteControl.getParent();
    	data->xmeshHeader.packet_id = data->xmeshHeader.packet_id | 0x80;



    #if FEATURE_UART_SEND
    	if (TOS_LOCAL_ADDRESS != 0) {
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
    		call Leds.yellowOn();
    	    if (call Send.send(BASE_STATION_ADDRESS,MODE_UPSTREAM,msg_ptr, sizeof(XDataMsg)) != SUCCESS) {
    		atomic sending_packet = FALSE;
    		call Leds.yellowOn();
    		call Leds.greenOff();
    	    }
    	}

        

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
      //      if (msg->addr == TOS_UART_ADDR) {
      atomic msg_ptr = msg;
      msg_ptr->addr = TOS_BCAST_ADDR;
      
      if (call Send.send(BASE_STATION_ADDRESS,MODE_UPSTREAM,msg_ptr, sizeof(XDataMsg)) != SUCCESS) {
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
  * @version   2004/5/27      mturon       Initial revision
  */
  event result_t Send.sendDone(TOS_MsgPtr msg, result_t success) 
  {
      atomic {
	  msg_ptr = msg;
	  sending_packet = FALSE;
      }
      call Leds.yellowOff();
      
#if FEATURE_UART_SEND
      if (TOS_LOCAL_ADDRESS != 0) // never turn on power mgr for base
	  call PowerMgrEnable();
#endif
      
      return SUCCESS;
  }
 
/**
 * Handle a single dataReady event for all MDA300 data types. 
 * 
 * @author    Leah Fera, Martin Turon
 *
 * @version   2004/3/17       leahfera    Intial revision
 * @n         2004/4/1        mturon      Improved state machine
 */
    event result_t 
	Sample.dataReady(uint8_t channel,uint8_t channelType,uint16_t data)
	{          

	    switch (channelType) {
		case ANALOG:              
		    switch (channel) {		  
			// MSG 1 : first part of analog channels (0-6)
			case 0:
                tmppack=(XDataMsg *)packet.data;
			    tmppack->xData.datap6.adc0 =data ;
			    sourcedata+=data;
			    atomic {msg_status|=0x01;}
			    break;

			case 1:   
                tmppack=(XDataMsg *)packet.data;
			    tmppack->xData.datap6.adc1 =data ;
			    sourcedata+=data;
			    atomic {msg_status|=0x02;}
			    break;
             
			case 2:
                tmppack=(XDataMsg *)packet.data;
			    tmppack->xData.datap6.adc2 =data ;
			    sourcedata+=data;
			    atomic {msg_status|=0x04;}
			    break;
              
			case 3:
                tmppack=(XDataMsg *)packet.data;

			    tmppack->xData.datap6.adc3 =data ;
			    sourcedata+=data;
			    atomic {msg_status|=0x08;}
			    break;
              
              
			default:
			    break;
		    }  // case ANALOG (channel) 
		    break;
          
		case DIGITAL:
		    switch (channel) {             
			case 0:
                atomic {
                	   tmppack=(XDataMsg *)packet.data;
			    tmppack->xData.datap6.dig0=data;
			    msg_status|=0x10;}
			    break;
              
			case 1:
                atomic {
                	    tmppack=(XDataMsg *)packet.data;
			    tmppack->xData.datap6.dig1=data;
			    msg_status|=0x20;}
			    break;
            
			case 2:
                atomic {
                	    tmppack=(XDataMsg *)packet.data;
			    tmppack->xData.datap6.dig2=data;
			    msg_status|=0x40;}
			    break;
              
			case 3:
                atomic {
                	    tmppack=(XDataMsg *)packet.data;
			    tmppack->xData.datap6.dig3=data;
			    msg_status|=0x80;}
			    break;
              
			default:
			    break;
		    }  // case DIGITAL (channel)
		    break;

		case BATTERY:            
            atomic {
            		tmppack=(XDataMsg *)packet.data;
			tmppack->xData.datap6.vref =data ;
		    msg_status|=0x100;}
		    break;

		default:
		    break;

	    }  // switch (channelType) 
        if (sending_packet)
             return SUCCESS; 
            
		if (msg_status == pkt_full) {
		 msg_status = 0;
      		 call StdControl.stop();
		 post send_radio_msg();
		} 
          
	    return SUCCESS;      
	}
  
/****************************************************************************
 * Timer Fired - 
 *
 ****************************************************************************/
    event result_t Timer.fired() {
      if (sending_packet && msg_status!=0) 
	  return SUCCESS;             //don't overrun buffers
	  start();

	return SUCCESS;
  
    }


/****************************************************************************
 * Timer Out Fired - 
 *
 ****************************************************************************/
    event result_t TO_Timer.fired() {
	if((msg_status & 0x100)==0x100 && sourcedata==0)
	{
	post send_radio_msg();
	msg_status=0;
	}
	return SUCCESS;  
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
  event result_t XCommand.received(XCommandOp *opcode) {

      switch (opcode->cmd) {
	  case XCOMMAND_SET_RATE:
	      // Change the data collection rate.
	      timer_rate = opcode->param.newrate;
	      call Timer.stop();
	      call Timer.start(TIMER_REPEAT, timer_rate);
	      break;
	      
	      
	  case XCOMMAND_SLEEP:
	      // Stop collecting data, and go to sleep.
	      sleeping = TRUE;
	      call StdControl.stop();
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

/*#ifdef XMESHSYNC  
  task void SendPing() {
    XDataMsg *pReading;
    uint16_t Len;

      
    if ((pReading = (XDataMsg *)call Send.getBuffer(msg_ptr,&Len))) {
      pReading->xmeshHeader.parent = call RouteControl.getParent();
      if ((call Send.send(msg_ptr,sizeof(XDataMsg))) != SUCCESS)
	atomic sending_packet = FALSE;
    }

  }


    event TOS_MsgPtr DownTree.receive(TOS_MsgPtr pMsg, void* payload, uint16_t payloadLen) {

        if (!sending_packet) {
	   call Leds.yellowToggle();
	   atomic sending_packet = TRUE;
           post SendPing();  //  pMsg->XXX);
        }
	return pMsg;
  }
#endif */   

   event result_t XEEControl.restoreDone(result_t result)
   {
   		if(result) {
   				call Timer.stop();
	      		call Timer.start(TIMER_REPEAT, timer_rate);
   		}
 	 return SUCCESS;
   }  

}
