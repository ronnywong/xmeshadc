/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: DemoSensorC.nc,v 1.1.4.1 2007/04/27 05:22:33 njain Exp $
 */

/**
 * DemoSensorC is a wrapper that exports one sensor from each sensorboard
 * to be used in tutorial and demo applications.
 * @author Joe Polastre
 */

configuration DemoSensorC
{
  provides interface ADC;
  provides interface StdControl;
}
implementation
{
  components Photo as Sensor;

  StdControl = Sensor;
  ADC = Sensor;
}
