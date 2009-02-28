/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: HPLRFM.nc,v 1.1.4.1 2007/04/25 23:23:12 njain Exp $
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
 *
 * <p> This interface makes no sense to me. Where's the rxBit event? 
 * Why is there an rxBit command? -pal
 *
 * @author Jason Hill
 * @author David Gay
 * @author Philip Levis
 */

interface HPLRFM {
  command uint8_t rxBit();
  command result_t txBit(uint8_t data);
  command result_t powerOff();
  command result_t disableTimer();
  command result_t enableTimer();
  command result_t txMode();
  command result_t rxMode();
  command result_t setBitRate(uint8_t level);
  command result_t init();

  event result_t bitEvent();
}
