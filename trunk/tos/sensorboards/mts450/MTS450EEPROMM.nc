/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: MTS450EEPROMM.nc,v 1.1.4.1 2007/04/27 05:53:23 njain Exp $
 */


/*
 *
 * Authors:		Joe Polastre, Rob Szewczyk
 * Date last modified:  7/18/02
 *
 */

/**
 * Provides functionality for writing and reading packets on the I2C bus
 * @author Joe Polastre
 * @author Rob Szewczyk
 *
 *@modified by Xfshen , 2005/7/15 
 *@modified by Tang Jun-hua  2005/8/19
 *
 */

 //using for debugging using serial port 

 
includes sensorboard;
//#define SODBGON 1
//includes SOdebug;
 
module MTS450EEPROMM
{
  provides {
    interface StdControl;
    interface MTS450EEPROM[uint8_t id];
  }
  uses {
    interface I2C;
    interface StdControl as I2CStdControl;
  }
}

implementation
{
  bool ack;
  uint8_t  index;
  uint8_t  state;
  uint8_t  device_addr;
  uint16_t eeprom_addr;
  char *   datap;
  char     data_length;
  char     buffer[32];
  /* state of the i2c request  */
  enum{
	    WSEQ_START=1,
	    WSEQ_DEVICE_ADDR,
	    WSEQ_ADDR_HIGH,
	    WSEQ_ADDR_LOW,
	    WSEQ_DATA,
	    WSEQ_END,
	    	    
	    RSEQ_START=0x10,
	    RSEQ_DEVICE_ADDR,
	    RSEQ_ADDR_HIGH,
	    RSEQ_ADDR_LOW,
	    RSEQ_SECOND_START,
	    RSEQ_SECOND_DEVICE_ADDR,
	    RSEQ_DATA,
	    RSEQ_END
	   };
  
  task void writeSeq()
  {
	  if(state==WSEQ_START)
	  {
		  call I2C.sendStart();
	  }
	  if(state==WSEQ_DEVICE_ADDR)
	  {
		  call I2C.write((device_addr<<1)&0xfe);
	  }
	  if(state==WSEQ_ADDR_HIGH)
	  {
		  call I2C.write((eeprom_addr>>8)&0x1f);
	  }
	  if(state==WSEQ_ADDR_LOW)
	  {
		  call I2C.write(eeprom_addr&0xff);
	  }
	  if(state==WSEQ_DATA)
	  {
		  call I2C.write(*(datap+index));
	  }
	  if(state==WSEQ_END)
	  {
		  call I2C.sendEnd();
	  }
	  return;
  } 
  task void readSeq()
  {
	  if(state==RSEQ_START)
	  {
		  call I2C.sendStart();
	  }
	  if(state==RSEQ_DEVICE_ADDR)
	  {
		  call I2C.write((device_addr<<1)&0xfe);
	  }
	  if(state==RSEQ_ADDR_HIGH)
	  {
		  call I2C.write((eeprom_addr>>8)&0x1f);
	  }
	  if(state==RSEQ_ADDR_LOW)
	  {
		  call I2C.write(eeprom_addr&0xff);
	  }
	  if(state==RSEQ_SECOND_START)
	  {
		  call I2C.sendStart();
	  }
	  if(state==RSEQ_SECOND_DEVICE_ADDR)
	  {
		  call I2C.write((device_addr<<1)|0x01);
	  }
	  if(state==RSEQ_DATA)
	  {
		  call I2C.read(ack);
	  }
	  if(state==RSEQ_END)
	  {
		  call I2C.sendEnd();
	  }
	  return;
  }       
  command result_t StdControl.init() {
    //SODbg(SODBGON,"eeprom init \n");
    //init_debug(); //debug 
    call I2CStdControl.init();
    EEPROM_POWER_ON();
    return SUCCESS;
  }

  
  command result_t StdControl.start() {
	//SODbg(SODBGON,"eeprom start \n");
    call I2CStdControl.start();
    EEPROM_POWER_ON();
    return SUCCESS;
  }
  
  command result_t StdControl.stop() {
    call I2CStdControl.stop();
	//power eeprom off
    EEPROM_POWER_OFF();
    return SUCCESS;
  }
  command result_t MTS450EEPROM.writePacket[uint8_t id](uint16_t startaddr, char in_length, char* in_data, char in_flags) 
  {
	  //SODbg(SODBGON,"write start \n");
	  state=WSEQ_START;
	  device_addr=id;
	  eeprom_addr=startaddr;
	  datap=in_data;
	  if(in_length<=32)
	     data_length=in_length;
	  else
	     data_length=0;
	  post writeSeq();
	  return SUCCESS;
	  
  }
  command result_t MTS450EEPROM.readPacket[uint8_t id](uint16_t startaddr, char in_length, char in_flags)
  {
	  state=RSEQ_START;
	  device_addr=id;
	  eeprom_addr=startaddr;
	  if(in_length<=32)
	     data_length=in_length;
	  else
	     data_length=0;
	  post readSeq();
	  return SUCCESS;
  }
  event result_t I2C.sendStartDone() 
  {
	  if(state==WSEQ_START)
	  {
		  //SODbg(SODBGON,"write start sent \n");
		  index=0;
		  state=WSEQ_DEVICE_ADDR;
		  post writeSeq();
		  return SUCCESS;
	  }
	  if(state==RSEQ_START)
	  {
		  //SODbg(SODBGON,"read start sent \n");
		  index=0;
		  state=RSEQ_DEVICE_ADDR;
		  post readSeq();
		  return SUCCESS;
	  }
	  if(state==RSEQ_SECOND_START)
	  {
		  //SODbg(SODBGON,"read second start sent \n");
		  state=RSEQ_SECOND_DEVICE_ADDR;
		  post readSeq();
		  return SUCCESS;
	  }	  
	  return FAIL;
  }
  event result_t I2C.sendEndDone()
  {
	  if(state==WSEQ_END)
	  {
		  //SODbg(SODBGON,"write end sent \n");
		  state=WSEQ_START;
		  signal MTS450EEPROM.writePacketDone[device_addr](1);
		  return SUCCESS;
	  }
	  if(state==RSEQ_END)
	  {
		  //SODbg(SODBGON,"read end sent \n");
		  state=RSEQ_START;
		  signal MTS450EEPROM.readPacketDone[device_addr](index, buffer);
		  return SUCCESS;
	  }
	  return SUCCESS;
  }
  event result_t I2C.writeDone(bool result) 
  {
	  if(result)
	  {
		  if(state==WSEQ_DEVICE_ADDR)	
		  {
			  //SODbg(SODBGON,"write device addr sent \n");
			  state=WSEQ_ADDR_HIGH;
			  post writeSeq();
			  return SUCCESS;
		  }	 
		  if(state==WSEQ_ADDR_HIGH)	
		  {
			  //SODbg(SODBGON,"write eeprom addr high sent \n");
			  state=WSEQ_ADDR_LOW;
			  post writeSeq();
			  return SUCCESS;
		  }	 
		  if(state==WSEQ_ADDR_LOW)
		  {
			  //SODbg(SODBGON,"write eeprom addr low sent \n");
			  state=WSEQ_DATA;
			  post writeSeq();
			  return SUCCESS;	  
		  } 
		  if(state==WSEQ_DATA)
		  {
			  //SODbg(SODBGON,"write data sent \n");
			  index=index+1;
			  if(index<data_length)
			  {
				  state=WSEQ_DATA;
				  post writeSeq();
				  return SUCCESS;	  
			  }
			  else
			  {
				  state=WSEQ_END;
				  post writeSeq();
				  return SUCCESS;
			  }
			    
		  }
		  if(state==RSEQ_DEVICE_ADDR)	
		  {
			  //SODbg(SODBGON,"read device addr sent \n");
			  state=RSEQ_ADDR_HIGH;
			  post readSeq();
			  return SUCCESS;
		  }	 	
		  if(state==RSEQ_ADDR_HIGH)	
		  {
			  //SODbg(SODBGON,"read eeprom addr high sent \n");
			  state=RSEQ_ADDR_LOW;
			  post readSeq();
			  return SUCCESS;
		  }	 
		  if(state==RSEQ_ADDR_LOW)	
		  {
			  //SODbg(SODBGON,"read eeprom addr low sent \n");
			  state=RSEQ_SECOND_START;
			  post readSeq();
			  return SUCCESS;
		  }	 
		  if(state==RSEQ_SECOND_DEVICE_ADDR)	
		  {
			  //SODbg(SODBGON,"read second  device addr sent \n");
			  state=RSEQ_DATA;
			  ack=1;
			  post readSeq();
			  return SUCCESS;
		  }	
		    
	  }
	  else
	  {
		  if((state & 0xf0)>0)	
		  {
			  state=RSEQ_START;
			  post readSeq();
			  return SUCCESS;
		  }	 
		  else	
		  {
			  state=WSEQ_START;
			  post writeSeq();
			  return SUCCESS;
		  }	
		  return FAIL;
	  }
  }
  event result_t I2C.readDone(char in_data) 
  {
	  buffer[index]=in_data;
	  if(state==RSEQ_DATA)	
	  {
		  //SODbg(SODBGON,"read data read \n");
		  index=index+1;
		  if(index<data_length)
		  {
			  if((index+1)<data_length)
			       ack=1;
			     else
			       ack=0;
			  state=RSEQ_DATA;
			  post readSeq();
			  return SUCCESS;	  
		  }
		  else
		  {
			  state=RSEQ_END;
			  post readSeq();
			  return SUCCESS;
		  }
	  }
	  return FAIL;	
  }
  
  
  default event result_t MTS450EEPROM.readPacketDone[uint8_t id](char length, char* data)
  {
	return SUCCESS;
  }
  default event result_t MTS450EEPROM.writePacketDone[uint8_t id](bool result)
  {
	return SUCCESS;
  }
}
