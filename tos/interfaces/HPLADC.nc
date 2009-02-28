/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: HPLADC.nc,v 1.1.4.1 2007/04/25 23:22:55 njain Exp $
 */
 
/*
 * Authors:		Jason Hill, David Gay, Philip Levis
 * Date last modified:  6/25/02
 *
 *
 */

/**
 * Interface to the hardware ADC. Allows binding of virtual ports to
 * physical hardware ports (useful for platform independence).
 *
 * @author Jason Hill
 * @author David Gay
 * @author Philip Levis
 */

interface HPLADC {

  /**
   * Initialize the ADC.
   *
   * @return SUCCESS always.
   */
  async command result_t init();

  /**
   * Sets the ADC sampling rate in terms of clock ticks.
   *
   * @return SUCCESS always.
   */

  async command result_t setSamplingRate(uint8_t rate);

  /**
   * Bind a virtual port number to an actual ADC data port.
   *
   * @return FAIL if virtual port out of range, SUCCESS otherwise.
   */
  
  async command result_t bindPort(uint8_t port, uint8_t adcPort);

  /**
   * Request a single data sample on a port.
   *
   * @return SUCCESS always.
   */
  async command result_t samplePort(uint8_t port);

  /**
   * Sample the most recently sampled port again.
   * 
   * @return SUCCESS alway s.
   */
  async command result_t sampleAgain();

  /**
   * Stop sampling. Return to an idle mode.
   *
   * @return SUCCESS always.
   */
  async command result_t sampleStop();

  /**
   * Signaled when a data ready is ready.
   *
   * @return SUCCESS always.
   */
  
  async event result_t dataReady(uint16_t data);
}

