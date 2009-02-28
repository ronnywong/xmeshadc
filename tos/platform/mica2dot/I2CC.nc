/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: I2CC.nc,v 1.1.4.1 2007/04/26 00:21:30 njain Exp $
 */

/*
 *
 * Authors:		Joe Polastre, Rob Szewczyk
 * Date last modified:  7/18/02
 *
 */

/**
 * @author Joe Polastre
 * @author Rob Szewczyk
 */


configuration I2CC
{
  provides {
    interface StdControl;
    interface I2C;
  }
}
implementation {
  components I2CM;

  StdControl = I2CM;
  I2C = I2CM;
}
