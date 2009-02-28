/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: MyApp.nc,v 1.1.2.2 2007/04/26 20:04:27 njain Exp $
 */
 
includes sensorboardApp;

/**
 * This module shows how to use the Timer, LED, ADC and Messaging components.
 * Sensor messages are sent to the serial port
 **/
configuration MyApp {
}
implementation {
  components Main, MyAppM, TimerC, LedsC, Photo, ByteEEPROM, GenericComm as Comm;
  
  Main.StdControl -> TimerC.StdControl;
  Main.StdControl -> ByteEEPROM; 
  Main.StdControl -> MyAppM.StdControl;
  Main.StdControl -> Comm.Control;
  
  MyAppM.Timer -> TimerC.Timer[unique("Timer")];
  MyAppM.Leds -> LedsC.Leds;
  MyAppM.PhotoControl -> Photo.PhotoStdControl;
  MyAppM.Light -> Photo.ExternalPhotoADC;
  MyAppM.AllocationReq -> ByteEEPROM.AllocationReq[BYTE_EEPROM_ID];
  MyAppM.ReadData->ByteEEPROM.ReadData[BYTE_EEPROM_ID];
  MyAppM.WriteData->ByteEEPROM.WriteData[BYTE_EEPROM_ID];
  MyAppM.SendMsg -> Comm.SendMsg[AM_XSXMSG];
}

