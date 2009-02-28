/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: BusArbitrationC.nc,v 1.1.4.1 2007/04/26 22:18:42 njain Exp $
 */

/*
 *
 * Authors:		Joe Polastre
 *
 * $Id: BusArbitrationC.nc,v 1.1.4.1 2007/04/26 22:18:42 njain Exp $
 */

configuration BusArbitrationC
{
  provides {
    interface BusArbitration[uint8_t id];
    interface StdControl;
  }
}
implementation
{
  components BusArbitrationM;

  StdControl = BusArbitrationM;
  BusArbitration = BusArbitrationM;
}
