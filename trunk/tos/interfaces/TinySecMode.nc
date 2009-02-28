/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: TinySecMode.nc,v 1.1.4.1 2007/04/25 23:33:03 njain Exp $
 */

/* Authors: Chris Karlof
 * Date:    10/27/02
 */

/**
 * @author Chris Karlof
 */

interface TinySecMode
{
  /**
   * Sets the transmit mode for TinySec. 
   *
   * @param mode should be one of TINYSEC_AUTH_ONLY, TINYSEC_ENCRYPT_AND_AUTH,
   *        or TINYSEC_DISABLED
   * @return SUCCESS if the mode parameter is valid, FAIL otherwise.
   */
  command result_t setTransmitMode(uint8_t mode);

  /**
   * Sets the receive mode for TinySec. 
   *
   * @param mode should be one of TINYSEC_RECEIVE_AUTHENTICATED,
   *        TINYSEC_RECEIVE_CRC, or TINYSEC_RECEIVE_ANY
   * @return SUCCESS if the mode parameter is valid, FAIL otherwise.
   */
  command result_t setReceiveMode(uint8_t mode);

  /**
   * Gets the current transmit mode for TinySec. 
   *
   * @return The current transmit mode.
   */
  command uint8_t getTransmitMode();

  /**
   * Gets the current receive mode for TinySec. 
   *
   * @return The current receive mode.
   */
  command uint8_t getReceiveMode();
  
}
