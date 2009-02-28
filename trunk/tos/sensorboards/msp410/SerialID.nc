/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: SerialID.nc,v 1.1.4.1 2007/04/27 05:29:22 njain Exp $
 */

/*  
 * 
  * Authors:		Mike Grimmer
 * Date last modified:  2-20-04
 */

interface SerialID
{
  command result_t read(uint8_t* idloc);

  event result_t readDone();
}

