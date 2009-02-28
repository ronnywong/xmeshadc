/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: Switch.nc,v 1.1.4.1 2007/04/27 05:16:32 njain Exp $
 */

/*
 * Authors:   Mohammad Rahimi mhr@cens.ucla.edu
 * History:   created @ 01/14/2003 
 * Last Modified:     @ 08/14/2003
 * 
 * driver for ADG715BRU on mda300ca 
 * inspired from joe Polastre previous driver 
 */


interface Switch {
  command result_t get();
  command result_t set(char position, char value);
 command result_t setAll(char value);

  event result_t getDone(char value);
  event result_t setDone(bool result);
  event result_t setAllDone(bool result);
}

