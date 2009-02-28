/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: MicaWbSwitch.nc,v 1.1.4.1 2007/04/27 05:41:13 njain Exp $
 */

/*
 *
 * Authors:	        Joe Polastre
 *
 */

includes sensorboard;

configuration MicaWbSwitch
{
  provides {
    interface StdControl;
    interface Switch[uint8_t id];
  }
}
implementation
{
  components I2CPacketC,MicaWbSwitchM;

  StdControl = MicaWbSwitchM;
  Switch = MicaWbSwitchM;

  MicaWbSwitchM.I2CPacketControl -> I2CPacketC.StdControl;

  MicaWbSwitchM.I2CSwitch0 -> I2CPacketC.I2CPacket[TOSH_SWITCH0_ADDR];
  MicaWbSwitchM.I2CSwitch1 -> I2CPacketC.I2CPacket[TOSH_SWITCH1_ADDR];
}
