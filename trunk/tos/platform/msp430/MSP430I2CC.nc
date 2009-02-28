/*
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: MSP430I2CC.nc,v 1.1.4.1 2007/04/26 22:10:16 njain Exp $
 */

/**
 * @author Joe Polastre
 * Revision:  $Revision: 1.1.4.1 $
 *
 * Primitives for accessing the hardware I2C module on MSP430 microcontrollers.
 * This configuration assumes that the bus is available and reserved 
 * prior to use; aka Bus Arbitration occurs before start() is called.
 * Once the bus is acquired, call start() and then the commands in this module
 * may be used.  Likewise, stop() should be called before releasing the bus.
 */

configuration MSP430I2CC
{
  provides {
    interface StdControl;
    interface MSP430I2C;
    interface MSP430I2CPacket;
    interface MSP430I2CEvents;
  }
}
implementation
{
  components HPLUSART0M, MSP430I2CM as I2CM;

  StdControl = I2CM;
  MSP430I2C = I2CM;
  MSP430I2CPacket = I2CM;
  MSP430I2CEvents = I2CM;

  I2CM.USARTControl -> HPLUSART0M;
  I2CM.HPLI2CInterrupt -> HPLUSART0M;
}
