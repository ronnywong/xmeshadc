/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: ADC.nc,v 1.1.4.1 2007/04/25 23:17:22 njain Exp $
 */

includes ADC;
//includes sensorboard; // this defines the user names for the ports

/**
 * Analog to Digital Converter Interface. <p>
 * Defines the functions provided by any ADC
 * 
 * @modified  6/25/02
 *
 * @author Jason Hill
 * @author David Gay
 * @author Philip Levis
 */

interface ADC {
  /**
   * Initiates an ADC conversion on a given port.
   *
   * @return SUCCESS if the ADC is free and available to accept the request
   */
  async command result_t getData();
  /**
   * Initiates a series of ADC conversions. Each return from 
   * <code>dataReady()</code> initiates the next conversion.
   *
   * @return SUCCESS if the ADC is free and available to accept the request
   */
  async command result_t getContinuousData();

  /**
   * Indicates a sample has been recorded by the ADC as the result
   * of a <code>getData()</code> command.
   *
   * @param data a 2 byte unsigned data value sampled by the ADC.
   *
   * @return SUCCESS if ready for the next conversion in continuous mode.
   * if not in continuous mode, the return code is ignored.
   */
  async event result_t dataReady(uint16_t data);
}

