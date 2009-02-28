/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: TestSensor.nc,v 1.3.4.1 2007/04/26 20:28:03 njain Exp $
 */

/** 
 * XSensor single-hop application for MDA500 sensorboard.
 *
 * @author Martin Turon, Alan Broad, Hu Siquan, Pi Peng
 */

includes sensorboardApp;
configuration TestSensor { 
// this module does not provide any interface
}
implementation
{
  components Main, TestSensorM, LedsC, GenericComm as Comm,  
        TimerC, ADCC;

  Main.StdControl -> TestSensorM;

  TestSensorM.CommControl -> Comm;

  TestSensorM.Receive -> Comm.ReceiveMsg[AM_XSXMSG];
  TestSensorM.Send -> Comm.SendMsg[AM_XSXMSG];

  TestSensorM.ADCBATT -> ADCC.ADC[BATT_TEMP_PORT];
  TestSensorM.ADC2    -> ADCC.ADC[ADC2_PORT];
  TestSensorM.ADC3    -> ADCC.ADC[ADC3_PORT];
  TestSensorM.ADC4    -> ADCC.ADC[ADC4_PORT];
  TestSensorM.ADC5    -> ADCC.ADC[ADC5_PORT];
  TestSensorM.ADC6    -> ADCC.ADC[ADC6_PORT];
  TestSensorM.ADC7    -> ADCC.ADC[ADC7_PORT];
  
  
  TestSensorM.ADCControl -> ADCC;
  TestSensorM.Leds -> LedsC;
  TestSensorM.Timer -> TimerC.Timer[unique("Timer")];
}

