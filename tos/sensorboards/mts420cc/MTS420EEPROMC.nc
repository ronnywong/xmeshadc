/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: MTS420EEPROMC.nc,v 1.1.2.2 2007/04/27 05:50:15 njain Exp $
 */
 
/*
 * Authors:		pipeng
 * Date:		2005/9/9
 *
 */

 
 //for debugging using serial port 

 
includes sensorboard;

configuration MTS420EEPROMC
{
  provides {
    interface StdControl;
    interface MTS420EEPROM[uint8_t id];
  }
}

implementation {
  components I2CC, MTS420EEPROMM,MicaWbSwitch;
  
  StdControl = MTS420EEPROMM;
  MTS420EEPROM = MTS420EEPROMM;
  
//interface to read or write I2C bus on which EEPROM is connected
  MTS420EEPROMM.I2C -> I2CC;
  MTS420EEPROMM.I2CStdControl -> I2CC.StdControl;
  
  MTS420EEPROMM.SwitchControl -> MicaWbSwitch.StdControl;
  MTS420EEPROMM.Switch -> MicaWbSwitch.Switch[0];
  
}
