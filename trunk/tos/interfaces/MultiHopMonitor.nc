/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: MultiHopMonitor.nc,v 1.1.4.1 2007/04/25 23:26:32 njain Exp $
 */
 
/*
 * Authors:		Wei Hong
 * Date last modified:  03/03/03
 *
 * The purpose of this interface for applications to monitor
 * the health and statistics about the multihop routing layer.
 */

/**
 * @author Wei Hong
 */


interface MultiHopMonitor {
  /**
   *
   * @return the address of the parent node in the routing tree.
   */
  
  command uint16_t getParent();

  // XXX more commands to be added later
}
