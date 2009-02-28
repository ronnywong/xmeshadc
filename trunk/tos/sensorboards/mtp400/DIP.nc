/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: DIP.nc,v 1.1.4.1 2007/04/27 05:31:51 njain Exp $
 */

/*
 *
 * driver for DIP Switch on mtp400ca
 *
 * PW5 control the power of DIP Switch
 * PB5 indicate the sensor type {RTD, CT} of Channel 1
 * PB6 indicate the sensor type {RTD, CT} of Channel 2
 * PE2 indicate the sensor type {RTD, CT} of Channel 3
 * 
 * 
 * Authors: Hu Siquan <husq@xbow.com>
 *
 * $Id: DIP.nc,v 1.1.4.1 2007/04/27 05:31:51 njain Exp $  
 */


interface DIP {
	
  command result_t getSensorType();

  event result_t sensorTypeReady(char value);
}
