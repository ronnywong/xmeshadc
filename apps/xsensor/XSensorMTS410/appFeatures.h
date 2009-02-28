/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: appFeatures.h,v 1.1.4.1 2007/04/26 20:34:54 njain Exp $
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
/// FEATURE_LEDS -- powers up the LEDs for debugging purposes

/// MIC define
#ifndef SENSOR_MIC
#define SENSOR_MIC      0
#endif

#define  SENSOR_BOARD_ID 0xA2               //MTS410 sensor board id



