/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: appFeatures.h,v 1.1.4.1 2007/04/26 20:33:13 njain Exp $
 */

/**
 * Compile-time flags for defining application specific feature preferences.
 *
 * @file       appFeatures.h
 * @author     Martin Turon
 *
 * @version    2004/8/8         mturon          Initial version
 *
 */
// current Xee lib donnot support MicaZ
#ifdef PLATFORM_MICAZ
#define FEATURE_XEE_PARAMS  0
#else
#define FEATURE_XEE_PARAMS  0
#endif

/// FEATURE_XEE_PARAMS -- enables changing nodeid, group, and other params
#ifndef FEATURE_XEE_PARAMS
#define FEATURE_XEE_PARAMS  0
#endif


/** 
 * FEATURE_XEE_PARAMS enables dynamic setting of various parameters when set. 
 * Params include: nodeid, group, radio power, radio freq/band.
 */
#if FEATURE_XEE_PARAMS
#define XEE_PARAMS_COMPONENT   RecoverParamsC,
#define XEE_PARAMS_WIRING()    Main.StdControl->RecoverParamsC.ParamControl;
#else 
#define XEE_PARAMS_COMPONENT 
#define XEE_PARAMS_WIRING()     
#endif



