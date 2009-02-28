/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: ElpControlI.nc,v 1.1.4.1 2007/04/25 23:21:57 njain Exp $
 */

/**
 * Interface to control power management of an Extended Low Power mote.
 */
interface ElpControlI {

  /** enable this component */
  command result_t enable();
  /** disable this component */
  command result_t disable();
  command bool isActive();
}
