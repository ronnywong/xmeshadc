/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: HealthI.nc,v 1.1.4.1 2007/04/25 23:23:37 njain Exp $
 */

interface HealthI {
 command void trigger(); 
 event result_t receiveAck(); 
}
