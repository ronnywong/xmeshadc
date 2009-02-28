/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: RangeM.nc,v 1.1.4.1 2007/04/26 00:26:58 njain Exp $
 */

/* Authors:  David Gay  <dgay@intel-research.net>
 *           Intel Research Berkeley Lab
 *
 */

/**
 * @author David Gay <dgay@intel-research.net>
 * @author Intel Research Berkeley Lab
 */

module RangeM
{
  provides interface Range;
  uses interface Pot;
}
implementation
{
  /* Simple implementation on mica: just choose appropriate pot setting.
     (on rene2 you need to sample battery voltage periodically and
     adjust pot setting) */
  command result_t Range.set(uint8_t range) {
    switch (range)
      {
      case RANGE_6FT:
	return call Pot.set(81);
      }
    return FAIL;
  }
}
