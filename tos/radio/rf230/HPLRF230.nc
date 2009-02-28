/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: HPLRF230.nc,v 1.1.2.2 2007/04/27 05:00:49 njain Exp $
 */

interface HPLRF230 {
	
	/**
	 *	write a specific rf230 register
	 */
	async command void writeReg(uint8_t addr, uint8_t value);
	
	/**
	 *	Read a specific rf230 register
	 */
	async command uint8_t readReg(uint8_t addr);
	
	/**
	 *  Read a specific value from a register
	 */
	async command void bitRead(uint8_t addr, uint8_t mask, uint8_t pos, uint8_t *data);
	
	/**
	 *  Write a specific value from a register
	 */
	async command void bitWrite(uint8_t addr, uint8_t mask, uint8_t pos, uint8_t value);
	
	/**
	 *	Write a 15.4 frame into the rtx-fifo
	 */
	async command void writeFrame(uint8_t len, uint8_t * buff);
	
	/**
	 *	Generate a CRC corresponding for the frame.  Insert the CRC bytes to 
	 *  the end of the frame.
	 */
	async command void addCRC(uint8_t * buff);
	
	/**
	 *	Read a 15.4 frame frome the rtx-fifo while doing a running crc.
	 *	If the crc fails then return length 0.
	 */
	async command uint8_t readFrameCRC(uint8_t * buff);
	
	/**
	 *	Read a 15.4 frame from the rtx-fifo
	 */
	async command uint8_t readFrame(uint8_t * buff);
	
	/**
	 *	Read some bytes from ram
	 */
	async command void readRam(uint8_t addr, uint8_t len, uint8_t * buff);
	
	/**
	 *	write some bytes into ram
	 */
	async command void writeRam(uint8_t addr, uint8_t len, uint8_t * buff);
			
	
}
