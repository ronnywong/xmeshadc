/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: IntOutput.nc,v 1.1.4.1 2007/04/25 23:24:27 njain Exp $
 */
 
/*
 * Authors:		Jason Hill, David Gay, Philip Levis, Nelson Lee
 * Date last modified:  6/25/02
 *
 *
 */

/**
 * Interface to an abstract ouput mechanism for integers. Two examples
 * of providers of this interface are IntToRfm and IntToLeds.
 *
 * @author Jason Hill
 * @author David Gay
 * @author Philip Levis
 * @author Nelson Lee
 */

interface IntOutput {

  /**
   * Output the given integer.
   *
   * @return SUCCESS if the value will be output, FAIL otherwise.
   */
  
  command result_t output(uint16_t value);

  /**
   * Signal that the ouput operation has completed; success states
   * whether the operation was successful or not.
   *
   * @return SUCCESS always.
   *
   */
  event result_t outputComplete(result_t success);
}
