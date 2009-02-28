/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: CC2420Control.nc,v 1.1.4.1 2007/04/25 23:20:17 njain Exp $
 */
 
/*
 *
 * Authors:		Joe Polastre
 * Date last modified:  $Revision: 1.1.4.1 $
 *
 * Interface for CC2420 specific controls and signals
 */

/*
 *
 * $Log: CC2420Control.nc,v $
 * Revision 1.1.4.1  2007/04/25 23:20:17  njain
 * CVS: Please enter a Bugzilla bug number on the next line.
 * BugID: 1100
 *
 * CVS: Please enter the commit log message below.
 * License header modified in each file for MoteWorks_2_0_F release
 *
 * Revision 1.1  2006/02/16 18:39:11  nxu
 * ithese two files needed to be accessed by the binary
 *
 * Revision 1.1  2006/01/03 07:45:02  mturon
 * Initial install of MoteWorks tree
 *
 * Revision 1.2  2005/03/02 22:34:16  jprabhu
 * Added Log-tag for capturing changes in files.
 *
 *
 */

/**
 * CC2420 Radio Control interface.
 */
interface CC2420Control
{
  /**
   * Tune the radio to one of the 802.15.4 present channels.
   * Valid channel values are 11 through 26.
   * The channels are calculated by:
   *  Freq = 2405 + 5(k-11) MHz for k = 11,12,...,26
   * 
   * @param freq requested 802.15.4 channel
   * 
   * @return Status of the tune operation
   */
  command result_t TunePreset(uint8_t channel); 

  /**
   * Tune the radio to a given frequency. Frequencies may be set in
   * 1 MHz steps between 2400 MHz and 2483 MHz
   * 
   * @param freq The desired channel frequency, in MHz.
   * 
   * @return Status of the tune operation
   */
  command result_t TuneManual(uint16_t freq);

  /**
   * Turns on the 1.8V references on the CC2420.
   *
   * @return SUCCESS if the VREF has been turned on
   */
  async command result_t VREFOn();

  /**
   * Turns off the 1.8V references on the CC2420.
   *
   * @return SUCCESS if the VREF has been turned on
   */
  async command result_t VREFOff();

  /**
   * Turn on the crystal oscillator.
   *
   * @return SUCCESS if the request for the crystal to start has been accepted
   */
  async command result_t OscillatorOn();

  /**
   * Turn off the crystal oscillator.
   *
   * @return SUCCESS when the oscillator has started up
   */
  async command result_t OscillatorOff();

  /**
   * Shift the CC2420 Radio into transmit mode.
   *
   * @return SUCCESS if the radio was successfully switched to TX mode.
   */
  async command result_t TxMode();

  /**
   * Shift the CC2420 Radio into transmit mode when the next clear channel
   * is detected.
   *
   * @return SUCCESS if the transmit request has been accepted
   */
  async command result_t TxModeOnCCA();

  /**
   * Shift the CC2420 Radio in receive mode.
   *
   * @return SUCCESS if the radio was successfully switched to RX mode.
   */
  async command result_t RxMode();

  /**
   * Set the transmit RF power value.  
   * The input value is simply an arbitrary
   * index that is programmed into the CC2420 registers.  
   * The output power is set by programming the power amplifier.
   * Valid values are 1 through 31 with power of 1 equal to
   * -25dBm and 31 equal to max power (0dBm)
   *
   * @param power A power index between 1 and 31
   * 
   * @result SUCCESS if the radio power was adequately set.
   *
   */
  command result_t SetRFPower(uint8_t power);	

  /**
   * Get the present RF power index.
   *
   * @result The power index value.
   */
  command uint8_t  GetRFPower();		

  /**
   * Enables auto ack on the CC2420
   * 
   * @return SUCCESS if the mode of the CC2420 was successfully changed
   */
  async command result_t enableAutoAck();

  /**
   * Disables auto ack on the CC2420
   * 
   * @return SUCCESS if the mode of the CC2420 was successfully changed
   */
  async command result_t disableAutoAck();

  /**
   * Set the 16-bit short address of the mote
   *
   * @result SUCCESS if the request to set the address is being processed
   */
  command result_t setShortAddress(uint16_t addr);

  /**
   * Enables Rx Address decode on the CC2420 hardware
   * 
   * @return SUCCESS if the mode of the CC2420 was successfully changed
   */
  async command result_t enableAddrDecode();
  /**
   * Disable Rx Address decode on the CC2420 hardware
   * 
   * @return SUCCESS if the mode of the CC2420 was successfully changed
   */
  async command result_t disableAddrDecode();

}
