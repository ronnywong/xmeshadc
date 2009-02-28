/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: MDA300EEPROMC.nc,v 1.1.4.1 2007/04/27 05:15:00 njain Exp $
 */

/*
 *
 * Authors:		PiPeng
 * Date last modified:  12/23/04
 *
 */

/**
 * Provides the ability to write or read a series of bytes to/from the
 * I2C bus(for the chips 24**64).  
 * @author PiPeng
 **/
configuration MDA300EEPROMC
{
  provides {
    interface StdControl;
    interface MDA300EEPROM[uint8_t id];
  }
}

implementation {
  components I2CC, MDA300EEPROMM;

  StdControl = MDA300EEPROMM;
  MDA300EEPROM = MDA300EEPROMM;

  MDA300EEPROMM.I2C -> I2CC;
  MDA300EEPROMM.I2CStdControl -> I2CC.StdControl;
}
