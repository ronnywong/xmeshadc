/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: HPLRF230M.nc,v 1.1.2.2 2007/04/27 05:01:14 njain Exp $
 */
 
module HPLRF230M {
	provides interface HPLRF230Init;
	provides interface HPLRF230;
}

implementation {
	
/* === Local functions ===================================================== */

#include "HPLRF230.h"

/* === HPLRF230 interface impelmentation =================================== */

	/**
	 *	initialize the spi port for communcating with rf230
	 *  initialize pin directions for GPIO pins
	 */
	async command void HPLRF230Init.init() {

		//Does writing to a frame while atomic problematic?  
		// Will it be possible to spin forever?
		//	- no we spin on a flag that is cleared before by writing the reg
		//	- the spi write will complete and set the flag
		// Atomic will just delay interrupts until later
		atomic {
			initSPIMaster();
			initRadioGPIO();
		}
	}

	/**
	 *	write a specific rf230 register
	 */
	async command void HPLRF230.writeReg(uint8_t addr, uint8_t value) {
		atomic bios_reg_write(addr, value);
	}
	
	/**
	 *	Read a specific rf230 register
	 */
	async command uint8_t HPLRF230.readReg(uint8_t addr) {
		uint8_t output;
		
		atomic output = bios_reg_read(addr);
		return output;
	}
	
	/**
	 *	Write a 15.4 frame into the rtx-fifo
	 */
	async command void HPLRF230.writeFrame(uint8_t len, uint8_t * buff) {
		atomic bios_frame_write(len, buff);
	}
	
	/**
	 *	Generate a CRC corresponding for the frame.  Insert the CRC bytes to 
	 *  the end of the frame.
	 */
	async command void HPLRF230.addCRC(uint8_t * buff) {
		atomic bios_gen_crc16(buff);
	}
	
	/**
	 *	Read a 15.4 frame frome the rtx-fifo while doing a running crc.
	 *	If the crc fails then return length 0.
	 */
	async command uint8_t HPLRF230.readFrameCRC(uint8_t * buff) {
		uint8_t length;
		
		atomic length = bios_frame_crc_read(buff);
		return length;
	}
	
	/**
	 *	Read a 15.4 frame from the rtx-fifo
	 */
	async command uint8_t HPLRF230.readFrame(uint8_t * buff) {
		uint8_t length;
		
		atomic {
			//read the length byte
			length = bios_frame_length_read();
			
			if (length > TOS_DATA_LENGTH) {
				//reject if too long
				bios_bytes_clear(length);
				length=0;
			} else {
				bios_bytes_read(length, buff);
			}
		}
		
		return length;
	}
	
	/**
	 *  Read a specific value from a register
	 */
	async command void HPLRF230.bitRead(uint8_t addr, uint8_t mask, uint8_t pos, uint8_t *data) {
		atomic bios_bit_read(addr, mask, pos, data);
	}
	
	/**
	 *  Write a specific value from a register
	 */
	async command void HPLRF230.bitWrite(uint8_t addr, uint8_t mask, uint8_t pos, uint8_t value) {
		atomic bios_bit_write(addr, mask, pos, value);
	}
	
	
	/**
	 *	Read some bytes from ram
	 */
	async command void HPLRF230.readRam(uint8_t addr, uint8_t len, uint8_t * buff) {
		atomic bios_sram_read(addr, len, buff);
	}
	
	/**
	 *	write some bytes into ram
	 */
	async command void HPLRF230.writeRam(uint8_t addr, uint8_t len, uint8_t * buff) {
		atomic bios_sram_write(addr, len, buff);
	}
}
