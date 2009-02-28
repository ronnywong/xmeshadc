/*
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: I2CPacketC.nc,v 1.1.4.1 2007/04/26 22:25:18 njain Exp $
 */

/**
 * @author Joe Polastre
 * Revision:  $Revision: 1.1.4.1 $
 *
 * Provides the ability to write or read a series of bytes to/from the
 * I2C bus.  
 **/
configuration I2CPacketC
{
  provides {
    interface StdControl;
    interface MSP430I2CPacket;
  }
}
implementation {
  components I2CPacketM, MSP430I2CC as XI2C, BusArbitrationC;

  StdControl = I2CPacketM;
  MSP430I2CPacket = I2CPacketM.I2CPacket;

  I2CPacketM.LPacket -> XI2C;
  I2CPacketM.LControl -> XI2C;

  I2CPacketM.BusArbitration -> BusArbitrationC.BusArbitration[unique("BusArbitration")];

}
