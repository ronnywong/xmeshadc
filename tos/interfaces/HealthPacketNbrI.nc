/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: HealthPacketNbrI.nc,v 1.1.4.1 2007/04/25 23:23:45 njain Exp $
 */

interface HealthPacketNbrI{
  command uint8_t getNbrList(HealthNeighbor *p, uint8_t max_nbr);
}
