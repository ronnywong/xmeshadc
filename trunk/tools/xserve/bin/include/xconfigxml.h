/**
 *  Contains methods pertaining to the Configuration XML
 *
 * @file      xconfigxml.h
 * @author    Rahul Kapur
 *
 * @version   2005/11/1    rkapur      Initial version
 *
 * Copyright (c) 2004-2005 Crossbow Technology, Inc.   All rights reserved.
 *
 * $Id: xconfigxml.h,v 1.9.2.10 2007/03/13 22:30:10 rkapur Exp $
 */

#ifndef _XCONFIGXML_H_
#define _XCONFIGXML_H_

#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include "xdebug.h"
#include "xutil.h"
#include "xlist.h"
#include "xconvert.h"
#include "xdatarow.h"

#define XFIELDEXTRACTOR_TAG "XFieldExtractor"
#define XFIELDS_TAG 		"XFields"
#define XFIELD_TAG 		"XField"
#define XBITFIELD_TAG 		"XBitField"
#define XUNIONFIELD_TAG 	"XUnionField"
#define XDATASINKS_TAG  	"XDataSinks"
#define XDATASINK_TAG 		"XDataSink"
#define XDSPARAM_TAG 		"XDSParam"
#define XCONVERSION_TAG 	"XConversion"
#define XCONVPARAM_TAG 		"XConvParam"



#define XFILTERS_TAG  		"XFilter"
#define XCONDAND_TAG 		"XCondAnd"
#define XCONDOR_TAG 		"XCondOr"
#define XCONDNOT_TAG 		"XCondNot"
#define XCOND_TAG 		"XCond"
#define XFILTERPARAM_TAG 	"XFilterParam"


#define NAME_ATTR_TAG		"name"
#define VALUE_ATTR_TAG		"value"
#define BYTEOFF_ATTR_TAG	"byteoffset"
#define TYPE_ATTR_TAG		"type"
#define LENGTH_ATTR_TAG		"length"
#define ORDER_ATTR_TAG		"order"
#define MASK_ATTR_TAG		"mask"
#define SHIFT_ATTR_TAG		"shift"
#define SPECIALTYPE_ATTR_TAG "specialtype"
#define OPTOR_ATTR_TAG		"optor"
#define LNAME_ATTR_TAG		"leftname"
#define RNAME_ATTR_TAG		"rightname"

#define OR_OPT_TAG		"or"
#define AND_OPT_TAG		"and"
#define LSHIFT_OPT_TAG		"lshift"
#define RSHIFT_OPT_TAG		"rshift"
#define MOD_OPT_TAG		"mod"

#define FUNCTION_ATTR_TAG	"function"
#define RETURNTYPE_ATTR_TAG	"returntype"
#define VARNAME_ATTR_TAG	"variablename"
#define FIELDNAME_ATTR_TAG	"fieldname"



#define COND_ISEQUAL_TAG	"isEqual"
#define COND_ALLTRUE_TAG	"alwaysTrue"
#define COND_ALLFALSE_TAG	"alwaysFalse"

#define PARAM_FIELDNAME_ATTR_TAG	"fieldname"
#define PARAM_FIELDVALUE_ATTR_TAG	"fieldvalue"
#define PARAM_TYPE_ATTR_TAG			"type"



enum{
	XCONDAND,
	XCONDOR,
	XCONDNOT
};

enum{
	XCOND = 100,
	XCOND_ISEQUAL,
	XCOND_ALWAYS_TRUE,
	XCOND_ALWAYS_FALSE
};

typedef struct _conversion{
	char* function;
	int returntype;
	void* evalFunction;
	XList* convParamsList;
}XConversion;


typedef struct _field{
	char* name;
	int byteOffset;
	int length;
	int type;
	int specialtype;
	char* mask;
	int shift;
	char* optor;
	char* leftname;
	char* rightname;
	XConversion* conversion;
} XField;

typedef struct _convparam{
	char* variablename;
	char* fieldname;
	int fieldtype;
	XField* convField;
}XConvParam;



typedef struct _filterparam{
	char* name;
	char* value;
}XFilterParam;

typedef struct _filter{
	int type;
	XList* childFilterList;
	XList* filterParamsList;
	//assume each base condition is associated with a field
	//so this is a shortcut pointer to the field
	XField* condField;
}XFilter;

typedef struct _dsparams{
	char* name;
	char* value;
}XDSParam;

typedef struct _datasink{
	char* name;
	XList* dsParamsList;
}XDataSink;



typedef struct _fieldExtractor{
	char* name;
	int order;
	XList* fieldList;
	XList* filterList;
	XList* dataSinkList;
} XFieldExtractor;

void xconfigxml_print_filterParamList(XList* paramList, int r);
void xconfigxml_print_filter(XList* filterList, int r);
void xconfigxml_print_datasinkList(XList* dsList);
void xconfigxml_print_fieldList(XList* fList);
void xconfigxml_print_fieldExtractorList(XList* feList);
void xconfigxml_print_conversion(XConversion* conv);
void xconfigxml_print_dsParamsList(XList* paramList);


XFieldExtractor* xconfigxml_create_fieldExtractor(char* name, int order);
XField* xconfigxml_create_field(char* name, int boffset, int length,int type);
XFilter* xconfigxml_create_filter(int type);
XFilterParam* xconfigxml_create_filterParam(char* name, char* value);
XDataSink* xconfigxml_create_datasink(char* name);
XDSParam* xconfigxml_create_dsParam(char* name, char* value);
XConversion* xconfigxml_create_conversion(char* function, int returntype);
XConvParam* xconfigxml_create_convParam(char* variablename, char* fieldname, int fieldtype);


void xconfigxml_destroy_filterParamList(XList* paramList);
void xconfigxml_destroy_filterList(XList* filterList);
void xconfigxml_destroy_datasinkList(XList* dsList);
void xconfigxml_destroy_dsParamsList(XList* paramList);
void xconfigxml_destroy_fieldList(XList* fList);
void xconfigxml_destroy_fieldExtractorList(XList* feList);
void xconfigxml_destroy_conversion(XConversion* conv);

int xconfigxml_post_process_fieldExtractorList(XList* feList);
int xconfigxml_post_process_filterList(XList* filterList,XList* fieldList);
int xconfigxml_post_process_fieldList(XList* fieldList);
int xconfigxml_post_process_conversion(XConversion* conv, XList* fieldList);

int xconfigxml_evaluate_filter(XFilter* filter, char* packet, int length);
int xconfigxml_evaluate_fieldExtractorList(XList* feList, char* packet, int length);

XField* xconfigxml_find_field(XList* fList, char* fieldName);
XFilterParam* xconfigxml_find_filterParam(XList* paramList, char* paramName);

int xconfigxml_set_conversion_variables(XDataRow* drow, XConversion* conv, char** names,double* values,int count);
void xconfigxml_convert_field(XField* field, XDataRow* drow);

void xconfigxml_sort_fieldExtractorList(XList* fieldExtList);
#endif
