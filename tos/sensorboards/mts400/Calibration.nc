/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: Calibration.nc,v 1.1.4.1 2007/04/27 05:39:49 njain Exp $
 */

/*
 *
 * Authors:		Joe Polastre
 *
 */

interface Calibration {
  command result_t getData();
  event result_t dataReady(char word, uint16_t value);
}

