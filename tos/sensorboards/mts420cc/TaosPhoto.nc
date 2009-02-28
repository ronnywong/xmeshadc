/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: TaosPhoto.nc,v 1.1.2.2 2007/04/27 05:51:14 njain Exp $
 */

/*
 *
 * Authors:		Joe Polastre
 *
 */

includes sensorboard;

configuration TaosPhoto
{
  provides {
    interface ADC[uint8_t id];
    interface SplitControl;
  }
}
implementation
{
  components TaosPhotoM, I2CPacketC, TimerC, MicaWbSwitch;

  SplitControl = TaosPhotoM;
  ADC = TaosPhotoM;

  TaosPhotoM.I2CPacketControl -> I2CPacketC.StdControl;
  TaosPhotoM.I2CPacket -> I2CPacketC.I2CPacket[TOSH_PHOTO_ADDR];

  TaosPhotoM.TimerControl -> TimerC.StdControl; // Explicitly initialise Timer Module
  TaosPhotoM.Timer -> TimerC.Timer[unique("Timer")];

  TaosPhotoM.SwitchControl -> MicaWbSwitch.StdControl;
  TaosPhotoM.Switch -> MicaWbSwitch.Switch[0];
}
