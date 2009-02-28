/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: ADConvert.nc,v 1.1.4.1 2007/04/27 05:12:54 njain Exp $
 */
 
/*
 * Authors:   Mohammad Rahimi mhr@cens.ucla.edu
 * History:   created 11/14/2003
 *
 * This is a copy of ADC interface to have conversion interface t
 * for cases that seat on top of raw conversion and we do not want
 * to be callable from Interrupt so async has been removed
 */


interface ADConvert {
  /**
   * Initiates an ADC conversion on a given port.
   *
   * @return SUCCESS if the ADC is free and available to accept the request
   */
  command result_t getData();
  /**
   * Initiates a series of ADC conversions. Each return from 
   * <code>dataReady()</code> initiates the next conversion.
   *
   * @return SUCCESS if the ADC is free and available to accept the request
   */
  command result_t getContinuousData();

  /**
   * Indicates a sample has been recorded by the ADC as the result
   * of a <code>getData()</code> command.
   *
   * @param data a 2 byte unsigned data value sampled by the ADC.
   *
   * @return SUCCESS if ready for the next conversion in continuous mode.
   * if not in continuous mode, the return code is ignored.
   */
  event result_t dataReady(uint16_t data);
}
