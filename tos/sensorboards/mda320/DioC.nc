/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: DioC.nc,v 1.1.4.1 2007/04/27 05:13:44 njain Exp $
 */
 
/*
 *
 * Authors:   Mohammad Rahimi mhr@cens.ucla.edu
 * History:   created 08/14/2003
 *
 * driver for PCF8574APWR on mda300ca
 *
 */

includes sensorboard;

configuration DioC {
  provides {
      interface StdControl;
      interface Dio[uint8_t channel];
  }
}
implementation {
    components LedsC,DioC,I2CPacketC,DioM;
    StdControl =  DioM.StdControl;
    Dio = DioM;
    DioM.Leds -> LedsC.Leds;
    /*X0111A2A1A0 which x i do not care and all inputs high*/
    DioM.I2CPacket -> I2CPacketC.I2CPacket[63];      
    DioM.I2CPacketControl -> I2CPacketC.StdControl;
}

