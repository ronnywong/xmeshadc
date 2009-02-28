/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: RF230Control.nc,v 1.1.2.2 2007/04/27 05:01:40 njain Exp $
 */

 
interface RF230Control {
	
/* === Channel Settings ==================================================== */

  /**
   *	Reset the radio.  Restore registers.  Goto RX_ON state.
   */	
  async command void resetRadio();
  
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
  async command result_t TunePreset(uint8_t channel); 
  
  async command uint8_t GetPreset(); 

  /**
   * Tune the radio to a given frequency. Frequencies may be set in
   * 1 MHz steps between 2400 MHz and 2483 MHz
   * 
   * @param freq The desired channel frequency, in MHz.
   * 
   * @return Status of the tune operation
   */
  async command result_t TuneManual(uint16_t freq);
  
  async command uint16_t GetManual();

/* === Power Settings ====================================================== */

  /**
   * Set the transmit RF power value.  The input value is platform dependent.
   * consult datasheet for the resulting power output/current consumption 
   * values.
   *
   * @param power A power index between 1 and 255.
   * 
   * @return SUCCESS if the radio power was adequately set.
   */
  async command result_t SetRFPower(uint8_t power);	

  /**
   * Get the present RF power index.
   *
   * @reutrn The power index value.
   */
  async command uint8_t  GetRFPower();
  
/* === RSSI / CRC / CCA / ED =============================================== */

  /**
   * @brief get the CRC and RSSI values after a packet reception
   *
   * @param crcValid ptr to a bool that indicates if crc is valid
   * @param rssi value representing rssi
   * @return void
   */
  async command void getRSSIandCRC(bool * crcValid, uint8_t * rssi);
  
  /**
   * @brief Get the value of the energy detection
   *
   * @param  void
   * @return rf energy in db
   */
  async command uint8_t getED();
  
  /**
   * @brief get the results of the clear channel assessment
   *
   * @param  void
   * @return bool, is the channel clear or not
   */
  async command bool CCA();
  
/* === Radio State Transitions ============================================= */

  /**
   * @brief set the radio state to TRX_OFF
   *
   */
  async command void set_TRX_OFF();
  
  /**
   * @brief set the radio state to TRX_OFF (with force) - terminate active send/recv
   *
   */
  async command void force_TRX_OFF();
  
  /**
   * @brief set the radio state to PLL_ON for transmission
   *
   */
  async command void set_PLL_ON();
  
  /**
   * @brief set the radio state to RX_ON for reception
   *
   */
  async command void set_RX_ON();

/* === Test Interfaces ===================================================== */

  //No modulation interface



	
}
