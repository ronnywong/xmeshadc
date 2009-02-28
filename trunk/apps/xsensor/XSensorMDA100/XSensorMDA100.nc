/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: XSensorMDA100.nc,v 1.3.4.1 2007/04/26 20:24:59 njain Exp $
 */

/** 
 * XSensor single-hop application for MDA100 sensorboard.
 *
 * @author Pi Peng
 */

#include "appFeatures.h"
includes sensorboardApp;
configuration XSensorMDA100 { 
// this module does not provide any interface
}
implementation
{
  components Main, XSensorMDA100M, LedsC,GenericComm as Comm,  
              TimerC, Voltage, PhotoTemp, ADCC;

  Main.StdControl -> XSensorMDA100M;
  Main.StdControl -> TimerC;

  XSensorMDA100M.CommControl -> Comm;

  XSensorMDA100M.Receive -> Comm.ReceiveMsg[AM_XSXMSG];
  XSensorMDA100M.Send -> Comm.SendMsg[AM_XSXMSG];
  
  // Wiring for Battery Ref
  XSensorMDA100M.BattControl -> Voltage;  
  XSensorMDA100M.ADCBATT -> Voltage;  

  XSensorMDA100M.TempControl -> PhotoTemp.TempStdControl;   
  XSensorMDA100M.PhotoControl -> PhotoTemp.PhotoStdControl; 
  XSensorMDA100M.Temperature -> PhotoTemp.ExternalTempADC;  
  XSensorMDA100M.Light -> PhotoTemp.ExternalPhotoADC;     
        
    XSensorMDA100M.ADCControl -> ADCC;
    XSensorMDA100M.ADC2    -> ADCC.ADC[TOS_ADC2_PORT];
    XSensorMDA100M.ADC3    -> ADCC.ADC[TOS_ADC3_PORT];
    XSensorMDA100M.ADC4    -> ADCC.ADC[TOS_ADC4_PORT];
    XSensorMDA100M.ADC5    -> ADCC.ADC[TOS_ADC5_PORT];
    XSensorMDA100M.ADC6    -> ADCC.ADC[TOS_ADC6_PORT];
  
  XSensorMDA100M.Leds -> LedsC;
  XSensorMDA100M.Timer -> TimerC.Timer[unique("Timer")];
}

