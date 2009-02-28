/*
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: HPLFlashC.nc,v 1.1.4.1 2007/04/26 22:19:50 njain Exp $
 */


/**
 * HPLFlashC.nc - Driver for AT45DB041 flash on telos. 
 * 
 * This driver is intended to force as little change as possible to
 * the existing PageEEPROM implementation for Micas. 
 *
 * @author Jonathan Hui <jwhui@cs.berkeley.edu>
 */

configuration HPLFlashC {
  provides {
    interface StdControl as FlashControl;
    interface FastSPI as FlashSPI;
    interface BusArbitration as FlashSelect;
  }
}
implementation
{
  components HPLFlashM, HPLUSART0M, BusArbitrationC;

  FlashControl = HPLFlashM;
  FlashSPI = HPLFlashM;
  FlashSelect = HPLFlashM;

  HPLFlashM.USARTControl -> HPLUSART0M;
  HPLFlashM.BusArbitration -> BusArbitrationC.BusArbitration[unique("BusArbitration")];
}

