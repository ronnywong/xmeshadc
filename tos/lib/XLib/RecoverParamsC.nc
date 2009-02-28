/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * Copyright (c) 2004 by Sensicast, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: RecoverParamsC.nc,v 1.2.4.5 2007/04/25 23:42:15 njain Exp $
 */

//
// @Author: Michael Newman, Hu Siquan
//
// $Id: RecoverParamsC.nc,v 1.2.4.5 2007/04/25 23:42:15 njain Exp $

#define RecoverParamsCedit 1
includes config;
#include "xcmd_platform.h"

configuration RecoverParamsC {
    provides interface StdControl as ParamControl;
    provides interface XEEControl;
    provides interface Config[AppParamID_t setting];
    provides interface ConfigSave;
    uses interface StdControl as CommControl;
}
implementation {
    components RecoverParamsM, RecoverSystemParamsM, SerialId, EEPROMConfigC,
    XCMD_CC_RADIO;
    
    ParamControl = EEPROMConfigC.StdControl;
    ParamControl = RecoverSystemParamsM.XEESubControl;
    XEEControl   = EEPROMConfigC.XEEControl;
    
    Config = RecoverParamsM.ExternalConfig;
    ConfigSave = EEPROMConfigC;
	CommControl = RecoverSystemParamsM.CommControl;
	
    EEPROMConfigC.Config -> RecoverParamsM;	
	
    RecoverSystemParamsM.XCMD_CC_CONTROL ->XCMD_CC_RADIO;
	
    RecoverSystemParamsM.DS2401 -> SerialId;
    RecoverSystemParamsM.HardwareId -> SerialId;

    RecoverParamsM.ConfigInt16[CONFIG_MOTE_ID] -> RecoverSystemParamsM.SystemMoteID;
    RecoverParamsM.ConfigInt8[CONFIG_MOTE_GROUP] -> RecoverSystemParamsM.SystemGroupNumber; 
    RecoverParamsM.ConfigInt8[CONFIG_MOTE_MODEL] -> RecoverSystemParamsM.SystemModelType;
    RecoverParamsM.ConfigInt8[CONFIG_MOTE_SUBMODEL] -> RecoverSystemParamsM.SystemSuModelType;
    RecoverParamsM.ConfigInt8[CONFIG_MOTE_CPU_TYPE] -> RecoverSystemParamsM.SystemMoteCPUType;
    RecoverParamsM.ConfigInt8[CONFIG_MOTE_RADIO_TYPE] -> RecoverSystemParamsM.SystemRadioType;
    RecoverParamsM.ConfigInt16[CONFIG_MOTE_VENDOR] -> RecoverSystemParamsM.SystemVendorID;
    RecoverParamsM.Config[CONFIG_MOTE_SERIAL] -> RecoverSystemParamsM.SystemSerialNumber;
    RecoverParamsM.Config[CONFIG_MOTE_CPU_OSCILLATOR_HZ] -> RecoverSystemParamsM.SystemCPUOscillatorFrequency;   

    RecoverParamsM.ConfigInt8[CONFIG_RF_POWER]->RecoverSystemParamsM.RadioPower; // 8 bits of rf power 
    RecoverParamsM.ConfigInt8[CONFIG_RF_CHANNEL]->RecoverSystemParamsM.RadioChannel; // 8 bits of rf channel 

  
    RecoverParamsM.Config[CONFIG_FACTORY_INFO1]->RecoverSystemParamsM.CrossbowFactoryInfo1; // 16 bytes of factory information (printable ascii)
    RecoverParamsM.Config[CONFIG_FACTORY_INFO2]->RecoverSystemParamsM.CrossbowFactoryInfo2; // 16 bytes of factory information (printable ascii)
    RecoverParamsM.Config[CONFIG_FACTORY_INFO3]->RecoverSystemParamsM.CrossbowFactoryInfo3; // 16 bytes of factory information (printable ascii)
    RecoverParamsM.Config[CONFIG_FACTORY_INFO4]->RecoverSystemParamsM.CrossbowFactoryInfo4; // 16 bytes of factory information (printable ascii)  
    
    RecoverParamsM.Config[CONFIG_XMESHAPP_TIMER_RATE]->RecoverSystemParamsM.XmeshAppTimerRate; // 32 bits of xmesh apps' timer rate
}
