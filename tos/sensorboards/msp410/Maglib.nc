/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: Maglib.nc,v 1.1.4.1 2007/04/27 05:26:26 njain Exp $
 */
 
 
/*
 * Authors:		Mike Grimmer
 * Date last modified:  2-20-04
 * 
 */

interface Maglib
{
  command result_t mag_measure();
  command result_t mag_stop();
  command result_t mag_bias_stop();                 //stop auto bias  tracking
  command result_t mag_bias_start();                //restart auto bias tracking
  event result_t biasx_change(uint8_t MagDCx);      //signal that magx bias change is taking place
  event result_t biasy_change(uint8_t MagDCy);      //signal that magy bias change is taking place
  event result_t biasx_changedone(uint8_t MagDCx);  //signal that magx bias change is done
  event result_t biasy_changedone(uint8_t MagDCy);  //signal that magx bias change is done
  event result_t MagxReady(uint16_t magx_data);     //magx data
  event result_t MagyReady(uint16_t magy_data);     //magy data
}
