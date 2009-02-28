/**
 * Global Type definitions for XServe modules
 *
 * @file      xserve_types.h
 * @author    Martin Turon, Rahul Kapur
 * @version   2004/3/10    mturon      Initial version
 * @n         2005/11/1    rkapur      Major rewrite for XServe2
 * Copyright (c) 2004 Crossbow Technology, Inc.   All rights reserved.
 *
 * $Id: xserve_types.h,v 1.9.2.10 2007/03/13 22:32:11 rkapur Exp $
 */

#ifndef __XSERVE_TYPES_H__
#define __XSERVE_TYPES_H__

#if !defined(__CYGWIN__)
#include <inttypes.h>
#else //__CYGWIN
#include <sys/types.h>
#endif //__CYGWIN

#include <time.h>


typedef struct TosMsg_MicaZ
{
  uint8_t length;
  uint8_t fcfhi;
  uint8_t fcflo;
  uint8_t dsn;
  uint16_t destpan;
  uint16_t addr;
  uint8_t am_type;
  uint8_t group;
  uint8_t data[0];
} __attribute__ ((packed)) TosMsg_MicaZ;



typedef struct TosMsg_Mica2
{
  uint16_t addr;
  uint8_t  am_type;
  uint8_t  group;
  uint8_t  length;
  uint8_t  data[0];
} __attribute__ ((packed)) TosMsg_Mica2;


//this is for backward compatibility.
//all TosMsg references actually refer to mica2
//from now on though we should specify exactly which
//platform we are talking about
typedef TosMsg_Mica2 TosMsg;

typedef struct MultihopMsg
{
     uint16_t sourceaddr;
      uint16_t originaddr;
      uint16_t  seqno;
    uint8_t  hopcount;
} __attribute__ ((packed)) MultihopMsg;


/** A structure to store parsed parameter flags. */
typedef struct _xparams {
  union {
      unsigned flat;

      struct {
	  // output display options
	  unsigned  display_raw    : 1;  //!< raw TOS packets
	  unsigned  display_parsed : 1;  //!< pull out sensor readings
	  unsigned  display_cooked : 1;  //!< convert to engineering units
	  unsigned  export_raw     : 1;  //!< output comma delimited fields
	  unsigned  export_parsed  : 1;  //!< output comma delimited fields
	  unsigned  export_cooked  : 1;  //!< output comma delimited fields
	  unsigned  log_raw        : 1;  //!< log output to database
	  unsigned  log_parsed     : 1;  //!< log output to database
	  unsigned  log_cooked     : 1;  //!< log output to database
	  unsigned  xml_raw        : 1;  //!< output comma delimited fields
	  unsigned  xml_parsed     : 1;  //!< output comma delimited fields
	  unsigned  xml_cooked     : 1;  //!< output comma delimited fields
	  unsigned  display_ascii  : 1;  //!< display packet as ASCII chars
	  unsigned  display_rsvd   : 1;  //!< pad first word for output options

	  // modes of operation
	  unsigned  display_html   : 1;  //!< display html reports
	  unsigned  display_time   : 1;  //!< display timestamp of packet
	  unsigned  display_help   : 1;
	  unsigned  display_baud   : 1;  //!< baud was set by user
	  unsigned  mode_debug     : 1;  //!< debug serial port
	  unsigned  mode_quiet     : 1;  //!< suppress headers
	  unsigned  mode_version   : 1;  //!< print versions of all modules
	  unsigned  mode_header    : 1;  //!< user using custom packet header
	  unsigned  mode_serial    : 1;  //!< connect to a serial device
	  unsigned  mode_sf        : 1;  //!< connect to a serial forwarder
	  unsigned  mode_framing   : 2;  //!< auto=0, framed=1, unframed=2
	  unsigned  mode_daemon	   : 1;
	  unsigned  xtest          : 1;  //!< test value and output results
	  unsigned  modbus         : 1;  //!< log output to modbus database

      } bits;

      struct {
	  unsigned short output;         //!< one output option required
	  unsigned short mode;
      } options;
  }flags;
  char* db_server;
  char* db_port;
  char* db_name;
  char* db_user;
  char* db_passwd;
  char* db_tablename;
  char** argv;
  int argc;

} XServeParams;


typedef struct _xbuf {
    unsigned int length;
    unsigned int alloc_length;
    char* buf;
}xbuffer;


typedef struct _dataelem {
  char* field_name;
  char* parsed_value;
  int parsed_length;
  int parsed_type;
  char* converted_value;
  int converted_length;
  int converted_type;
  int converted_unit;
  int special_type;
  void* next;
} XDataElem;

typedef struct _datarow {
  int length;
  char* raw_row;
  int raw_row_length;
  void* field_extractor;
  void* parse_handler;
  XDataElem* head;
  XDataElem* tail;
} XDataRow;



typedef void (*PacketStore)(XDataRow* row, XServeParams* xparams);
typedef int (*PacketStoreFilter)(XDataRow* row, XServeParams* xparams);


typedef struct _XStoreHandler {
  char*   name;
  char*   version;            //!< CVS version string of boards source file
  int rank;
  PacketStoreFilter filter;
  PacketStore store;
} XStoreHandler;

typedef XDataRow* (*PacketParser)(unsigned char *packet,int length, XServeParams* xparams);
typedef int (*PacketParseFilter)(unsigned char* packet,int length, XServeParams* xparams);

typedef struct XParseHandler {
  char*   name;
  char*   version;            //!< CVS version string of boards source file
  int rank;
  PacketParseFilter filter;
  PacketParser parser;
} XParseHandler;



typedef struct {
    int count;                    //!< used to trigger rate calcs
    time_t start_time;            //!< last time report was done
    time_t last_peak_calc;        //!< last time peak calcs were done
    int upstream_msgs;            //!< total upstream msgs
    int upstream_bytes;
    int downstream_msgs;
    int downstream_bytes;
    float upstream_msg_rate;      //!< max upstream msg rate
    float upstream_byte_rate;
    float downstream_msg_rate;
    float downstream_byte_rate;
    float upstream_rate_msgs;     //!< used to calculate upstream_msg_rate
    float upstream_rate_bytes;
    float downstream_rate_msgs;
    float downstream_rate_bytes;
} sfStats_t;


typedef void (*ReportPrintStats)(int report_type, xbuffer* buffer);
typedef void (*ReportPrintData)(int report_type, xbuffer* buffer);


typedef struct _XReportHandler {
  char*   name;
  char*   version;            //!< CVS version string of boards source file
  ReportPrintStats print_stats;
  ReportPrintData print_data;
} XReportHandler;


typedef struct _xnodeinfo{
	int node_id;
	int parent_id;
	int board_id;
	time_t last_heard;
}XNodeInfo;



#endif



