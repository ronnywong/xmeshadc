/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: CS64EEPROMC.nc,v 1.1.4.1 2007/04/27 05:31:34 njain Exp $
 */

/*
 *
 * driver for 24LCS64 EEPROM on mtp400ca
 *
 * PW4 control the power of 24LCS64 EEPROM
 * 
 * (1010A2A1A0) is address; 
 * (1010101) 
 * Authors: Hu Siquan <husq@xbow.com>
 *
 */
configuration CS64EEPROMC {
  provides {
    interface StdControl;  	
    interface WriteData;
    interface ReadData;
  }
}
implementation {
  components CS64EEPROMM, I2CPacketC;
  
  StdControl = CS64EEPROMM;  
  WriteData  = CS64EEPROMM;
  ReadData   = CS64EEPROMM;
  
  CS64EEPROMM.I2CControl -> I2CPacketC;
  CS64EEPROMM.I2CPacket  -> I2CPacketC.I2CPacket[85];  
}
