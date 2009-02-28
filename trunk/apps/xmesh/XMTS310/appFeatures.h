/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: appFeatures.h,v 1.2.4.1 2007/04/26 20:18:20 njain Exp $
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
#ifndef FEATURE_LEDS
#define FEATURE_LEDS        0
#endif

/// FEATURE_UART_SEND -- enable serial port debugging of a node
#ifndef FEATURE_UART_SEND
#define FEATURE_UART_SEND   0
#endif

/// FEATURE_SOUNDER -- enable test of speaker output
#ifndef FEATURE_SOUNDER
#define FEATURE_SOUNDER     0
#endif

#define MTS310
// crossbow sensor board id
#ifndef MTS310
#define  SENSOR_BOARD_ID 0x83               //MTS300 sensor board id
#else
#define  SENSOR_BOARD_ID 0x84               //MTS300 sensor board id
#endif

/**
 * Define wiring macros for various application features. 
 */
/** FEATURE_LEDS will enable debugging Leds when set to 1. */
#if FEATURE_LEDS
#define LEDS_COMPONENT	       LedsC,
#define LEDS_WIRING(X)         X.Leds -> LedsC;
#else
#define LEDS_COMPONENT	       NoLeds,
#define LEDS_WIRING(X)         X.Leds -> NoLeds;
#endif



