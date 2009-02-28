/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: PageEEPROMC.nc,v 1.1.4.1 2007/04/26 22:21:41 njain Exp $
 */
 
/*
 *
 * Authors:		Jason Hill, David Gay, Philip Levis, Jonathan Hui
 * Date last modified:  6/23/04
 *
 * Updated: 06/23/04 Jonathan Hui <jwhui@cs.berkeley.edu> 
 *          Removed SlavePin interface for compatibility with Telos
 *          platform.
 *
 */

/**
 * @author Jason Hill
 * @author David Gay
 * @author Philip Levis
 * @author Jonathan Hui
 */


configuration PageEEPROMC
{
  provides {
    interface StdControl;
    interface PageEEPROM[uint8_t client];
  }
}
implementation
{
  components PageEEPROMM, PageEEPROMShare, HPLFlashC, NoLeds as Leds;

  StdControl = PageEEPROMM;
  PageEEPROM = PageEEPROMShare;

  PageEEPROMShare.ActualEEPROM -> PageEEPROMM;

  PageEEPROMM.FlashSPI -> HPLFlashC;
  PageEEPROMM.FlashControl -> HPLFlashC;
  PageEEPROMM.FlashSelect -> HPLFlashC;

  PageEEPROMM.Leds -> Leds;
}
