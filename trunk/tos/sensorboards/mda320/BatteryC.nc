/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: BatteryC.nc,v 1.1.4.1 2007/04/27 05:13:02 njain Exp $
 */
 
/*
 *
 * Authors:   Mohammad Rahimi mhr@cens.ucla.edu
 * History:   created 08/14/2003
 *
 */


includes sensorboard;

configuration BatteryC
{
  provides interface ADConvert as Battery;
  provides interface StdControl;
}
implementation
{
  components BatteryM, ADCC;
  
  StdControl = BatteryM;
  Battery = BatteryM.Battery;

  BatteryM.ADC -> ADCC.ADC[TOS_ADC_VOLTAGE_PORT];
  BatteryM.ADCControl -> ADCC;
  
}
