/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: Logger.nc,v 1.1.4.1 2007/04/27 06:01:26 njain Exp $
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

includes EEPROM;

configuration Logger
{
  provides {
    interface StdControl;
    interface LoggerWrite;
    interface LoggerRead;
  }
}
implementation {
  components EEPROM, LoggerM;

  StdControl = LoggerM;
  LoggerWrite = LoggerM;
  LoggerRead = LoggerM;

  LoggerM.EEPROMControl -> EEPROM;
  LoggerM.EEPROMWrite -> EEPROM.EEPROMWrite[unique("EEPROMWrite")];
  LoggerM.EEPROMRead -> EEPROM.EEPROMRead;
}

