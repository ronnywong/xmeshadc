/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: Radio.nc,v 1.1.4.1 2007/04/25 23:27:39 njain Exp $
 */
 
/*
 * Authors:		Jason Hill, David Gay, Philip Levis
 * Date last modified:  6/25/02
 *
 *
 */

/**
 * A bit-level interface to the mote radio. The radio has two states,
 * transmit and receive, and can be set. The sampling/interrupt rate
 * can be adjusted to one of three values: 0 (double sampling), 1
 * (one-and-a=half-sampling) and 2 (single sampling).
 *
 * <p> This interface, as it directly abstracts hardware, follows the
 * hardware interface convention of not maintaining state. Therefore,
 * some conditions that could be understood by a higher layer to be
 * errors execute properly; for example, one can call
 * <code>txBit</code> when in receive mode. A higher level interface
 * must provide the checks for conditions such as this.
 * @author Jason Hill
 * @author David Gay
 * @author Philip Levis
 */

interface Radio {

  /**
   * Start transmitting this bit. Does nothing if in receive mode.
   *
   * @return SUCCESS always.
   */
  
  command result_t txBit(uint8_t data);

  /**
   * Transition into transmit mode.
   *
   * @return SUCCESS always.
   */

  command result_t txMode();

  /**
   * Transition into receive mode.
   *
   * @return SUCCESS always.
   */

  command result_t rxMode();

  /**
   * Set bit rate to 0 (20Khz), 1 (13 KHz) or 2 (10 KHz).
   *
   * @return SUCCESS if valid setting, FAIL otherwise.
   *
   */
  command result_t setBitRate(char level);

  /**
   * Notification that a bit has been transmitted;
   * transmit next one with txBit.
   *
   * @return SUCCESS always.
   *
   */
  
  event result_t txBitDone();

  /**
   * Notification that a bit has been received.
   *
   * @return SUCCESS always.
   *
   */
  
  event result_t rxBit(uint8_t bit);
}
