/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: MacControl.nc,v 1.1.4.1 2007/04/26 00:16:08 njain Exp $
 */
 
/*
 *
 * Authors:		Joe Polastre
 * Date last modified:  $Revision: 1.1.4.1 $
 *
 * Interface for CC1000 specific controls and signals
 */

/**
 * Mac Control Interface
 */
interface MacControl
{
  async command void enableAck();
  async command void disableAck();
}
