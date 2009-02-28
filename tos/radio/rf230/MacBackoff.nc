/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: MacBackoff.nc,v 1.1.2.2 2007/04/27 05:01:23 njain Exp $
 */
 
/*
 *
 * Authors:		Joe Polastre
 * Date last modified:  $Revision: 1.1.2.2 $
 *
 * Interface for CC1000 specific controls and signals
 */

/**
 * Mac Backoff Interface
 */
interface MacBackoff
{
  async event int16_t initialBackoff(TOS_MsgPtr m);
  async event int16_t congestionBackoff(TOS_MsgPtr m);
}
