/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: RadioControl.nc,v 1.2.4.1 2007/04/25 23:27:47 njain Exp $
 */
 
 /**
 * RadioControl.nc - Platform independent Radio control interface
 *
 *	Provides a subset of radio control interfaces that is common to 
 *  most platforms
 *
 *
 * <pre>
 *	$Id: RadioControl.nc,v 1.2.4.1 2007/04/25 23:27:47 njain Exp $
 * </pre>
 * 
 * @author Xin Yang
 * @date Feburary 16 2006
 */
 
 interface RadioControl {
	 
  /**
   * Tune the radio to one of the frequencies available in the CC1K_Params table.
   * Calling Tune will allso reset the rfpower and LockVal selections to the table 
   * values. 
   * 
   * @param freq The index into the CC1K_Params table that holds the desired preset
   * frequency parameters.
   * 
   * @return Status of the Tune operation.
   */

  command result_t TunePreset(uint8_t freq); 

  /**
   * Tune the radio to a given frequency. Since the CC1000 uses a digital
   * frequency synthesizer, it cannot tune to just an arbitrary frequency.
   * This routine will determine the closest achievable channel, compute 
   * the necessary parameters and tune the radio.
   * 
   * @param The desired channel frequency, in Hz.
   * 
   * @return The actual computed channel frequency, in Hz.  A return value
   * of '0' indicates that no frequency was computed and the radio was not
   * tuned.
   */

  command uint32_t TuneManual(uint32_t DesiredFreq);
  
  /**
   * Set the transmit RF power value.  The input value is simply an arbitrary
   * index that is programmed into the CC1000 registers.  Consult the CC1000
   * datasheet for the resulting power output/current consumption values.
   *
   * @param power A power index between 1 and 255.
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
 }
