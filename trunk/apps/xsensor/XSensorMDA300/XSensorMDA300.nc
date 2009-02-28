/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: XSensorMDA300.nc,v 1.3.4.1 2007/04/26 20:25:45 njain Exp $
 */
 
/** 
 * XSensor single-hop application for MDA300 sensorboard.
 *
 * @author Martin Turon, Alan Broad, Hu Siquan, Pi Peng
 */

// include local hardware defs for this sensor board app
includes sensorboardApp;
#include "appFeatures.h"


configuration XSensorMDA300 { 
// this module does not provide any interface
}

implementation {
    
    components Main, XSensorMDA300M, 
    GenericComm as Comm,LedsC,SamplerC,TimerC;  

    Main.StdControl -> XSensorMDA300M;    
    Main.StdControl -> TimerC;
    
    XSensorMDA300M.Leds -> LedsC;    
    XSensorMDA300M.Timer -> TimerC.Timer[unique("Timer")];    

    //Sampler Communication    
    XSensorMDA300M.SamplerControl -> SamplerC.SamplerControl;    
    XSensorMDA300M.Sample -> SamplerC.Sample;
 
    XSensorMDA300M.CommControl -> Comm;
    XSensorMDA300M.Receive -> Comm.ReceiveMsg[AM_XSXMSG];
    XSensorMDA300M.Send -> Comm.SendMsg[AM_XSXMSG];
    
    //support for plug and play.    
    XSensorMDA300M.PlugPlay -> SamplerC.PlugPlay;

    //relays
    XSensorMDA300M.relay_normally_closed -> SamplerC.relay_normally_closed;
    XSensorMDA300M.relay_normally_open -> SamplerC.relay_normally_open;

}



