/**
 * Portability layer into low-level serial communication.
 *
 * @file      xserial.c
 * @author    Martin Turon
 *
 * @version   2005/10/26    mturon      Initial version
 *
 * Copyright (c) 2004-2005 Crossbow Technology, Inc.   All rights reserved.
 *
 * $Id: xpl_serial.h,v 1.9.2.10 2007/03/13 22:31:40 rkapur Exp $
 */

#ifndef __XPL_SERIAL_H_
#define __XPL_SERIAL_H_
#ifdef __cplusplus
extern "C" {
#endif
#include <sys/time.h>
#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>

#include "xutil.h"

#ifdef __win32__
#include <windows.h>
typedef HANDLE           serial_handle;
#define SERIAL_FAIL      INVALID_HANDLE_VALUE


#else

typedef int              serial_handle;
#define SERIAL_FAIL      -1

#endif


typedef void (*serve_func)(int fd, void* data);



/**
 * Effects: opens serial port device at specified baud_rate. If non_blocking
 *    is true, read_serial_packet calls will be non-blocking (writes are
 *    always blocking, for now at least)
 *
 * @return descriptor for serial forwarder at host:port, or
 * @n        NULL for failure (bad device or bad baud rate)
 */
serial_handle xserial_open(const char *device, int baud_rate);

/**
 * Effects: Closes serial source src.
 *
 * @return  0 if successful, -1 if some problem occured (but
 * @n       source is considered closed anyway)
 */
int xserial_close(serial_handle src);

/**
 * @return next byte (>= 0), or -1 if no data available and the source
 * @n      is non-blocking.
 */
extern int xserial_read(serial_handle fd, char *buffer, int n, int blocking);

/** Low level block write to serial port. */
extern int xserial_write(serial_handle src, const char *buffer, int count);

/**
 * Effects: Waits until deadline for some data on source. deadline
 *    can be NULL for indefinite waiting.
 *
 * @return  0 if data is available, -1 if the deadline expires
 */
extern int xserial_wait(serial_handle src, struct timeval* deadline);

/**
 * Effects: sets the baud rate of the raw serial device
 *
 * @return  0 on success, -1 otherwise
 */
extern int xserial_set_speed(serial_handle serial_fd, int baud_rate);

extern char* xserial_parse_device(char* dev);

extern int xserial_serial_serve(int fd, void* data , serve_func ecb);

int xserial_valid(serial_handle fd);

#ifdef __cplusplus
}
#endif
#endif // __XSERIAL_H_
