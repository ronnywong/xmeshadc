/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: XSensorMDA320.nc,v 1.3.4.1 2007/04/26 20:26:30 njain Exp $
 */

/** 
 * XSensor single-hop application for MDA320 sensorboard.
 *
 * @author Pi Peng
 */

// include local hardware defs for this sensor board app
includes sensorboardApp;
#include "appFeatures.h"


configuration XSensorMDA320 { 
// this module does not provide any interface
}

implementation {
    
    components Main, XSensorMDA320M, 
    GenericComm as Comm,MDA300EEPROMC,
XEE_PARAMS_COMPONENT
    NoLeds,SamplerC,TimerC;  

    Main.StdControl -> XSensorMDA320M;    
    Main.StdControl -> TimerC;
    XSensorMDA320M.MDA300EEPROMControl -> MDA300EEPROMC.StdControl;
XEE_PARAMS_WIRING()    
    
    XSensorMDA320M.Leds -> NoLeds;    
    XSensorMDA320M.Timer -> TimerC.Timer[unique("Timer")];    
    XSensorMDA320M.MDA300EEPROM -> MDA300EEPROMC.MDA300EEPROM[0x56];

    //Sampler Communication    
    XSensorMDA320M.SamplerControl -> SamplerC.SamplerControl;    
    XSensorMDA320M.Sample -> SamplerC.Sample;
 
    XSensorMDA320M.CommControl -> Comm;
    XSensorMDA320M.Receive -> Comm.ReceiveMsg[AM_XSXMSG];
    XSensorMDA320M.Send -> Comm.SendMsg[AM_XSXMSG];
    
    //support for plug and play.    
    XSensorMDA320M.PlugPlay -> SamplerC.PlugPlay;


}



