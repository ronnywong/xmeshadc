/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: MTS450CTSM.nc,v 1.1.4.1 2007/04/27 05:52:58 njain Exp $
 */

//includes sensorboard;
//#define SODBGON 1
//includes SOdebug;
 
module MTS450CTSM
{
  provides {
    interface StdControl;
    interface MTS450CTS[uint8_t id];
  }
  uses {
    interface I2C;
    interface StdControl as I2CStdControl;
  }
}

implementation
{
   enum{
	    IDLE,
	    WSEQ_START=1,
	    WSEQ_DEVICE_WRITE_ADDR,
	    WSEQ_DEVICE_MODE,
	    WSEQ_SECOND_START,
	    WSEQ_DEVICE_READ_ADDR,
	    RSEQ_DATA_FIRST_BYTE_ACK,
	    RSEQ_DATA_SECOND_BYTE_NCK,
	    WSEQ_STOP
	    };
  uint8_t addr; 
  uint8_t state;
  char dataread[2];
  
  task void readSeq()
  {
	  if(state==WSEQ_START)
	  {
		  call I2C.sendStart();
	  }
	  if(state==WSEQ_DEVICE_WRITE_ADDR)
	  {
		  call I2C.write((addr<<1)&0xfe);
	  }
	  if(state==WSEQ_DEVICE_MODE)
	  {
		  call I2C.write(0x8A);
	  }
	  if(state==WSEQ_SECOND_START)
	  {
		  call I2C.sendStart();
	  }
	  if(state==WSEQ_DEVICE_READ_ADDR)
	  {
		  call I2C.write((addr<<1)|0x01);
	  }
	  if(state==RSEQ_DATA_FIRST_BYTE_ACK)
	  {
		  call I2C.read(1);
	  }	
	  if(state==RSEQ_DATA_SECOND_BYTE_NCK)
	  {
		  call I2C.read(0);
	  }	
	  if(state==WSEQ_STOP)
	  {
		  call I2C.sendEnd();
	  }	   
	  return;
  }
  command result_t StdControl.init()
  {
	  call I2CStdControl.init();
	  return SUCCESS;
  }
  command result_t StdControl.start() 
  {
	  state=IDLE;
	  call I2CStdControl.stop();
	  CTS_POWER_ON(); //power the ADS 7828 on
	  return SUCCESS;
  }

  /**
   * stop the component
   **/
  command result_t StdControl.stop() 
  {
	  call I2CStdControl.stop(); //power the ADS 7828 off
	  CTS_POWER_OFF();
	  return SUCCESS;
  }
  command result_t MTS450CTS.getData[uint8_t id]() 
  {
	  state=WSEQ_START;
	  addr=id;
	  post readSeq();
	  return SUCCESS;
  }
  event result_t I2C.sendStartDone() 
  {
	  if(state==WSEQ_START)
	  {
		  state=WSEQ_DEVICE_WRITE_ADDR;
		  post readSeq();
		  return SUCCESS;
	  }
	  if(state==WSEQ_SECOND_START)
	  {
		  state=WSEQ_DEVICE_READ_ADDR;
		  post readSeq();
		  return SUCCESS;
	  }
	  return FAIL;
  }
  event result_t I2C.sendEndDone() 
  {
	  if(state==WSEQ_STOP)
	  {
		  state=IDLE;
		  signal MTS450CTS.dataReady[addr] (dataread);
		  return SUCCESS;
	  }
	  return FAIL;
  }
  event result_t I2C.writeDone(bool result) 
  {
	  if(result)
	  {
		  if(state==WSEQ_DEVICE_WRITE_ADDR)
		  {
			  state=WSEQ_DEVICE_MODE;
			  post readSeq();
			  return SUCCESS;
		  }
		  if(state==WSEQ_DEVICE_MODE)
		  {
			  state=WSEQ_SECOND_START;
			  post readSeq();
			  return SUCCESS;
		  }
		  if(state==WSEQ_DEVICE_READ_ADDR)
		  {
			  state=RSEQ_DATA_FIRST_BYTE_ACK;
			  post readSeq();
			  return SUCCESS;
		  }
      }
      else
      {
	      state=WSEQ_START;
	      post readSeq();
	      return SUCCESS;
	  }
	  return FAIL;
  }
  event result_t I2C.readDone(char in_data) 
  {
	  if(state==RSEQ_DATA_FIRST_BYTE_ACK)
	  {
		  state=RSEQ_DATA_SECOND_BYTE_NCK;
		  dataread[0]=in_data;
		  post readSeq();
		  return SUCCESS;
	  }
	  if(state==RSEQ_DATA_SECOND_BYTE_NCK)
	  {
		  state=WSEQ_STOP;
		  dataread[1]=in_data;
		  post readSeq();
		  return SUCCESS;
	  }
      return FAIL;
  }
  default event result_t MTS450CTS.dataReady[uint8_t id](char* data)
  {
	  return SUCCESS;
	  }
}



