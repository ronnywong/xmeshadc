/*
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: MSP430I2CEvents.nc,v 1.1.4.1 2007/04/26 22:10:25 njain Exp $
 */

/**
 * @author Joe Polastre
 * Revision:  $Revision: 1.1.4.1 $
 *
 */
 
interface MSP430I2CEvents
{
  async event void arbitrationLost();
  async event void noAck();
  async event void ownAddr();
  async event void readyRegAccess();
  async event void readyRxData();
  async event void readyTxData();
  async event void generalCall();
  async event void startRecv();
}

