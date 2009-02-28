/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: SamplerC.nc,v 1.1.4.2 2007/04/27 05:16:07 njain Exp $
 */

/*
 *
 * Authors:   Mohammad Rahimi mhr@cens.ucla.edu
 * History:   created 08/14/2003
 * history:   modified 11/14/2003
 *
 *
 */

includes sensorboard;
configuration SamplerC
{
  provides {      
      interface StdControl as SamplerControl;
      interface Sample;
      interface Power as EXCITATION25;
      interface Power as EXCITATION33;
      interface Power as EXCITATION50;      
      command result_t PlugPlay();
 }
}
implementation
{
    //components Main,SamplerM,LedsC,TimerC,DioC,IBADC,BatteryC,CounterC,TempHumM;
    components Main,
               SamplerM,
               LedsC,
               TimerC,
               DioC,
               IBADC,
               CounterC,
               //BatteryC,
               Voltage,
               PowerC;

    SamplerM.SamplerControl = SamplerControl;
    Main.StdControl -> TimerC;

    SamplerM.Sample = Sample;
    SamplerM.Leds -> LedsC;

    
    //To individualy Turn on/off Power 
    EXCITATION25 = PowerC.EXCITATION25;
    EXCITATION33 = PowerC.EXCITATION33;
    EXCITATION50 = PowerC.EXCITATION50;    

    //Timing management
    SamplerM.SamplerTimer -> TimerC.Timer[unique("Timer")];

    //analog channels
    SamplerM.IBADCcontrol -> IBADC.StdControl;
    SamplerM.ADC0 -> IBADC.ADConvert[0];
    SamplerM.ADC1 -> IBADC.ADConvert[1];
    SamplerM.ADC2 -> IBADC.ADConvert[2];
    SamplerM.ADC3 -> IBADC.ADConvert[3];
    SamplerM.ADC4 -> IBADC.ADConvert[4];
    SamplerM.ADC5 -> IBADC.ADConvert[5];
    SamplerM.ADC6 -> IBADC.ADConvert[6];
    SamplerM.ADC7 -> IBADC.ADConvert[7];
    SamplerM.ADC8 -> IBADC.ADConvert[8];
    SamplerM.ADC9 -> IBADC.ADConvert[9];
    SamplerM.ADC10 -> IBADC.ADConvert[10];
    SamplerM.ADC11 -> IBADC.ADConvert[11];
    //analog channel parameters
    SamplerM.SetParam0 -> IBADC.SetParam[0];
    SamplerM.SetParam1 -> IBADC.SetParam[1];
    SamplerM.SetParam2 -> IBADC.SetParam[2];
    SamplerM.SetParam3 -> IBADC.SetParam[3];
    SamplerM.SetParam4 -> IBADC.SetParam[4];
    SamplerM.SetParam5 -> IBADC.SetParam[5];
    SamplerM.SetParam6 -> IBADC.SetParam[6];
    SamplerM.SetParam7 -> IBADC.SetParam[7];
    SamplerM.SetParam8 -> IBADC.SetParam[8];
    SamplerM.SetParam9 -> IBADC.SetParam[9];
    SamplerM.SetParam10 -> IBADC.SetParam[10];
    SamplerM.SetParam11 -> IBADC.SetParam[11];

    //health channels
    SamplerM.BatteryControl -> Voltage.StdControl;
    SamplerM.Battery -> Voltage;
 
    //Digital input channels
    SamplerM.DioControl -> DioC.StdControl;
    SamplerM.Dio0 -> DioC.Dio[0];
    SamplerM.Dio1 -> DioC.Dio[1];
    SamplerM.Dio2 -> DioC.Dio[2];
    SamplerM.Dio3 -> DioC.Dio[3];
    SamplerM.Dio4 -> DioC.Dio[4];
    SamplerM.Dio5 -> DioC.Dio[5];
    SamplerM.Dio6 -> DioC.Dio[6];
    SamplerM.Dio7 -> DioC.Dio[7];

    //counter channels
    SamplerM.CounterControl -> CounterC.CounterControl;    
    SamplerM.Counter -> CounterC.Counter;
    SamplerM.Plugged -> CounterC.Plugged;

    PlugPlay = SamplerM.PlugPlay;
  }
