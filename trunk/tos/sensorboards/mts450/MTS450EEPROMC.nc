/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: MTS450EEPROMC.nc,v 1.1.4.1 2007/04/27 05:53:14 njain Exp $
 */

/**
 * Provides the ability to write or read a series of bytes to/from the
 * I2C bus(for the chips 24**64).  
 * 
 * @author Xfshen , 2005/7/15 
 **/
 
 //for debugging using serial port 

 
includes sensorboard;

configuration MTS450EEPROMC
{
  provides {
    interface StdControl;
    interface MTS450EEPROM[uint8_t id];
  }
}

implementation {
  components I2CC, MTS450EEPROMM;
  
  StdControl = MTS450EEPROMM;
  MTS450EEPROM = MTS450EEPROMM;
  
//interface to read or write I2C bus on which EEPROM is connected
  MTS450EEPROMM.I2C -> I2CC;
  MTS450EEPROMM.I2CStdControl -> I2CC.StdControl;
}
