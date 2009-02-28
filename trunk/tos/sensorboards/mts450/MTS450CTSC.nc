/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: MTS450CTSC.nc,v 1.1.4.1 2007/04/27 05:52:49 njain Exp $
 */

/**
 * Provides the ability to write or read a series of bytes to/from the
 * I2C bus(for the chips 24**64).  
 * 
 * @author Xfshen , 2005/7/15 
 **/
 //for debugging using serial port 
 //#define SODBGON 1
//includes SOdebug;
 
includes sensorboard;

configuration MTS450CTSC
{
  provides {
    interface StdControl;
    interface MTS450CTS[uint8_t id];
  }
}

implementation {
  components I2CC, MTS450CTSM;

  StdControl = MTS450CTSM;
  MTS450CTS = MTS450CTSM;

 //interface to interactive with I2C bus on which the ADS 7828 is connected 
  MTS450CTSM.I2C -> I2CC;
  MTS450CTSM.I2CStdControl -> I2CC.StdControl;
}
