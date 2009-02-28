/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: QueueControl.nc,v 1.1.4.1 2007/04/25 23:38:16 njain Exp $
 */

/* 
 * Author: Phil Buonadonna
 * $Revision: 1.1.4.1 $
 */

/**
 * @author Phil Buonadonna
 */


interface QueueControl {

  command uint16_t getOccupancy();
  command uint8_t getXmitCount();

}
