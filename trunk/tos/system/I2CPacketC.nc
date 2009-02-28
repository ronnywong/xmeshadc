/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: I2CPacketC.nc,v 1.1.4.1 2007/04/27 06:00:53 njain Exp $
 */

/*
 *
 * Authors:		Joe Polastre
 * Date last modified:  7/18/02
 *
 */

/**
 * Provides the ability to write or read a series of bytes to/from the
 * I2C bus.  For more information, look at the I2CPacket.ti interface
 **/
configuration I2CPacketC
{
  provides {
    interface StdControl;
    interface I2CPacket[uint8_t id];
  }
}

implementation {
  components I2CC,I2CPacketM,LedsC;

  StdControl = I2CPacketM;
  I2CPacket = I2CPacketM;

  I2CPacketM.I2C -> I2CC;
  I2CPacketM.I2CStdControl -> I2CC.StdControl;
  I2CPacketM.Leds -> LedsC;
}
