/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: Relay.nc,v 1.1.4.1 2007/04/27 05:46:08 njain Exp $
 */
 
/*
 * Authors:   Mohammad Rahimi mhr@cens.ucla.edu
 * History:   created 11/14/2003
 *
 * Relay channels interface
 *
 */


interface Relay {
  command result_t open();
  command result_t close();
  command result_t toggle();	
}
