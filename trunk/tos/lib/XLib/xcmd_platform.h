/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: xcmd_platform.h,v 1.1.2.2 2007/04/25 23:43:30 njain Exp $
 */

/**
 *
 * @file   xcmd_platform.h
 * @author PiPeng
 * @date   Mar 2, 2007
 *
 * $Id: xcmd_platform.h,v 1.1.2.2 2007/04/25 23:43:30 njain Exp $
 */

#ifndef _XCMD_PLATFORM_H
#define _XCMD_PLATFORM_H


#if defined(PLATFORM_MICA2) || defined(PLATFORM_MICA2DOT) ||defined(PLATFORM_MICA2B) ||defined(PLATFORM_M9100)  || defined(PLATFORM_M4100)
#define XCMD_SET_RF_POWER(X)    \
   call CC1000Control.SetRFPower(X);
#define XCMD_GET_RF_POWER        call CC1000Control.GetRFPower()
#define XCMD_SET_CC_CHANNEL(X)  \
   TOS_CC1K_CHANNEL = X; \
   call CC1000Control.TunePreset(TOS_CC1K_CHANNEL);
#define XCMD_GET_CC_CHANNEL  TOS_CC1K_CHANNEL
#define XCMD_USE_CC_CONTROL_INTERFACE uses interface CC1000Control;
#elif defined(PLATFORM_MICAZ) || defined(PLATFORM_MICAZB) ||defined(PLATFORM_M2100)
#define XCMD_SET_RF_POWER(X)    \
   TOS_CC2420_TXPOWER = X; \
   call CC2420Control.SetRFPower(TOS_CC2420_TXPOWER);
#define XCMD_GET_RF_POWER           TOS_CC2420_TXPOWER 
#define XCMD_SET_CC_CHANNEL(X)  \
   TOS_CC2420_CHANNEL = X; \
   call CC2420Control.TunePreset(TOS_CC2420_CHANNEL);
#define XCMD_GET_CC_CHANNEL         TOS_CC2420_CHANNEL
#define XCMD_USE_CC_CONTROL_INTERFACE uses interface CC2420Control;

#elif defined(PLATFORM_MICAZC) || defined(PLATFORM_RCB230) ||defined(PLATFORM_M2110)
#define XCMD_SET_RF_POWER(X)    \
   TOS_RF230_TXPOWER = X; \
   call RadioControl.SetRFPower(TOS_RF230_TXPOWER);
#define XCMD_GET_RF_POWER           TOS_RF230_TXPOWER 
#define XCMD_SET_CC_CHANNEL(X)  \
   TOS_RF230_CHANNEL = X; \
   call RadioControl.setRfChannel(TOS_RF230_CHANNEL);
#define XCMD_GET_CC_CHANNEL         TOS_RF230_CHANNEL
#define XCMD_USE_CC_CONTROL_INTERFACE uses interface RadioControl;

#endif



#if defined(PLATFORM_MICA2) || defined(PLATFORM_MICA2DOT) || defined(PLATFORM_MICA2B) ||defined(PLATFORM_M9100)  || defined(PLATFORM_M4100)
#define XCMD_CC_CONTROL         CC1000Control
#define XCMD_CC_RADIO           CC1000RadioC
#elif defined(PLATFORM_MICAZ) || defined(PLATFORM_MICAZB) ||defined(PLATFORM_M2100)
#define XCMD_CC_CONTROL         CC2420Control
#define XCMD_CC_RADIO           CC2420RadioC

#elif defined(PLATFORM_RCB230) || defined(PLATFORM_MICAZC) ||defined(PLATFORM_M2110)
#define XCMD_CC_CONTROL         RadioControl
#define XCMD_CC_RADIO           RadioControlM

#endif


#endif
