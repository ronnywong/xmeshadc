/**
 * These functions are responsible for creating and manipulating
 * datarows.  Datarows are the intermediary representation of packets
 * after they have been parsed by a parsing module.
 *
 * @file      xdatarow.c
 * @author    Rahul kapur
 * @version   2005/8/01    rkapur      Initial version
 *
 * Copyright (c) 2004 Crossbow Technology, Inc.   All rights reserved.
 *
 * $Id: xdatarow.h,v 1.9.2.10 2007/03/13 22:30:43 rkapur Exp $
 */

#ifndef _XDATAROW_H_
#define _XDATAROW_H_

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include "xutil.h"
#include "xserve_types.h"
#include "xserve_consts.h"
#include "xconvert.h"



XDataRow* xdatarow_create_row(char* rawrow,int rawlength);
XDataElem* xdatarow_create_elem(char* fieldname, char* data, int datasize, int type);
void xdatarow_set_converted_elem(XDataElem* elem, char* converted_value, int converted_length, int converted_type);
void xdatarow_add_elem(XDataRow* row, XDataElem* elem);
XDataElem* xdatarow_find_by_field(XDataRow* row, char* fieldname);
XDataElem* xdatarow_find_by_specialtype(XDataRow* row, int specialtype);
void xdatarow_destroy_row(XDataRow* row);
void xdatarow_destroy_elem(XDataElem* elem);
void xdatarow_print_row(XDataRow* row);
void xdatarow_print_parsed_value(XDataElem* elem, xbuffer* valbuf);
void xdatarow_print_parsed_decvalue(XDataElem* elem, xbuffer* valbuf);
void xdatarow_print_converted_value(XDataElem* elem, xbuffer* convbuf, int fallback_raw);
int xdatarow_specialtypename_to_specialtype(char* tname);
void xdatarow_fill_field_buffer(XDataRow* row, char* templatestr, char* fieldlist, xbuffer* parsedbuff, xbuffer* convbuff, char* defaultval);

#endif
