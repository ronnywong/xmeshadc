/**
 *  Contains methods pertaining to the Configuration XML which are specific only to the
 *  gdome implementation.
 *
 * @file      xconfigxml_conversion.c
 * @author    Rahul Kapur
 *
 * @version   2005/11/1    rkapur      Initial version
 *
 * Copyright (c) 2004-2005 Crossbow Technology, Inc.   All rights reserved.
 *
 * $Id: xconfigxml_gdome.h,v 1.9.2.10 2007/03/13 22:30:17 rkapur Exp $
 */


#ifndef _XCONFIGXML_GDOME_H_
#define _XCONFIGXML_GDOME_H_

#include <libgdome/gdome.h>
#include <libxml/tree.h>
#include <libxml/parser.h>
#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include "xdebug.h"
#include "xutil.h"
#include "xconfigxml.h"
#include "xlist.h"



int xconfigxml_buildParameter(XFilterParam** param, GdomeElement* filterNode);
int xconfigxml_buildCondition(XFilter* filter,GdomeElement* filterNode);
int xconfigxml_buildFilters(XList* filterList, GdomeElement* filterListNode);
int xconfigxml_buildBitField(XField** field, GdomeElement* fieldSubNode);
int xconfigxml_buildField(XField** field, GdomeElement* fieldSubNode);
int xconfigxml_buildFields(XList* fieldList, GdomeElement* fieldListNode);
int xconfigxml_buildDataSink(XDataSink** dataSink, GdomeElement* dataSinkNode);
int xconfigxml_buildDataSinks(XList* datasinkList, GdomeElement* datasinkListNode);
int xconfigxml_buildFieldExtractor(XFieldExtractor** fieldExt,GdomeElement *fieldExtNode);
int xconfigxml_build_fieldExtractorList(XList* fieldExtList, char* config_filename);
int xconfigxml_buildDSParamsList(XList* dsParamsList, GdomeElement* dataSinkNode);
int xconfigxml_buildDSParam(XDSParam** dsparam, GdomeElement* paramNode);

#endif
