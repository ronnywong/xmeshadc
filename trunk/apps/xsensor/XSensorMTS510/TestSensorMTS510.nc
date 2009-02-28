/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: TestSensorMTS510.nc,v 1.3.4.1 2007/04/26 20:36:55 njain Exp $
 */

/** 
 * XSensor single-hop application for MTS510 sensorboard.
 *
 * @author Martin Turon, Alan Broad, Hu Siquan, Pi Peng
 */


includes sensorboardApp;
configuration TestSensorMTS510 {
}
implementation {
  components Main, TestSensorMTS510M, GenericComm as Comm, 
             Photo, Accel, MicC, TimerC, LedsC;

  Main.StdControl -> TestSensorMTS510M;
  Main.StdControl -> TimerC;

  TestSensorMTS510M.CommControl -> Comm;

  TestSensorMTS510M.Receive -> Comm.ReceiveMsg[AM_XSXMSG];
  TestSensorMTS510M.Send -> Comm.SendMsg[AM_XSXMSG];

  TestSensorMTS510M.Leds -> LedsC;

  TestSensorMTS510M.Timer -> TimerC.Timer[unique("Timer")];

  TestSensorMTS510M.MicControl -> MicC;
  TestSensorMTS510M.MicADC -> MicC; 
  TestSensorMTS510M.Mic -> MicC;

  TestSensorMTS510M.PhotoControl -> Photo; 
  TestSensorMTS510M.PhotoADC -> Photo; 

  TestSensorMTS510M.AccelControl->Accel;
  TestSensorMTS510M.AccelX -> Accel.AccelX;
  TestSensorMTS510M.AccelY -> Accel.AccelY;

} 
