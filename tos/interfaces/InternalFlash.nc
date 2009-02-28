/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: InternalFlash.nc,v 1.1.4.1 2007/04/25 23:24:44 njain Exp $
 */

/**
 * InternalFlash.nc - A generic interface to read and store values in
 * the internal flash of a microcontroller.
 *
 * @author Jonathan Hui <jwhui@cs.berkeley.edu>
 */

interface InternalFlash {
  command result_t write(void* addr, void* buf, uint16_t size);
  command result_t read(void* addr, void* buf, uint16_t size);
}
