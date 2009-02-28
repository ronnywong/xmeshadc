/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: Excite.nc,v 1.1.4.1 2007/04/27 05:14:18 njain Exp $
 */
 
/*
 * Authors:   Mohammad Rahimi mhr@cens.ucla.edu
 * History:   created 08/14/2003
 *
 * interface that set the state of the ADC and external excitations on mda300ca
 *
 */

interface Excite {
  command result_t setEx(uint8_t excitation);
  command result_t setPowerMode(uint8_t mode);       //to turn device off after conversion or not
  command result_t setCoversionSpeed(uint8_t mode);  //to wait 50ms after turning devices on before sampling
  command result_t setAvergeMode(uint8_t mode);  //to Average before passing data back
}
