/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: RadioControl.nc,v 1.1.2.2 2007/04/27 05:02:47 njain Exp $
 */

 /**
 * RadioControl.nc - Platform independent Radio control interface
 *
 *	Provides a subset of radio control interfaces that is common to 
 *  most platforms
 *
 * @author Xin Yang
 * @date Feburary 16 2006
 */
 
 interface RadioControl {

// Frequency & Channel //

	/// Tune the radio frequency to an available preset.
	command result_t setRfChannel(uint8_t freqPreset); 

	/// Tune the radio to a given frequency manually.
	command result_t setRfFrequency(uint16_t DesiredFreqInMHz);

	/// Get preset back.
	command uint8_t getRfChannel();

	/// Get frequency back.
	command uint16_t getRfFrequency();

	/// Set the transmit RF power value.
	command result_t SetRFPower(uint8_t power);	

	/// Get the present RF power index.
	command uint8_t GetRFPower();

// Manually set or read registers //

	/// read a register
	command uint8_t readReg(uint8_t reg);

	/// set a register
	command result_t setReg(uint8_t reg);
}
