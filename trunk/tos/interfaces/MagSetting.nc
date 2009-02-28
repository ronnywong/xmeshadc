/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: MagSetting.nc,v 1.1.4.1 2007/04/25 23:25:42 njain Exp $
 */

/*
 * Authors:             Alec Woo
 * Date lase modified:  8/20/02
 *
 * The MagSetting inteface provides an asynchronous mechanism for
 * setting the gain offset for the Magnetometer on the mica sensorboard.
 * This is particularly useful in calibrating the offset of the Magnetometer
 * such that X and Y axis can stay in the center for idle signals.  
 * If not calibrated, the data you get may rail.  (railing means
 * the data either stays at the maximum (~785) or minimum (~240)). 
 *
 * The gain adjust has 256 steps ranging from 0 to 255.
 *
 */

/**
 * @author Alec Woo
 */

interface MagSetting {
  /* Effects:  adjust pot setting on the X axis of the magnetometer.
   * Returns:  return SUCCESS of FAILED.
   */
  command result_t gainAdjustX(uint8_t val);

  /* Effects:  adjust pot setting on the Y axis of the magnetometer.
   * Returns:  return SUCCESS of FAILED.
   */
  command result_t gainAdjustY(uint8_t val);

  /* Pot adjustment on the X axis of the magnetometer is finished.
   * Returns:  return SUCCESS.
   */
  event result_t gainAdjustXDone(bool result);

  /* Pot adjustment on the Y axis of the magnetometer is finished.
   * Returns:  return SUCCESS.
   */
  event result_t gainAdjustYDone(bool result);
}
