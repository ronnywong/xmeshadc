/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: RadioControlM.nc,v 1.1.2.2 2007/04/27 05:02:55 njain Exp $
 */
 
module RadioControlM {
	provides interface RadioControl;
	uses interface RF230Control;	
}

implementation {
	
// Frequency & Channel //

	/// Tune the radio frequency to an available preset.
	command result_t RadioControl.setRfChannel(uint8_t freqPreset) {
		return call RF230Control.TunePreset(freqPreset);
	}

	/// Tune the radio to a given frequency manually.
	command result_t RadioControl.setRfFrequency(uint16_t DesiredFreqInMHz) {
		return call RF230Control.TuneManual(DesiredFreqInMHz);
	}

	/// Get preset back.
	command uint8_t RadioControl.getRfChannel() {
		return call RF230Control.GetPreset();
	}

	/// Get frequency back.
	command uint16_t RadioControl.getRfFrequency() {
		return call RF230Control.GetManual();
	}

	/// Set the transmit RF power value.
	command result_t RadioControl.SetRFPower(uint8_t power) {
		return call RF230Control.SetRFPower(power);
	}

	/// Get the present RF power index.
	command uint8_t RadioControl.GetRFPower() {
		return call RF230Control.GetRFPower();
	}

// Manually set or read registers //

	/// read a register
	command uint8_t RadioControl.readReg(uint8_t reg) {
		return 0;
		
		//NOT IMPLEMENTED
	}

	/// set a register
	command result_t RadioControl.setReg(uint8_t reg) {
		return 0;
		
		//NOT IMPLEMENTED
	}
	
 }

