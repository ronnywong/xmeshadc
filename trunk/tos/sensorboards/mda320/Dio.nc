/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: Dio.nc,v 1.1.4.1 2007/04/27 05:13:36 njain Exp $
 */
 
/*
 * Authors:   Mohammad Rahimi mhr@cens.ucla.edu
 * History:   created 08/14/2003
 *
 * Digital channels interface
 *
 */


interface Dio {
  command result_t getData();
  command result_t high();
  command result_t low();
  command result_t Toggle();	
  //command result_t getValue();
  //the number of egdes to count before geting u back that data
  //if zero it always count and only give u back the resltu when`
  command result_t setparam(uint8_t modeToSet);
  event result_t dataReady(uint16_t data);
  //event result_t valueReady(bool value);
  event result_t dataOverflow();
}
