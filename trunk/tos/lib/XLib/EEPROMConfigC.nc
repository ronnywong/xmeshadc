/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * Copyright (c) 2004 by Sensicast, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: EEPROMConfigC.nc,v 1.2.4.1 2007/04/25 23:41:41 njain Exp $
 */


//
// @Author: Michael Newman
//
//
#define EEPROMConfigEdit 1
//
// Modification History:
//  13Jan04 MJNewman 1: Created.

includes config;
configuration EEPROMConfigC {
    provides interface StdControl;
    provides interface ConfigSave;
    provides interface XEEControl;

    // Where user settings are connected
    uses interface Config[AppParamID_t setting];
}
implementation {
    components
	    EEPROMConfigM,
	    NoLeds,
	    InternalEEPROMC;

    StdControl = EEPROMConfigM;
    ConfigSave = EEPROMConfigM;
    Config     = EEPROMConfigM;
    XEEControl = EEPROMConfigM;

    InternalEEPROMC.WriteData <- EEPROMConfigM;
    InternalEEPROMC.ReadData <- EEPROMConfigM;
    InternalEEPROMC.StdControl <- EEPROMConfigM.EEPROMstdControl;

    EEPROMConfigM.Leds -> NoLeds;
}
