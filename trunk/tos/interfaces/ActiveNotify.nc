/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: ActiveNotify.nc,v 1.1.4.1 2007/04/25 23:18:03 njain Exp $
 */
 
/*
 * Authors:		Philip Levis
 * Date last modified:  8/12/02
 *
 * The ActiveNotify interface provides an asynchronous mechanism for
 * providing knowledge about whether a component is currently
 * active. Its initial use is intended for ad-hoc routing
 * (e.g. whether the system has a valid route), but can be used in a
 * much wider range of context (e.g. radio power on/off).
 */

/**
 * Interface for notifying interested components when another
 * component activates or deactivates. activated()/deactivated()
 * events do not come in pairs -- a component may signal multiple
 * activated() events without intervening deactivated() events.
 * @author Philip Levis
 */

interface ActiveNotify {

  /**
   * Signaled when the component has activated.
   */
  event void activated();

  /**
   * Signaled when the component has deactivated.
   */
  event void deactivated();
}
