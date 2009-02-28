/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: XSensorMDA325.nc,v 1.3.4.1 2007/04/26 20:27:16 njain Exp $
 */
 
/** 
 * XSensor single-hop application for MDA325 sensorboard.
 *
 * @author Pi Peng
 */

// include local hardware defs for this sensor board app
includes sensorboardApp;
#include "appFeatures.h"


configuration XSensorMDA325 { 
// this module does not provide any interface
}

implementation {
    
    components Main, XSensorMDA325M, 
    GenericComm as Comm,MDA300EEPROMC,
XEE_PARAMS_COMPONENT
    NoLeds,SamplerC,TimerC;  

    Main.StdControl -> XSensorMDA325M;    
    Main.StdControl -> TimerC;
    XSensorMDA325M.MDA300EEPROMControl -> MDA300EEPROMC.StdControl;
XEE_PARAMS_WIRING()    
    
    XSensorMDA325M.Leds -> NoLeds;    
    XSensorMDA325M.Timer -> TimerC.Timer[unique("Timer")];    
    XSensorMDA325M.MDA300EEPROM -> MDA300EEPROMC.MDA300EEPROM[0x56];

    //Sampler Communication    
    XSensorMDA325M.SamplerControl -> SamplerC.SamplerControl;    
    XSensorMDA325M.Sample -> SamplerC.Sample;
 
    XSensorMDA325M.CommControl -> Comm;
    XSensorMDA325M.Receive -> Comm.ReceiveMsg[AM_XSXMSG];
    XSensorMDA325M.Send -> Comm.SendMsg[AM_XSXMSG];
    
    //support for plug and play.    
    XSensorMDA325M.PlugPlay -> SamplerC.PlugPlay;


}



