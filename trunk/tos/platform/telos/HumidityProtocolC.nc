/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: HumidityProtocolC.nc,v 1.1.4.1 2007/04/26 22:21:08 njain Exp $
 */
 
/*
 *
 * Authors:		Mohammad Rahmim, Joe Polastre
 *
 * $Id: HumidityProtocolC.nc,v 1.1.4.1 2007/04/26 22:21:08 njain Exp $
 */

configuration HumidityProtocolC {
  provides {
    interface StdControl;
    interface ADC as TempSensor;
    interface ADC as HumSensor;
    interface ADCError as TempError;
    interface ADCError as HumError;
  }
}
implementation {
  components HumidityProtocolM
    , TimerC
    , MSP430InterruptC
    ;
  StdControl =  HumidityProtocolM.StdControl;
  TempSensor = HumidityProtocolM.TempSensor;
  HumSensor = HumidityProtocolM.HumSensor;
  TempError = HumidityProtocolM.TempError;
  HumError = HumidityProtocolM.HumError;

  HumidityProtocolM.SensirionInterrupt -> MSP430InterruptC.Port15;

  HumidityProtocolM.TimerControl -> TimerC;
  HumidityProtocolM.Timer -> TimerC.Timer[unique("Timer")];
}

