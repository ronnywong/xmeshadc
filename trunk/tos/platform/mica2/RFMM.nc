/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: RFMM.nc,v 1.1.4.1 2007/04/26 00:16:33 njain Exp $
 */
 
/*
 *
 * Authors:		Jason Hill, David Gay, Philip Levis
 * Date last modified:  6/25/02
 *
 */

/*
 * This component performs bit level control over the RF Monolitics radio.
 * Addtionally, it controls the amount of time per bit by using TCNT1.
 * The sample period can be set to 1/2x, 3/4x, and x. Where x is the 
 * bit transmisison period. 1/2 and 3/4 are provided to do sampling 
 * and then read at the point half way between samples.
 * 
 */

module RFMM
{
  provides {
    interface StdControl as Control;
    interface Radio;
  }
  uses interface HPLRFM as RFM;
}
implementation
{
  enum {
    RECEIVE_MODE = 0,
    TRANSMIT_MODE = 1,
    LOW_POWER_MODE = 2,
    MYSTERIOUS_MODE = 3
  };

  uint8_t state;

  command result_t Control.init() {
    state = RECEIVE_MODE;
    return call RFM.init();
  }

  /* This command sets the RFM component (radio) into different power mode */
  command result_t Control.start() {
    return SUCCESS;
  }
  

  command result_t Control.stop() {
    call RFM.powerOff();
    call RFM.disableTimer();
    state = LOW_POWER_MODE;
    return SUCCESS;
  }
  
  
  /* This is a SIGNAL handler that timer1 generates to trigger this
     component to sample on the radio */
  event result_t RFM.bitEvent() {
    switch (state) 
      {
      case TRANSMIT_MODE:
	signal Radio.txBitDone();
	break;

      case RECEIVE_MODE:
	signal Radio.rxBit(call RFM.rxBit());
	break;
      }
    return SUCCESS;
  }

  /* This command tells the RFM to transmit bit "data" */
  command result_t Radio.txBit(uint8_t data) {
    if (state != TRANSMIT_MODE)
      return FAIL;
    return call RFM.txBit(data);
  }

  /* This command sets the RFM component (radio) into transmit mode */
  command result_t Radio.txMode() {
    if (state == LOW_POWER_MODE)
      return FAIL;

    dbg(DBG_RADIO, "RADIO: set TX mode....\n");
    state = TRANSMIT_MODE;

    return call RFM.txMode();
  }

  /* This command sets the RFM component (radio) into receiving mode */
  command result_t Radio.rxMode() {
    if (state == LOW_POWER_MODE)
      return FAIL;

    dbg(DBG_RADIO, "RADIO: set RX mode....\n");
    state = RECEIVE_MODE;

    return call RFM.rxMode();
  }

  command result_t Radio.setBitRate(char level) {
    return call RFM.setBitRate(level);
  }
}
