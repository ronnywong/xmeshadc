/**
 * Handles conversion to engineering units for common sensor types.
 *
 * @file      xconvert.c
 * @author    Martin Turon
 *
 * @version   2004/8/6    mturon      Initial version
 * @n         2005/5/19   rkapur      Added conversion function for type conversion
 *
 * Copyright (c) 2004 Crossbow Technology, Inc.   All rights reserved.
 *
 * The goals for this module are to provide a general, lucid, and reusable
 * set of conversion functions for common sensors shared across the diverse
 * line of Crossbow products.  Inputs are usually 16-bit raw ADC readings
 * and outputs are generally a floating point number in some standard
 * engineering unit.  The standard engineering unit for a few common
 * measurements follows:
 *
 *     Temperature:    degrees Celsius (C)
 *     Voltage:        millvolts (mV)
 *     Pressure:       millibar (mbar)
 *
 * Additional goals are to provide type conversion from different representations
 * of data such as conversion from double to uint etc.
 *
 * $Id: xconvert.h,v 1.9.2.10 2007/03/13 22:30:30 rkapur Exp $
 */

#ifndef __XCONVERT_H__
#define __XCONVERT_H__

#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <ctype.h>

#ifdef __arm__
#include <sys/types.h>
#endif

#if !defined(__CYGWIN__)
#include <inttypes.h>
#else //__CYGWIN
#include <sys/types.h>
#endif //__CYGWIN

#include "xutil.h"
#include "xserve_types.h"
#include "xserve_consts.h"



/** Structure to describe sensirion data for XConvert. */
typedef struct XSensorSensirion
{
    uint16_t humidity;
    uint16_t thermistor;
} __attribute__ ((packed)) XSensorSensirion;

/** Structure to describe intersema data for XConvert. */
typedef struct XSensorIntersema
{
    uint16_t temp;
    uint16_t pressure;
} __attribute__ ((packed)) XSensorIntersema;

uint16_t xconvert_battery_mica2   (uint16_t vref);
uint16_t xconvert_battery_dot     (uint16_t vref);

float    xconvert_accel           (uint16_t accel_raw);
float    xconvert_mag             (uint16_t data,uint16_t vref);

uint32_t xconvert_adc_single      (uint16_t adc_sing);
int32_t  xconvert_adc_precision   (uint16_t adc_prec);

// Sensirion conversions
float xconvert_sensirion_temp     (XSensorSensirion *data);
float xconvert_sensirion_humidity (XSensorSensirion *data);

// Intersema conversions
float xconvert_intersema_temp     (XSensorIntersema *data, uint16_t *calib);
float xconvert_intersema_pressure (XSensorIntersema *data, uint16_t *calib);

uint16_t xconvert_thermistor_resistance  (uint16_t thermistor);
float    xconvert_thermistor_temperature (uint16_t thermistor);

uint16_t xconvert_light   (uint16_t light, uint16_t vref);

float    xconvert_spectrum_soiltemp  (uint16_t data);
float    xconvert_echo10  (uint16_t data);
float    xconvert_echo20  (uint16_t data);

uint8_t xconvert_to_uint8(void* val);
uint16_t xconvert_to_uint16(void* val);
uint32_t xconvert_to_uint32(void* val);
uint64_t xconvert_to_uint64(void* val);
int xconvert_to_int(void* val);
short int xconvert_to_short(void* val);
long long int xconvert_to_long(void* val);
float xconvert_to_float(void* val);
double xconvert_to_double(void* val);
char xconvert_to_char(void* val);
char* xconvert_to_string(void* val);

void xconvert_type_to_str(char* val,int valsize,int type, xbuffer* buf);
void xconvert_type_to_hexstr(char* val,int valsize,int type, xbuffer* buf);

int xconvert_hex_to_bin(char* hexstr,char** binarray);

int xconvert_mask_shift(void* data, int dsize, int dtype, unsigned long long mask, int shift, void* rdata);
long xconvert_type_cmp(void* eval,int evalsize,void* val,int valsize,int type);
int xconvert_typename_to_type(char* tname);
int xconvert_str_to_typeval(char* str, int type, void** val);


char xconvert_cast_to_char(void* val, int type);
uint8_t xconvert_cast_to_uint8(void* val, int type);
uint16_t xconvert_cast_to_uint16(void* val, int type);
uint32_t xconvert_cast_to_uint32(void* val, int type);
uint64_t xconvert_cast_to_uint64(void* val, int type);
int xconvert_cast_to_int(void* val, int type);
short xconvert_cast_to_short(void* val, int type);
long long int xconvert_cast_to_long(void* val, int type);
float xconvert_cast_to_float(void* val, int type);
double xconvert_cast_to_double(void* val, int type);
int xconvert_type_to_type(void* fromval, int fromtype, void** toval, int totype);
void xconvert_escstr_to_literals(char* src);

int xconvert_micaZ_to_mica2(const char* micaZpkt, int micaZpkt_size, char** mica2pkt, int* mica2pkt_size);
int xconvert_mica2_to_micaZ(const char* mica2pkt, int mica2pkt_size, char** micaZpkt, int* micaZpkt_size);



#endif  /* __CONVERT_H__ */



