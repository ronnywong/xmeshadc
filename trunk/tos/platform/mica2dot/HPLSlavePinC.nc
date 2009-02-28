/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: HPLSlavePinC.nc,v 1.1.4.1 2007/04/26 00:20:50 njain Exp $
 */
 
/*
 *
 * Authors:		Jason Hill, David Gay, Philip Levis
 * Date last modified:  6/25/02
 *
 */

// Low-level slave pin control


/**
 * @author Jason Hill
 * @author David Gay
 * @author Philip Levis
 */

module HPLSlavePinC {
  provides interface HPLSlavePin as SlavePin;
}
implementation
{
  command result_t SlavePin.high() {
    TOSH_SET_FLASH_SELECT_PIN();
    return SUCCESS;
  }

  command result_t SlavePin.low() {
    TOSH_CLR_FLASH_SELECT_PIN();
    return SUCCESS;
  }
}
