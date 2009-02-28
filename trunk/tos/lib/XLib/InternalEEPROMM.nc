/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * Copyright (c) 2004 by Sensicast, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: InternalEEPROMM.nc,v 1.1.4.1 2007/04/25 23:42:07 njain Exp $
 */

//
// @Author: Michael Newman
//
//
#define InternalEEPROMedit 1

module InternalEEPROMM {
    provides interface StdControl;
    provides interface WriteData;
    provides interface ReadData;
}

implementation
{
    command result_t StdControl.init()
    {
	return SUCCESS;
    }

    command result_t StdControl.start()
    {
	return SUCCESS;
    }

    command result_t StdControl.stop()
    {
	return SUCCESS;
    }


    static uint8_t *pReadBuffer;
    static uint16_t readNumBytesRead;

    command result_t ReadData.read(uint32_t offset, uint8_t *buffer, uint32_t numBytesRead) {
	uint16_t i;
	pReadBuffer = buffer;
	readNumBytesRead = (uint16_t)numBytesRead;	// limited to 64K by address space
	for (i = 0;i < readNumBytesRead;i += 1) {
	    buffer[i] = eeprom_read_byte((uint8_t *)((uint16_t)offset + i));
	};
	signal ReadData.readDone(pReadBuffer,readNumBytesRead,SUCCESS);	
	return SUCCESS;
    }

    static uint8_t *pWriteBuffer;
    static uint16_t writeNumBytesWrite;

    command result_t WriteData.write(uint32_t offset, uint8_t *buffer, uint32_t numBytesWrite) {
	uint16_t i;
	pWriteBuffer = buffer;
	writeNumBytesWrite = (uint16_t)numBytesWrite;	// limited to 64K by address space
	for (i = 0;i < writeNumBytesWrite;i += 1) {
	    eeprom_write_byte((uint8_t *)((uint16_t)offset + i),buffer[i]);
	};
	signal WriteData.writeDone(pWriteBuffer,writeNumBytesWrite,SUCCESS);	
	return SUCCESS;
    }

    default event result_t WriteData.writeDone(uint8_t *data, uint32_t numBytesWrite, result_t success) {
	return SUCCESS;
    }

    default event result_t ReadData.readDone(uint8_t *buffer, uint32_t numBytesRead, result_t success) {
	return SUCCESS;
    }

}
