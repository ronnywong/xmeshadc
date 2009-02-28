/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: MTS410EEPROMC.nc,v 1.1.4.1 2007/04/27 05:45:01 njain Exp $
 */

/*
 *
 * Authors:		pipeng
 * Date:		2005/9/9
 *
 */

 
 //for debugging using serial port 

 
includes sensorboard;

configuration MTS410EEPROMC
{
  provides {
    interface StdControl;
    interface MTS410EEPROM[uint8_t id];
  }
}

implementation {
  components I2CC, MTS410EEPROMM;
  
  StdControl = MTS410EEPROMM;
  MTS410EEPROM = MTS410EEPROMM;
  
//interface to read or write I2C bus on which EEPROM is connected
  MTS410EEPROMM.I2C -> I2CC;
  MTS410EEPROMM.I2CStdControl -> I2CC.StdControl;
}
