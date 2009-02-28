/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: ADCControl.nc,v 1.1.2.2 2007/04/26 00:03:55 njain Exp $
 */
 
/*
 * Authors:		Alec Woo, David Gay, Philip Levis
 * Date last modified:  6/25/02
 *
 *
 */

/**
 * Controls various aspects of the ADC.
 */
interface ADCControl {
  /**
   * Initializes the ADCControl structures.
   *
   * @return SUCCESS if successful
   */
  command result_t init();

  /**
   * Sets the sampling rate of the ADC.
   * These are the lower three bits in the ADCSR register of the
   * microprocessor.
   *
   * The <code>rate</code> parameter may use the following macros or
   * its own value from the description below.
   * <p>
   * <pre>
   *  TOS_ADCSample3750ns = 0 
   *  TOS_ADCSample7500ns = 1
   *  TOS_ADCSample15us =   2
   *  TOS_ADCSample30us =   3
   *  TOS_ADCSample60us =   4
   *  TOS_ADCSample120us =  5
   *  TOS_ADCSample240us =  6
   *  TOS_ADCSample480us =  7
   * </pre>
   *
   * @param rate 2^rate is the prescaler factor to the ADC.
   * The rate of the ADC is the crystal frequency times the prescaler,
   * or XTAL * 2^rate = 32kHz * 2^rate.
   *
   * @return SUCCESS if successful
   */
  command result_t setSamplingRate(uint8_t rate);

  /**
   * Remaps a port in the ADC portmap <code>TOSH_adc_portmap</code>.
   *
   * See <code>platform/mica/HPLADCC.td</code> for implementation.
   *
   * @param port The port in the portmap you wish to modify
   * @param adcPort The ADC destination port that <code>port</code> binds to
   *
   * @return SUCCESS if successful
   */
  command result_t bindPort(uint8_t port, uint8_t adcPort);

  /**
   * Initiates calibration of the of the ADC.  This may be a software
   * or hardware calibration depending on the platform.
   *
   * @return SUCCESS if the calibration was successfully initiated
   */
  async command result_t manualCalibrate();

  /**
   * Initiates and sets the interval for repeated automatic calibration 
   * of the ADC.  An interval value of 0 (zero) disables automatic
   * calibration
   *
   * @param interval The calibration interval in ms.  A value of 0 (zero)
   * disables automatic calibration
   *
   * @return SUCCESS if auto calibration was enabled
   */
  async command result_t autoCalibrate(uint16_t interval);

}

