/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: EEPROM.nc,v 1.1.4.1 2007/04/26 00:23:53 njain Exp $
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


configuration EEPROM
{
  provides {
    interface StdControl;
    interface EEPROMRead;
    interface EEPROMWrite[uint8_t writerId];
  }
}
implementation
{
  components eepromM, PageEEPROMC;

  StdControl = eepromM;
  EEPROMRead = eepromM;
  EEPROMWrite = eepromM;

  eepromM.PageControl -> PageEEPROMC;
  eepromM.PageEEPROM -> PageEEPROMC.PageEEPROM[unique("PageEEPROM")];
}
