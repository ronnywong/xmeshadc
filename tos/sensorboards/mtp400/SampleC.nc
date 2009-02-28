/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: SampleC.nc,v 1.1.4.1 2007/04/27 05:32:50 njain Exp $
 */

includes sensorboard;
configuration SampleC
{
  provides {      
      interface StdControl as SamplerControl;
      interface Sample;
 }
}
implementation
{
    components SampleM,
               LedsC,
               SwitchC,
               ADS8344;

    SamplerControl = SampleM.SamplerControl;
    Sample         = SampleM;
    SampleM.Leds -> LedsC;
	SampleM.Switch -> SwitchC;
	SampleM.SwitchControl -> SwitchC;
    // adc channels
    SampleM.IBADCcontrol -> ADS8344.StdControl;
    SampleM.Vexc -> ADS8344.ADConvert[0];
    SampleM.Vsense -> ADS8344.ADConvert[1];
    SampleM.Vrtn -> ADS8344.ADConvert[2];
//    SampleM.Vd2a -> ADS8344.ADConvert[3];
    
//    SampleM.CalControl ->AD5321C.StdControl;
//    SampleM.SetOutPercent ->AD5321C;  
  }
