/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: MTS450CTS.nc,v 1.1.4.1 2007/04/27 05:52:41 njain Exp $
 */

interface MTS450CTS
{ /**
   * Initiates an ADC conversion from ADS 7828.
   *
   * @return SUCCESS if the ADC is free and available to accept the request
   */
    command result_t getData();

   /**
   * Indicates a sample has been recorded by the ADC as the result
   * of a <code>getData()</code> command.
   *
   * @param data a point to an one-byte data value sampled by the ADC.
   *
   * @return SUCCESS if ready for the next conversion in continuous mode.
   * if not in continuous mode, the return code is ignored.
   */
   event result_t dataReady(char* data);
}
  
