/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: TestSensor.nc,v 1.3.4.1 2007/04/26 20:31:09 njain Exp $
 */

/** 
 * XSensor single-hop application for MTS101 sensorboard.
 *
 * @author Martin Turon, Alan Broad, Hu Siquan, Pi Peng
 */


#include "appFeatures.h"
includes sensorboardApp;
configuration TestSensor { 
// this module does not provide any interface
}
implementation
{
  components Main, TestSensorM, LedsC,GenericComm as Comm,  
              TimerC, Voltage, Temp, Photo, ADCC;

  Main.StdControl -> TestSensorM;
  Main.StdControl -> TimerC;

  TestSensorM.CommControl -> Comm;

  TestSensorM.Receive -> Comm.ReceiveMsg[AM_XSXMSG];
  TestSensorM.Send -> Comm.SendMsg[AM_XSXMSG];
  
  // Wiring for Battery Ref
  TestSensorM.BattControl -> Voltage;  
  TestSensorM.ADCBATT -> Voltage;  

  TestSensorM.TempControl -> Temp;
  TestSensorM.Temperature -> Temp;
  
  TestSensorM.PhotoControl -> Photo;
  TestSensorM.Light -> Photo.PhotoADC;
  
    TestSensorM.ADCControl -> ADCC;
    TestSensorM.ADC0    -> ADCC.ADC[TOS_ADC_MAG_X_PORT];
    TestSensorM.ADC1    -> ADCC.ADC[TOS_ADC_MAG_Y_PORT];
    TestSensorM.ADC2    -> ADCC.ADC[TOS_ADC_MIC_PORT];
    TestSensorM.ADC3    -> ADCC.ADC[TOS_ADC_ACCEL_X_PORT];
    TestSensorM.ADC4    -> ADCC.ADC[TOS_ADC_ACCEL_Y_PORT];
  
  TestSensorM.Leds -> LedsC;
  TestSensorM.Timer -> TimerC.Timer[unique("Timer")];
}

