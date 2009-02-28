/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: HPLPotC.nc,v 1.1.4.1 2007/04/26 00:09:54 njain Exp $
 */
 
/*
 *
 * Authors:		Jason Hill, David Gay, Philip Levis
 * Date last modified:  6/25/02
 *
 */

// The hardware presentation layer. See hpl.h for the C side.
// Note: there's a separate C side (hpl.h) to get access to the avr macros

// The model is that HPL is stateless. If the desired interface is as stateless
// it can be implemented here (Clock, FlashBitSPI). Otherwise you should
// create a separate component


/**
 * @author Jason Hill
 * @author David Gay
 * @author Philip Levis
 */
module HPLPotC {
  provides interface HPLPot as Pot;
}
implementation
{
  command result_t Pot.decrease() {
    TOSH_SET_UD_PIN();
    TOSH_CLR_POT_SELECT_PIN();
    TOSH_SET_INC_PIN();
    TOSH_CLR_INC_PIN();
    TOSH_SET_POT_SELECT_PIN();
    return SUCCESS;
  }

  command result_t Pot.increase() {
    TOSH_CLR_UD_PIN();
    TOSH_CLR_POT_SELECT_PIN();
    TOSH_SET_INC_PIN();
    TOSH_CLR_INC_PIN();
    TOSH_SET_POT_SELECT_PIN();
    return SUCCESS;
  }

  command result_t Pot.finalise() {
    TOSH_SET_UD_PIN();
    TOSH_SET_INC_PIN();
    return SUCCESS;
  }
}
