/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: CS64EEPROMM.nc,v 1.1.4.1 2007/04/27 05:31:43 njain Exp $
 */

/*
 * driver for 24LCS64 EEPROM on mtp400ca
 *
 * PW4 control the power of 24LCS64 EEPROM
 * 
 * (1010A2A1A0) is address; 
 * (1010101) 
 * Authors: Hu Siquan <husq@xbow.com>
 *
 */

module CS64EEPROMM {
    provides interface StdControl;
    provides interface WriteData;
    provides interface ReadData;
    uses interface I2CPacket;
    uses interface StdControl as I2CControl;    
}

implementation
{
    enum { IDLE, ADDRESS_IN_READING, DATA_IN_READING, WRITING };

    char state;        // current state of the i2c request 
    static uint8_t *pReadBuffer;
    static uint16_t readNumBytesRead;  
    static uint8_t *pWriteBuffer;
    static uint16_t writeNumBytesWrite;   
    uint8_t writeBuffer[3]; 
    uint16_t writeIndex;
	uint16_t pAddress;    

    command result_t StdControl.init()
    {
      state = IDLE;
	  TOSH_MAKE_PW4_OUTPUT();       
      //**I2CPacket should get initializedd here.
      call I2CControl.init();
      return SUCCESS;    	
    }

    command result_t StdControl.start()
    {
  	  call I2CControl.start();
  	  TOSH_SET_PW4_PIN();
      return SUCCESS;    	
    }

    command result_t StdControl.stop()
    {
  	  TOSH_CLR_PW4_PIN();    	
  		call I2CControl.stop();  
  		  	
		return SUCCESS;
    }


    command result_t ReadData.read(uint32_t offset, uint8_t *buffer, uint32_t numBytesRead) {
	
		if(state!=IDLE) return FAIL; 
		else    state= ADDRESS_IN_READING;
		pReadBuffer = buffer;
		pAddress = (uint16_t)offset;
		readNumBytesRead = (uint16_t)numBytesRead;	// limited to 64K by address space
		TOSH_uwait(1000);
		if ( call I2CPacket.writePacket(2, (char*)(&pAddress), 0x6) == FAIL)
    	{
        	state = IDLE;
        	return FAIL;
    	}
		return SUCCESS;
	}


	event result_t I2CPacket.writePacketDone(bool result) {
		if (state == ADDRESS_IN_READING)
		{
            state = DATA_IN_READING;
			if ( call I2CPacket.readPacket(readNumBytesRead, 0x3) == FAIL)
    		{
        		state = IDLE;
        		return FAIL;
    		}             

    	}
    	if(state == WRITING){
	      TOSH_uwait(1000);
	      TOSH_uwait(1000);	      
    		pAddress ++;
    		writeIndex ++;
    		if(writeIndex >= writeNumBytesWrite) {
    			signal WriteData.writeDone(pWriteBuffer,writeNumBytesWrite,SUCCESS);	
    			state = IDLE;
    			return SUCCESS;
    		}
    		writeBuffer[0] = (uint8_t)((pAddress>>8)&0xff);
			writeBuffer[1] = (uint8_t)(pAddress&0xff);
			writeBuffer[2] = pWriteBuffer[writeIndex];
			if ( call I2CPacket.writePacket(3, (char*)(&writeBuffer), 0x7) == FAIL)
    		{
        		state = IDLE;
        		return FAIL;
    		}    	
    	}
    	return SUCCESS;
 	}
 	
	event result_t I2CPacket.readPacketDone(char length, char* data) {
     if (state == DATA_IN_READING)
     {
         	memcpy(pReadBuffer,data,length);
			signal ReadData.readDone(pReadBuffer,length,SUCCESS);	// how about if length < readNumBytesRead?
			state= IDLE;
     }
     return SUCCESS;
 	} 	

    command result_t WriteData.write(uint32_t offset, uint8_t *buffer, uint32_t numBytesWrite) {

		if(state!=IDLE) return FAIL; 
		else    state= WRITING;	
		pWriteBuffer = buffer;
		writeIndex = 0;
		pAddress = (uint16_t)offset;	
		writeNumBytesWrite = (uint16_t)numBytesWrite;	// limited to 64K by address space
		writeBuffer[0] = (uint8_t)((pAddress>>8)&0xff);
		writeBuffer[1] = (uint8_t)(pAddress&0xff);
		writeBuffer[2] = pWriteBuffer[writeIndex];
		TOSH_uwait(1000);
		if ( call I2CPacket.writePacket(3, (char*)(&writeBuffer), 0x7) == FAIL)
    	{
        	state = IDLE;
        	return FAIL;
    	}	
		return SUCCESS;
    }

    default event result_t WriteData.writeDone(uint8_t *data, uint32_t numBytesWrite, result_t success) {
		return SUCCESS;
    }

    default event result_t ReadData.readDone(uint8_t *buffer, uint32_t numBytesRead, result_t success) {
		return SUCCESS;
    }

}
