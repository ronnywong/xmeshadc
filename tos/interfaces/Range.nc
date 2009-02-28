/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: Range.nc,v 1.1.4.1 2007/04/25 23:28:28 njain Exp $
 */

/* Authors:  David Gay  <dgay@intel-research.net>
 *           Intel Research Berkeley Lab
 *
 */

/**
 * @author David Gay <dgay@intel-research.net>
 * @author Intel Research Berkeley Lab
 */

includes Range;

interface Range {
  /**
   * Set the (very) approximate radio range to one of the RANGE_xxx
   * constants from Range.h
   * @return SUCCESS if range can be set, FAIL otherwise
   */
  command result_t set(uint8_t range);
}
