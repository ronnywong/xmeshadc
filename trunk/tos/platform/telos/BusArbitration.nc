/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: BusArbitration.nc,v 1.1.4.1 2007/04/26 22:18:31 njain Exp $
 */

/*
 *
 * Authors:		Joe Polastre
 *
 * $Id: BusArbitration.nc,v 1.1.4.1 2007/04/26 22:18:31 njain Exp $
 */

interface BusArbitration {
  async command result_t getBus();
  async command result_t releaseBus();
  event result_t busFree();
}

