/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: IBADC.nc,v 1.1.4.1 2007/04/27 05:10:12 njain Exp $
 */
 
/*
 * Authors:   Mohammad Rahimi mhr@cens.ucla.edu
 * History:   created 08/14/2003
 *
 * driver for ADS7828EB on mda300ca
 *
 */

includes sensorboard;

configuration IBADC
{
  provides {
    interface StdControl;
    interface ADConvert[uint8_t port];
    interface SetParam[uint8_t port];
    interface Power as EXCITATION25;
    interface Power as EXCITATION33;
    interface Power as EXCITATION50;
  }
}
implementation
{
    components Main,I2CPacketC,IBADCM,LedsC,TimerC,SwitchC;

    StdControl = IBADCM;
    ADConvert = IBADCM;
    SetParam = IBADCM;
    IBADCM.Leds -> LedsC;
    IBADCM.I2CPacket -> I2CPacketC.I2CPacket[74];
    IBADCM.I2CPacketControl -> I2CPacketC.StdControl; 
    Main.StdControl -> TimerC;
    IBADCM.PowerStabalizingTimer -> TimerC.Timer[unique("Timer")];
    IBADCM.SwitchControl -> SwitchC.SwitchControl;
    IBADCM.Switch -> SwitchC.Switch;
    EXCITATION25 = IBADCM.EXCITATION25;
    EXCITATION33 = IBADCM.EXCITATION33;
    EXCITATION50 = IBADCM.EXCITATION50;    
}
