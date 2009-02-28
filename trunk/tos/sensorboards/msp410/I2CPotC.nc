/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: I2CPotC.nc,v 1.1.4.1 2007/04/27 05:25:44 njain Exp $
 */

/*
 *
 * Authors:		Alec Woo
 * Date last modified:  7/23/02
 *
 */

configuration I2CPotC
{
  provides 
  {
    interface StdControl;
    interface I2CPot;
  }
}

implementation 
{
  components I2CC, I2CPotM, LedsC;

  StdControl = I2CPotM;
  I2CPot = I2CPotM;
  I2CPotM.I2C -> I2CC;
  I2CPotM.I2CControl -> I2CC;
}
