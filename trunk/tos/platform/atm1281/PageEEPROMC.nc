/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: PageEEPROMC.nc,v 1.1.2.2 2007/04/26 00:07:07 njain Exp $
 */
 
/*
 *
 * Authors:		Jason Hill, David Gay, Philip Levis
 * Date last modified:  6/25/02
 *
 */

/**
 * @author Jason Hill
 * @author David Gay
 * @author Philip Levis
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
  components PageEEPROMM, PageEEPROMShare, HPLFlash, NoLeds as Leds;

  StdControl = PageEEPROMM;
  PageEEPROM = PageEEPROMShare;

  PageEEPROMShare.ActualEEPROM -> PageEEPROMM;

  PageEEPROMM.FlashSPI -> HPLFlash;
  PageEEPROMM.FlashControl -> HPLFlash;
  PageEEPROMM.FlashIdle -> HPLFlash;
  PageEEPROMM.getCompareStatus -> HPLFlash;
  PageEEPROMM.FlashSelect -> HPLFlash;

  PageEEPROMM.Leds -> Leds;
}
