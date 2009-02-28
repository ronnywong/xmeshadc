/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: appFeatures.h,v 1.1.2.2 2007/04/26 20:20:54 njain Exp $
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
#define FEATURE_LEDS        1
#endif


/// FEATURE_UART_SEND -- enable serial port debugging of a node
#ifndef FEATURE_UART_SEND
#define FEATURE_UART_SEND   0
#endif

// crossbow sensor board id
// define MTS420 to enable gps. 
//        MTS400 will not send gps packets.
#define MTS420

#ifndef MTS420
#define  SENSOR_BOARD_ID 0x85               //MTS400 sensor board id
#else
#define  SENSOR_BOARD_ID 0x86               //MTS420 sensor board id
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


#ifdef MTS420

#ifndef NMEA_EXTRACTION_MACROS
#define NMEA_EXTRACTION_MACROS
#define extract_num_sats_m(data)     (10*(data[0]-'0') + (data[1]-'0'))
#define extract_hours_m(data)        (10*(data[0]-'0') + (data[1]-'0'))
#define extract_minutes_m(data)      (10*(data[2]-'0') + (data[3]-'0'))
#define extract_dec_sec_m(data)      (10*(data[4]-'0') +  (data[5]-'0') + 0.1*(data[7]-'0') \
                                      + 0.01*(data[8]-'0') + 0.001*(data[9]-'0'))
#define extract_Lat_deg_m(data)      (10*(data[0]-'0') + (data[1]-'0'))
#define extract_Lat_dec_min_m(data)  (10*(data[2]-'0') +  (data[3]-'0') + 0.1*(data[5]-'0') \
                                      + 0.01*(data[6]-'0') + 0.001*(data[7]-'0') + 0.0001*(data[8]-'0'))
#define extract_Long_deg_m(data)     (100*(data[0]-'0') + 10*(data[1]-'0') + (data[2]-'0'))
#define extract_Long_dec_min_m(data) (10*(data[3]-'0') +  (data[4]-'0') + 0.1*(data[6]-'0') \
				      + 0.01*(data[7]-'0') + 0.001*(data[8]-'0') + 0.0001*(data[9]-'0'))
#endif

#define is_gga_string_m(ns) ((ns[3]=='G')&&(ns[4]=='G')&&(ns[5]=='A'))

#endif