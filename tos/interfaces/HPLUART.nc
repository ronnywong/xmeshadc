/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: HPLUART.nc,v 1.1.4.1 2007/04/25 23:23:20 njain Exp $
 */
/*
 * Authors:		Jason Hill, David Gay, Philip Levis
 * Date last modified:  6/25/02
 *
 *
 */

/**
 * The byte-level interface to the UART, which can send and receive
 * simultaneously.
 *
 * <p> This interface, as it directly abstracts hardware, follows the
 * hardware interface convention of not maintaining state. Therefore,
 * some conditions that could be understood by a higher layer to be
 * errors execute properly; for example, one can call
 * <code>txBit</code> when in receive mode. A higher level interface
 * must provide the checks for conditions such as this.
 *
 * @author Jason Hill
 * @author David Gay
 * @author Philip Levis
 */

interface HPLUART {

  /**
   * Initialize the UART.
   *
   * @return SUCCESS always.
   */
  
  async command result_t init();

  /**
   * TUrn off the UART
   *
   * @return SUCCESS always
   */

  async command result_t stop();


  /**
   * Send one byte of data. There should only one outstanding send at
   * any time; one must wait for the <code>putDone</code> event before
   * calling <code>put</code> again.
   *
   * @return SUCCESS always.
   */
  async command result_t put(uint8_t data);

  /**
   * A byte of data has been received.
   *
   * @return SUCCESS always.
   */
  
  async event result_t get(uint8_t data);

  /**
   * The previous call to <code>put</code> has completed; another byte
   * may now be sent.
   *
   * @return SUCCESS always.
   */
  async event result_t putDone();
}
