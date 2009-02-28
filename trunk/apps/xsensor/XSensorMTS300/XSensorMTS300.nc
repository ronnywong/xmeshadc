/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: XSensorMTS300.nc,v 1.3.4.1 2007/04/26 20:32:40 njain Exp $
 */

/** 
 * XSensor single-hop application for MTS310 sensorboard.
 *
 * @author Martin Turon, Alan Broad, Hu Siquan, Pi Peng
 */

#include "appFeatures.h"
includes sensorboardApp;
configuration XSensorMTS300 { 
// this module does not provide any interface
}
implementation
{
  components Main, GenericComm as Comm,
			 XSensorMTS300M, LedsC,

             XEE_PARAMS_COMPONENT

             TimerC, Voltage, MicC, PhotoTemp, Accel, Mag, Sounder;
 
  XEE_PARAMS_WIRING()
  
  Main.StdControl -> XSensorMTS300M;
  Main.StdControl -> TimerC;
  
  XSensorMTS300M.CommControl -> Comm;
  XSensorMTS300M.Receive -> Comm.ReceiveMsg[AM_XSXMSG];
  XSensorMTS300M.Send -> Comm.SendMsg[AM_XSXMSG];
  
  // Wiring for Battery Ref
  XSensorMTS300M.BattControl -> Voltage;  
  XSensorMTS300M.ADCBATT -> Voltage;  
  
  XSensorMTS300M.TempControl -> PhotoTemp.TempStdControl;
  XSensorMTS300M.PhotoControl -> PhotoTemp.PhotoStdControl;
  XSensorMTS300M.Temperature -> PhotoTemp.ExternalTempADC;
  XSensorMTS300M.Light -> PhotoTemp.ExternalPhotoADC;

  XSensorMTS300M.Sounder -> Sounder;
  
  XSensorMTS300M.MicControl -> MicC;
  XSensorMTS300M.Mic -> MicC;
  XSensorMTS300M.MicADC ->MicC;
  
  
  XSensorMTS300M.AccelControl->Accel;
  XSensorMTS300M.AccelX -> Accel.AccelX;
  XSensorMTS300M.AccelY -> Accel.AccelY;

  XSensorMTS300M.MagControl-> Mag;
  XSensorMTS300M.MagX -> Mag.MagX;
  XSensorMTS300M.MagY -> Mag.MagY;
  
  XSensorMTS300M.Leds -> LedsC;
  XSensorMTS300M.Timer -> TimerC.Timer[unique("Timer")];
}

