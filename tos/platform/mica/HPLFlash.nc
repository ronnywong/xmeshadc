/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: HPLFlash.nc,v 1.1.4.1 2007/04/26 00:24:03 njain Exp $
 */
 
/*
 *
 * Authors:		Jason Hill, David Gay, Philip Levis
 * Date last modified:  6/25/02
 *
 */

/**
 * Low level hardware access to the onboard EEPROM (well, Flash actually)
 * @author Jason Hill
 * @author David Gay
 * @author Philip Levis
 */

configuration HPLFlash {
  provides {
    interface StdControl as FlashControl;
    interface FastSPI as FlashSPI;
    interface SlavePin as FlashSelect;
    interface Resource as FlashIdle;
    command bool getCompareStatus();
  }
}
implementation
{
  components HPLFlashM, SlavePinC;

  FlashControl = HPLFlashM;
  FlashSPI = HPLFlashM;
  FlashIdle = HPLFlashM;
  FlashSelect = HPLFlashM;
  getCompareStatus = HPLFlashM;

  HPLFlashM.SlaveControl -> SlavePinC;
  HPLFlashM.SlavePin -> SlavePinC;
}

