/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: XSensorMDA325M.nc,v 1.3.4.1 2007/04/26 20:27:25 njain Exp $
 */

/** 
 * XSensor single-hop application for MDA325 sensorboard.
 *
 * @author Pi Peng
 */


// include sensorboard.h definitions from tos/mda300 directory
#include "appFeatures.h"
includes sensorboard;

module XSensorMDA325M
{
  
    provides interface StdControl;
  
    uses {
	interface Leds;

	//Sampler Communication
	interface StdControl as SamplerControl;
	interface Sample;
	interface MDA300EEPROM;
	interface StdControl as MDA300EEPROMControl;

//communication
	interface StdControl as CommControl;
	interface SendMsg as Send;
	interface ReceiveMsg as Receive;
    
	//Timer
	interface Timer;
    
	//support for plug and play
	command result_t PlugPlay();
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

#define PACKET1_FULL	0x7F
//#define PACKET1_FULL	0x01
#define PACKET2_FULL	0x1F
#define PACKET3_FULL	0xFF
#define PACKET4_FULL	0x03

#define MSG_LEN  29   // excludes TOS header, but includes xbow header
    
    enum {
	PENDING = 0,
	NO_MSG = 1
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
	XDataMsg *pack, *tmppack;

    TOS_Msg packet[5];
    TOS_Msg msg_send_buffer;    
    TOS_MsgPtr msg_ptr;
    


    uint8_t pkt_send_order[4];
    uint8_t next_packet, old_packet;
    uint8_t packet_ready;
    bool    sending_packet, bIsUart;
    uint8_t msg_status[5], pkt_full[5];
    uint8_t WData[10];
    char test;
    uint8_t EEPROMwf;
    int8_t record[30];
 
    void initialize()
    {
        uint8_t i;
	atomic {
	    msg_ptr = &msg_send_buffer;
	    pack=(XDataMsg *)msg_ptr->data;

	    pkt_send_order[0] = 1;
	    pkt_send_order[1] = 2;
	    pkt_send_order[2] = 3;
	    pkt_send_order[3] = 4;

	    packet_ready = 0;
	    next_packet = 4;
            old_packet=1;
	    sending_packet = FALSE;
	}
	for (i=1; i<=4; i++) 
	    msg_status[i] = 0;
	for(i=0;i<10;i++)
	{
	    WData[i]=i;
	}
	EEPROMwf=0;
	pkt_full[1] = PACKET1_FULL;
	pkt_full[2] = PACKET2_FULL;
	pkt_full[3] = PACKET3_FULL;
	pkt_full[4] = PACKET4_FULL;
	pack->xSensorHeader.board_id = SENSOR_BOARD_ID;
	pack->xSensorHeader.node_id = TOS_LOCAL_ADDRESS;
    }
    void start()
    {
	TOSH_SET_PW7_PIN();
    
	if(call PlugPlay())
	{
            
	    //channel parameteres are irrelevent
            
	    record[16] = call Sample.getSample(0, BATTERY,MISC_SAMPLING_TIME,SAMPLER_DEFAULT);
            
	    //start sampling  channels. Channels 7-10 with averaging since they are more percise.channels 3-6 make active excitation    
	    record[0] = call Sample.getSample(0,ANALOG,ANALOG_SAMPLING_TIME,SAMPLER_DEFAULT|EXCITATION_33 );
	    TOSH_uwait(10);
	    record[1] = call Sample.getSample(1,ANALOG,ANALOG_SAMPLING_TIME,SAMPLER_DEFAULT);
	    TOSH_uwait(10);
	    record[2] = call Sample.getSample(2,ANALOG,ANALOG_SAMPLING_TIME,SAMPLER_DEFAULT|EXCITATION_33);
	    TOSH_uwait(10);
	    record[3] = call Sample.getSample(3,ANALOG,ANALOG_SAMPLING_TIME,SAMPLER_DEFAULT);
	    TOSH_uwait(10);
	    record[4] = call Sample.getSample(4,ANALOG,ANALOG_SAMPLING_TIME,SAMPLER_DEFAULT);
	    TOSH_uwait(10);
	    record[5] = call Sample.getSample(5,ANALOG,ANALOG_SAMPLING_TIME,SAMPLER_DEFAULT|EXCITATION_50);
	    TOSH_uwait(10);
	    record[6] = call Sample.getSample(6,ANALOG,ANALOG_SAMPLING_TIME,AVERAGE_FOUR | EXCITATION_25);
	    TOSH_uwait(10);
	    record[7] = call Sample.getSample(7,ANALOG,ANALOG_SAMPLING_TIME,AVERAGE_FOUR | EXCITATION_33 );
	    TOSH_uwait(10);
	    record[8] = call Sample.getSample(8,ANALOG,ANALOG_SAMPLING_TIME,SAMPLER_DEFAULT | EXCITATION_33 | DELAY_BEFORE_MEASUREMENT);
	    TOSH_uwait(10);
	    record[9] = call Sample.getSample(9,ANALOG,ANALOG_SAMPLING_TIME,SAMPLER_DEFAULT| EXCITATION_33 );
	    TOSH_uwait(10);
	    record[10] = call Sample.getSample(10,ANALOG,ANALOG_SAMPLING_TIME,SAMPLER_DEFAULT | EXCITATION_25 );                                
	    TOSH_uwait(10);
	    record[11] = call Sample.getSample(11,ANALOG,ANALOG_SAMPLING_TIME,SAMPLER_DEFAULT | EXCITATION_25);                                
           
	    //digital chennels as accumulative counter                
            
	    record[17] = call Sample.getSample(0,DIGITAL,DIGITAL_SAMPLING_TIME,FALLING_EDGE);
            
	    record[18] = call Sample.getSample(1,DIGITAL,DIGITAL_SAMPLING_TIME,FALLING_EDGE);
            
	    record[19] = call Sample.getSample(2,DIGITAL,DIGITAL_SAMPLING_TIME,FALLING_EDGE);
            
	    record[20] = call Sample.getSample(3,DIGITAL,DIGITAL_SAMPLING_TIME,FALLING_EDGE);
            
	    record[21] = call Sample.getSample(4,DIGITAL,DIGITAL_SAMPLING_TIME,RISING_EDGE);
            
	    record[22] = call Sample.getSample(5,DIGITAL,DIGITAL_SAMPLING_TIME,RISING_EDGE );//| EEPROM_TOTALIZER);
	                                    
	    record[23] = call Sample.getSample(6,DIGITAL,DIGITAL_SAMPLING_TIME,RISING_EDGE);
            
	    record[24] = call Sample.getSample(7,DIGITAL,DIGITAL_SAMPLING_TIME,RISING_EDGE);                                
            
	    //counter channels for frequency measurement, will reset to zero.
            
	    record[25] = call Sample.getSample(0, COUNTER,MISC_SAMPLING_TIME,RESET_ZERO_AFTER_READ | RISING_EDGE);
	    call Leds.greenOn();          
	}
        
	else {
	    call Leds.redOn();
	}
        
    }
    
/****************************************************************************
 * Initialize the component. Initialize Leds
 *
 ****************************************************************************/
    command result_t StdControl.init() {
        
    call Leds.init();
    call SamplerControl.init();
    call CommControl.init();
    initialize();
    return SUCCESS;
            
	//return rcombine(call SamplerControl.init(), call CommControl.init());
    }


 
/****************************************************************************
 * Start the component. Start the clock. Setup timer and sampling
 *
 ****************************************************************************/
    command result_t StdControl.start() {

	call SamplerControl.start();
        
	call CommControl.start();
    call Timer.start(TIMER_REPEAT,2000);
        
	return SUCCESS;
    
    }
    
/****************************************************************************
 * Stop the component.
 *
 ****************************************************************************/
 
    command result_t StdControl.stop() {
        
 	call SamplerControl.stop();
 	call CommControl.stop();
 	TOSH_CLR_PW7_PIN();
    
 	return SUCCESS;
    
    }


/****************************************************************************
 * Task to uart as message
 *
 ****************************************************************************/
    task void send_uart_msg(){
	uint8_t i;
    if(sending_packet)
        return;
	atomic sending_packet = TRUE;
	old_packet = (next_packet%4)+1;
    call Leds.yellowToggle();
    tmppack=(XDataMsg *)packet[next_packet].data;  
	for (i = 4; i <= MSG_LEN-1; i++) 
	{
	    ((uint8_t*)pack)[i] = ((uint8_t*)tmppack)[i];
	}
    pack->xSensorHeader.packet_id = next_packet;
	call Send.send(TOS_UART_ADDR,sizeof(XDataMsg),msg_ptr);

    }

/****************************************************************************
 * Task to transmit radio message
 * NOTE that data payload was already copied from the corresponding UART packet
 ****************************************************************************/
    task void send_radio_msg() 
	{
        atomic sending_packet=TRUE;
        call Leds.yellowToggle();
        call Send.send(TOS_BCAST_ADDR,sizeof(XDataMsg),msg_ptr);

	}

/****************************************************************************
 * if Uart msg xmitted,Xmit same msg over radio
 * if Radio msg xmitted, issue a new round measuring
 ****************************************************************************/
  event result_t Send.sendDone(TOS_MsgPtr msg, result_t success) {
      if(bIsUart)
      {
        bIsUart=!bIsUart;
        post send_radio_msg();
        packet_ready &= ~(1 << (next_packet - 1));
      }
      else
      {
	sending_packet = FALSE;
        atomic msg_ptr = msg;
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


 
/**
 * Handle a single dataReady event for all MDA300 data types. 
 * 
 * @author    Leah Fera, Martin Turon
 *
 * @version   2004/3/17       leahfera    Intial revision
 * @n         2004/4/1        mturon      Improved state machine
 */
event result_t Sample.dataReady(uint8_t channel,uint8_t channelType,uint16_t data)
	{          
	    uint8_t i;

	    switch (channelType) {
		case ANALOG:        
		call Leds.redToggle();      
		    switch (channel) {		  
			// MSG 1 : first part of analog channels (0-6)
			case 0:
                atomic {tmppack=(XDataMsg *)packet[1].data;
			    tmppack->xData.datap1.analogCh0 =data ;
			    msg_status[1] |=0x01;}
			    break;

			case 1:   
                atomic {tmppack=(XDataMsg *)packet[1].data;
			    tmppack->xData.datap1.analogCh1 =data ;
			    msg_status[1] |=0x02;}
			    break;
             
			case 2:
                atomic {tmppack=(XDataMsg *)packet[1].data;
			    tmppack->xData.datap1.analogCh2 =data ;
			    msg_status[1] |=0x04;}
			    break;
              
			case 3:
                atomic {tmppack=(XDataMsg *)packet[1].data;
			    tmppack->xData.datap1.analogCh3 =data ;
			    msg_status[1] |=0x08;}
			    break;
              
			case 4:
                atomic {tmppack=(XDataMsg *)packet[1].data;
			    tmppack->xData.datap1.analogCh4 =data ;
			    msg_status[1] |=0x10;}
			    break;
              
			case 5:
                atomic {tmppack=(XDataMsg *)packet[1].data;
			    tmppack->xData.datap1.analogCh5 =data ;
			    msg_status[1] |=0x20;}
			    break;
              
			case 6:
                atomic {tmppack=(XDataMsg *)packet[1].data;
			    tmppack->xData.datap1.analogCh6 =data ;
			    msg_status[1]|=0x40;}
			    break;

			case 7:
                atomic {tmppack=(XDataMsg *)packet[2].data;
			    tmppack->xData.datap2.analogCh7 =data ;
			    msg_status[2]|=0x01;}
			    break;

            		case 8:
                atomic {tmppack=(XDataMsg *)packet[2].data;
			    tmppack->xData.datap2.analogCh8 =data ;
			    msg_status[2]|=0x02;}
			    break;
              
			case 9:
                atomic {tmppack=(XDataMsg *)packet[2].data;
			    tmppack->xData.datap2.analogCh9 =data ;
			    msg_status[2]|=0x04;}
			    break;
              
			case 10:
                atomic {tmppack=(XDataMsg *)packet[2].data;
			    tmppack->xData.datap2.analogCh10 =data ;
			    msg_status[2]|=0x08;}
			    break;
              
			case 11:
                atomic {tmppack=(XDataMsg *)packet[2].data;
			    tmppack->xData.datap2.analogCh11 =data ;
			    msg_status[2]|=0x10;}
			    break;
             
              
              
			default:
			    break;
		    }  // case ANALOG (channel) 
		    break;
          
		case DIGITAL:
		    switch (channel) {             
			case 0:
                atomic {tmppack=(XDataMsg *)packet[3].data;
			    tmppack->xData.datap3.digitalCh0=data;
			    msg_status[3]|=0x01;}
			    break;
              
			case 1:
                atomic {tmppack=(XDataMsg *)packet[3].data;
			    tmppack->xData.datap3.digitalCh1=data;
			    msg_status[3]|=0x02;}
			    break;
            
			case 2:
                atomic {tmppack=(XDataMsg *)packet[3].data;
			    tmppack->xData.datap3.digitalCh2=data;
			    msg_status[3]|=0x04;}
			    break;
              
			case 3:
                atomic {tmppack=(XDataMsg *)packet[3].data;
			    tmppack->xData.datap3.digitalCh3=data;
			    msg_status[3]|=0x08;}
			    break;
              
			case 4:
                atomic {tmppack=(XDataMsg *)packet[3].data;
			    tmppack->xData.datap3.digitalCh4=data;
			    msg_status[3]|=0x10;}
			    break;
              
			case 5:
                atomic {tmppack=(XDataMsg *)packet[3].data;
			    tmppack->xData.datap3.digitalCh5=data;
			    msg_status[3]|=0x20;}
			    break;
			case 6:
                atomic {tmppack=(XDataMsg *)packet[3].data;
			    tmppack->xData.datap3.digitalCh6=data;
			    msg_status[3]|=0x40;}
			    break;
			case 7:
                atomic {tmppack=(XDataMsg *)packet[3].data;
			    tmppack->xData.datap3.digitalCh7=data;
			    msg_status[3]|=0x80;}
			    break;
              
			default:
			    break;
		    }  // case DIGITAL (channel)
		    break;

		case BATTERY:            
            atomic {tmppack=(XDataMsg *)packet[4].data;
		    tmppack->xData.datap4.batt=data ;            
		    msg_status[4]|=0x01;}
		    break;
          

		case COUNTER:
            atomic {tmppack=(XDataMsg *)packet[4].data;
		    tmppack->xData.datap4.counter=data ;            
		    msg_status[4]|=0x02;}
		    break;  

		default:
		    break;

	    }  // switch (channelType) 

		for (i=1; i<=4; i++) {
		    if (sending_packet)
			continue; 
            
		    if(i!=old_packet)//(next_packet%4)+1;
		    {
		    	call Leds.redToggle();
		    	continue;
		    }
		    
		    if (msg_status[i] >= pkt_full[i]) 
		    {
		        atomic{
			next_packet=i;
			msg_status[i] = 0;
		    	post send_uart_msg();
			}
		    } 
		}
          
	    return SUCCESS;      
	}
  
/****************************************************************************
 * Timer Fired - 
 *
 ****************************************************************************/
    event result_t Timer.fired() {
    	bIsUart=TRUE;  
    	if(sending_packet)
        	return SUCCESS;
        start();
        call Leds.greenToggle();
 	if (test != 0)  {
	    test=0;
	    if(EEPROMwf==0)
	    {
	    	call MDA300EEPROM.writePacket(0,10,(char*)(WData),0x01);
	    }
 	}
	else  {
	    test=1;
	      if(EEPROMwf==1)
		{
		    	call MDA300EEPROM.readPacket(0,10,0x03);
		}
 	}

	return SUCCESS;
  
    }
    
    event result_t MDA300EEPROM.writePacketDone(bool result) {
        if(result) 
        {
            EEPROMwf=1;
            return SUCCESS;
        }
        return FAIL;
    }
    
    event result_t MDA300EEPROM.readPacketDone(char length, char* data) {
        int i;
        if(length!=10)
        	return FAIL;
        if(EEPROMwf>1)
             return SUCCESS;
        EEPROMwf=EEPROMwf+1;
    	if(sending_packet)
        	return SUCCESS;
	atomic sending_packet = TRUE;
        for(i=0;i<10;i++)
        {
                atomic {((uint8_t*)pack)[i+4]=data[i];}
        }
    	pack->xSensorHeader.packet_id = 7;
	call Send.send(TOS_UART_ADDR,sizeof(XDataMsg),msg_ptr);
	return SUCCESS;
    }

}
