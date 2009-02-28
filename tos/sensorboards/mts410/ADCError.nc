/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: ADCError.nc,v 1.1.4.1 2007/04/27 05:43:21 njain Exp $
 */
 
/*
 *
 * Authors:		Joe Polastre
 *
 *
 */

interface ADCError
{
  /**
   * Enables error reporting for an ADC channel.
   * enable() must be called when the ADC is IDLE.  If it is busy
   * processing a request, enable() should return FAIL.
   *
   * @return SUCCESS if error reporting has been enabled
   */
  command result_t enable();

  /**
   * Disables error reporting for an ADC channel
   * disable() must be called when the ADC is IDLE.  If it is busy
   * processing a request, disable() should return FAIL.
   *
   * @return SUCCESS if error reporting has been disabled
   */
  command result_t disable();

  /**
   * Notification that an error has occurred in the sampling process.
   * Token values are sensor specific, see the specific sensor to
   * determine what the error values mean.
   *
   * @param token an error code that describes the error that occurred
   * @return SUCCESS to continue error reporting, FAIL to disable error
   *         reporting
   */
  event result_t error(uint8_t token);
}
