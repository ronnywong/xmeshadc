/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: I2CC.nc,v 1.1.4.1 2007/04/27 05:18:41 njain Exp $
 */


/*
 *
 * Authors:		Phil Buonadonna, Joe Polastre, Rob Szewczyk
 * Date last modified:  12/19/02
 *
 * Note: Modify this configuration file to choose between software or hardware
 * based I2C.
 */

/* Uncomment line below to enable Hardware based I2C on the mica128 */
//#define HARDWARE_I2C

configuration I2CC
{
  provides {
    interface StdControl;
    interface I2C;
  }
}
implementation {

#ifdef HARDWARE_I2C
  components HPLI2CM, HPLInterrupt,LedsC;

  StdControl = HPLI2CM;
  I2C = HPLI2CM;
  HPLI2CM.Interrupt->HPLInterrupt;
  HPLI2CM.Leds -> LedsC.Leds;
#else
  components I2CM,LedsC;

  StdControl = I2CM;
  I2C = I2CM; 
  I2CM.Leds -> LedsC.Leds;
#endif
}
