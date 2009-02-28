/**
 * Handles routing of XSensor packets to the correct board to decipher.  Based on XServe 1 legacy implementation
 *
 * @file      xsensor.c
 * @author    Martin Turon, Hu Siquan, Rahul Kapur
 * @version   2004/3/10    mturon      Initial version
 * @n         2004/4/15    husiquan    Added temp,light,accel,mic,sounder,mag
 * @n         2004/8/2     mturon      Added database logging
 * @n         2005/11/1    rkapur      modified for new XServe 2 architecture
 *
 * Copyright (c) 2004 Crossbow Technology, Inc.   All rights reserved.
 *
 * $Id: xsensor.h,v 1.9.2.10 2007/03/13 22:31:52 rkapur Exp $
 */

#ifndef _XSENSOR_H_
#define _XSENSOR_H_

#include "xserve_types.h"
#include "xserve_consts.h"
#include "xconvert.h"
#include "xdbpgres.h"
#include "xutil.h"
#include "xdebug.h"
#include "xdatarow.h"
#include "xstore.h"


typedef union XBoardFlags {
    unsigned flat;
    struct {
	unsigned table_init : 1; //!< whether logging table is validated
    };
} XBoardFlags;

/** Encodes sensor readings into the data payload of a TOS message. */
typedef struct {
    uint8_t  board_id;        //!< Unique sensorboard id
    uint8_t  packet_id;       //!< Unique packet type for sensorboard
    uint16_t  node_id;         //!< Id of originating node
    uint16_t data[12];        //!< Data payload defaults to 24 bytes
    uint8_t  parent;          //!< Id of node's parent
    uint8_t  terminator;      //!< Reserved for null terminator
} XbowSensorboardPacket;


typedef void (*PacketPrinter)(unsigned char *packet);

typedef struct XSensorHandler {
    uint8_t  type;               //!< sensorboard id
    char *   version;            //!< CVS version string of boards source file

    PacketPrinter print_parsed;
    PacketPrinter print_cooked;
    PacketPrinter export_parsed;
    PacketPrinter export_cooked;
    PacketPrinter log_cooked;

    XBoardFlags flags;           //!< flags for board specific management

} XSensorHandler;

//defined in xsensor.c but is here so
//boards can know about it at compile time
//but not have to inidivdually add it
extern xbuffer* g_xsensor_data;

char* xsensor_get_timestamp();
void xsensor_add_boardtype(XSensorHandler *handler);
XbowSensorboardPacket *xsensor_get_sensor_packet(unsigned char *tos_packet);
int xsensor_print_error_txt(XbowSensorboardPacket *packet);
XSensorHandler *xsensor_get_board_handler(XbowSensorboardPacket* sensor_pkt);
void xsensor_initialize_boards();

void mica2_initialize();     /* From boards/mica2.c */
void   mica2dot_initialize();  /* From boards/mica2.c */
void   micaz_initialize();     /* From boards/mica2.c */

void   mda300_initialize();    /* From boards/mda300.c */
void   mda320_initialize();    /* From boards/mda320.c */
void   mda400_initialize();    /* From boards/mda500.c */
void   mda500_initialize();    /* From boards/mda500.c */

void   mts300_initialize();    /* From boards/mts300.c */
void   mts310_initialize();    /* From boards/mts300.c */

void   mts400_initialize();    /* From boards/mts400.c */
void   mts420_initialize();    /* From boards/mts400.c */

void   mts510_initialize();    /* From boards/mts510.c */
void   mts101_initialize();    /* From boards/mts101.c */
void   mep500_initialize();    /* From boards/mep500.c */
void   mep401_initialize();    /* From boards/mep401.c */
void   mep510_initialize();    /* From boards/mep510.c */
void   mep410_initialize();    /* From boards/mep410.c */
void   ggbacltst_initialize(); /* From boards/ggbacltst.c */
void   msp410_initialize();    /* From boards/msp410.c */

void   telosb_initialize();    /* From boards/telosb.c */

void   xtutorial_initialize();  /* From boards/xtutorial.c */

#endif



