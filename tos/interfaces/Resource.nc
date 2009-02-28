/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: Resource.nc,v 1.1.4.1 2007/04/25 23:29:10 njain Exp $
 */
 
interface Resource {
  command result_t wait();
  event result_t available();
}
