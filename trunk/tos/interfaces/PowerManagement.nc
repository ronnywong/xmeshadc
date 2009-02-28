/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: PowerManagement.nc,v 1.1.4.1 2007/04/25 23:27:30 njain Exp $
 */

/**
 * Adjust the power state of a component.
 *
 * @author Robert Szewczyk
 *
 */


interface PowerManagement {
  async command uint8_t adjustPower();
}
