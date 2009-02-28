/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: Accel.nc,v 1.1.4.1 2007/04/27 05:39:32 njain Exp $
 */

includes sensorboard;
configuration Accel 
{
  provides interface ADC as AccelX;
  provides interface ADC as AccelY;
  provides interface StdControl;
  provides interface I2CSwitchCmds as AccelCmd;
}
implementation
{
  components AccelM, ADCC, MicaWbSwitch, TimerC;
  AccelCmd = AccelM;
 
  StdControl = AccelM;
  AccelM.Timer -> TimerC.Timer[unique("Timer")];
 
  
  AccelX = ADCC.ADC[ADC_ACCEL_X_PORT];
  AccelY = ADCC.ADC[ADC_ACCEL_Y_PORT];
 
  AccelM.ADCControl -> ADCC;
  AccelM.SwitchControl -> MicaWbSwitch.StdControl;
  AccelM.Switch1 -> MicaWbSwitch.Switch[0];
  
  


}
