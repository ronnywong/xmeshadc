/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: MTS420EEPROMM.nc,v 1.1.2.2 2007/04/27 05:50:24 njain Exp $
 */

/*
 * Authors:		pipeng
 * Date:		2005/9/9
 *
 */


 //using for debugging using serial port 

 
includes sensorboard;
//#define SODBGON 1
//includes SOdebug;
 
module MTS420EEPROMM
{
  provides {
    interface StdControl;
    interface MTS420EEPROM[uint8_t id];
  }
  uses {
    interface I2C;
    interface StdControl as I2CStdControl;
    interface StdControl as SwitchControl;
    interface Switch;
  }
}

implementation
{
  bool ack;
  uint8_t loop;
  uint16_t  index;
  uint8_t  state;
  uint8_t  device_addr;
  uint16_t eeprom_addr;
  char *   datap;
  uint16_t data_length;
  char     buffer[32];
  
//  uint8_t test;
  
  /* state of the i2c request  */
  enum{
	    WRITE_START=1,
	    WRITE_DEVICE_ADDR,
	    WRITE_ADDR_HIGH,
	    WRITE_ADDR_LOW,
	    WRITE_DATA,
	    WRITE_END,
	    	    
	    READ_START=0x10,
	    READ_DEVICE_ADDR,
	    READ_ADDR_HIGH,
	    READ_ADDR_LOW,
	    READ_SECOND_START,
	    READ_SECOND_DEVICE_ADDR,
	    READ_DATA,
	    READ_END
	   };
  
  task void writeTask()
  {
	  if(state==WRITE_START)
	  {
		  call I2C.sendStart();
	  }
	  if(state==WRITE_DEVICE_ADDR)
	  {
		  call I2C.write((device_addr<<1)&0xfe);
	  }
	  if(state==WRITE_ADDR_HIGH)
	  {
		  call I2C.write((eeprom_addr>>8)&0x1f);
	  }
	  if(state==WRITE_ADDR_LOW)
	  {
		  call I2C.write(eeprom_addr&0xff);
	  }
	  if(state==WRITE_DATA)
	  {
		  call I2C.write(*(datap+index));
	  }
	  if(state==WRITE_END)
	  {
		  call I2C.sendEnd();
	  }
	  return;
  } 
  task void readTask()
  {
	  if(state==READ_START)
	  {
		  call I2C.sendStart();
	  }
	  if(state==READ_DEVICE_ADDR)
	  {
		  call I2C.write((device_addr<<1)&0xfe);
	  }
	  if(state==READ_ADDR_HIGH)
	  {
		  call I2C.write((eeprom_addr>>8)&0x1f);
	  }
	  if(state==READ_ADDR_LOW)
	  {
		  call I2C.write(eeprom_addr&0xff);
	  }
	  if(state==READ_SECOND_START)
	  {
		  call I2C.sendStart();
	  }
	  if(state==READ_SECOND_DEVICE_ADDR)
	  {
		  call I2C.write((device_addr<<1)|0x01);
	  }
	  if(state==READ_DATA)
	  {
		  call I2C.read(ack);
	  }
	  if(state==READ_END)
	  {
		  call I2C.sendEnd();
	  }
	  return;
  }       
  command result_t StdControl.init() {
    call I2CStdControl.init();
    call SwitchControl.init();
//    test = 0;
    return SUCCESS;
  }

  
  command result_t StdControl.start() {
    call I2CStdControl.start();
    call SwitchControl.start();
	TOSH_uwait(1000);
	call Switch.set(MICAWB_EEPROM_POWER,1);
    return SUCCESS;
  }
  
  command result_t StdControl.stop() {
    call I2CStdControl.stop();
	//power eeprom off
    call Switch.set(MICAWB_EEPROM_POWER,0);
    TOSH_uwait(1000);
    return SUCCESS;
  }
  
  
  event result_t Switch.setDone(bool local_result) 
  {
  	return SUCCESS;
  }

 event result_t Switch.getDone(char value) {
    return SUCCESS;
  }

 event result_t Switch.setAllDone(bool local_result) {
    return SUCCESS;
  }
    
  
  command result_t MTS420EEPROM.writePacket[uint8_t id](uint16_t startaddr, uint16_t in_length, char* in_data, char in_flags) 
  {
	  //SODbg(SODBGON,"write start \n");
	  state=WRITE_START;
	  device_addr=id;
	  eeprom_addr=startaddr;
	  datap=in_data;
	  if(in_length<=32)
	     data_length=in_length;
	  else
	     data_length=in_length;//0;
	  
	  loop = 0;
	  post writeTask();
	  return SUCCESS;
	  
  }
  command result_t MTS420EEPROM.readPacket[uint8_t id](uint16_t startaddr, char in_length, char in_flags)
  {
	  state=READ_START;
	  device_addr=id;
	  eeprom_addr=startaddr;
	  if(in_length<=32)
	     data_length=in_length;
	  else
	     data_length=0;
	     
	  loop = 0;
	  post readTask();
	  return SUCCESS;
  }
  event result_t I2C.sendStartDone() 
  {
	  if(state==WRITE_START)
	  {
		  //SODbg(SODBGON,"write start sent \n");
		  if (loop==0)
		  index=0;
		  state=WRITE_DEVICE_ADDR;
		  post writeTask();
		  return SUCCESS;
	  }
	  if(state==READ_START)
	  {
		  //SODbg(SODBGON,"read start sent \n");
		  if (loop==0)
		  index=0;
		  state=READ_DEVICE_ADDR;
		  post readTask();
		  return SUCCESS;
	  }
	  if(state==READ_SECOND_START)
	  {
		  //SODbg(SODBGON,"read second start sent \n");
		  state=READ_SECOND_DEVICE_ADDR;
		  post readTask();
		  return SUCCESS;
	  }	  
	  return FAIL;
  }
  event result_t I2C.sendEndDone()
  {
	  if(state==WRITE_END)
	  {
		  //SODbg(SODBGON,"write end sent \n");
		  state=WRITE_START;
		  
		  index=index+1;
		  if(index<data_length)
		  {
             state=WRITE_START;
             atomic eeprom_addr = eeprom_addr+1;
             loop=1;
		     post writeTask();
			 return SUCCESS;	  
		  }	  
		  else
	      
	      {
		  signal MTS420EEPROM.writePacketDone[device_addr](1);
		  return SUCCESS;
		  }
	  }
	  if(state==READ_END)
	  {
		  //SODbg(SODBGON,"read end sent \n");
		  state=READ_START;
		  
  		  index=index+1;
		  if(index<data_length)
		  {
 		      ack=0;
			  atomic state=READ_START;
			  atomic eeprom_addr = eeprom_addr+1;
			  loop =1;
			  post readTask();
			  return SUCCESS;	  
		  }
		  else
		  
		  {
		  signal MTS420EEPROM.readPacketDone[device_addr](index, buffer);
		  return SUCCESS;
		  }
	  }
	  return SUCCESS;
  }
  event result_t I2C.writeDone(bool result) 
  {
	  if(result)
	  {
		  if(state==WRITE_DEVICE_ADDR)	
		  {
			  //SODbg(SODBGON,"write device addr sent \n");
			  state=WRITE_ADDR_HIGH;
			  post writeTask();
			  return SUCCESS;
		  }	 
		  if(state==WRITE_ADDR_HIGH)	
		  {
			  //SODbg(SODBGON,"write eeprom addr high sent \n");
			  state=WRITE_ADDR_LOW;
			  post writeTask();
			  return SUCCESS;
		  }	 
		  if(state==WRITE_ADDR_LOW)
		  {
			  //SODbg(SODBGON,"write eeprom addr low sent \n");
			  state=WRITE_DATA;
			  post writeTask();			  
			  return SUCCESS;	  
		  } 
		  if(state==WRITE_DATA)
		  {
			  //SODbg(SODBGON,"write data sent \n");
		    loop = 0;
		    atomic state=WRITE_END;
		    post writeTask();
		    return SUCCESS;
			  
			  /*
			  index=index+1;
			  if(index<data_length)
			  {
				  state=WRITE_DATA;				  
				  post writeTask();
				  return SUCCESS;	  
			  }
			  else
			  {
				  state=WRITE_END;
				  post writeTask();
				  return SUCCESS;
			  }
			  */  
		  }
		  if(state==READ_DEVICE_ADDR)	
		  {
			  //SODbg(SODBGON,"read device addr sent \n");
			  state=READ_ADDR_HIGH;
			  post readTask();
			  return SUCCESS;
		  }	 	
		  if(state==READ_ADDR_HIGH)	
		  {
			  //SODbg(SODBGON,"read eeprom addr high sent \n");
			  state=READ_ADDR_LOW;
			  post readTask();
			  return SUCCESS;
		  }	 
		  if(state==READ_ADDR_LOW)	
		  {
			  //SODbg(SODBGON,"read eeprom addr low sent \n");
			  state=READ_SECOND_START;
			  post readTask();
			  return SUCCESS;
		  }	 
		  if(state==READ_SECOND_DEVICE_ADDR)	
		  {
			  //SODbg(SODBGON,"read second  device addr sent \n");
			  atomic state=READ_DATA;//READ_END;//
			  /*
			  if (data_length >1)
			  {
			  	ack=1;
			  }
			  else
			  {
			  	ack=0;
			  }
			  */
			  ack=0;
			  post readTask();
			  return SUCCESS;
		  }	
		    
	  }
	  else
	  {
		  if((state & 0xf0)>0)	
		  {
			  state=READ_START;
			  post readTask();
			  return SUCCESS;
		  }	 
		  else	
		  {
			  state=WRITE_START;
			  post writeTask();
			  return SUCCESS;
		  }	
		  return FAIL;
	  }
  }
  event result_t I2C.readDone(char in_data) 
  {
	  buffer[index]=in_data;
	  if(state==READ_DATA)	
	  {
		  //SODbg(SODBGON,"read data read \n");
		  loop = 0;
		  atomic state=READ_END;
		  post readTask();
		  return SUCCESS;
	  }
	  /*
	  if(state==READ_DATA)	
	  {
		  //SODbg(SODBGON,"read data read \n");
		  index=index+1;
		  if(index<data_length)
		  {
			  if((index+1)<data_length)
			  {
			  	ack=1;
			  }
			  else
			  {
			    ack=0;
			  }
			  atomic state=READ_DATA;
			  post readTask();
			  return SUCCESS;	  
		  }
		  else
		  {
			  atomic state=READ_END;
			  post readTask();
			  return SUCCESS;
		  }
	  }
	  */
	  return FAIL;	
  }
  
  
  default event result_t MTS420EEPROM.readPacketDone[uint8_t id](char length, char* data)
  {
	return SUCCESS;
	}
  default event result_t MTS420EEPROM.writePacketDone[uint8_t id](bool result)
  {
	return SUCCESS;
	}
}
