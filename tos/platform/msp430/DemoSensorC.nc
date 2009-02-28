/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: DemoSensorC.nc,v 1.1.4.1 2007/04/26 22:04:44 njain Exp $
 */

/*
 *
 * Authors:   Jason Hill, David Gay, Philip Levis
 * Date last modified:  6/25/02
 *
 */

/**
 * @author Jason Hill
 * @author David Gay
 * @author Philip Levis
 * @author Kevin Klues (adaptation for the EYES nodes)
 */


configuration DemoSensorC
{
  provides interface ADC;
  provides interface StdControl;
}
implementation
{
  components InternalTempC as DemoSensor;
  
  StdControl = DemoSensor;
  ADC = DemoSensor;
}
