/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: NeighborI.nc,v 1.1.4.1 2007/04/25 23:26:40 njain Exp $
 */
 
/*
 * handle traffic from neighbors (route update packet, sniffed packets used for 
 * link quality estimation)
 */

interface NeighborI {
  /**
   * rte== TRUE : route update message
   */
  event void receive(TOS_MsgPtr Msg, bool rte);
}
