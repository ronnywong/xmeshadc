/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: Switch.nc,v 1.1.4.1 2007/04/27 05:41:46 njain Exp $
 */

/*
 *
 * Authors:		Joe Polastre
 *
 */

interface Switch {
  command result_t get();
  command result_t set(char position, char value);
  command result_t setAll(char value);

  event result_t getDone(char value);
  event result_t setDone(bool result);
  event result_t setAllDone(bool result);
}

