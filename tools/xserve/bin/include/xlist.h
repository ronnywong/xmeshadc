/**
 * Provides a gereric list interface for c.  List nodes consist of list information and
 * a generic void pointer to user data.  Users must cast and interpret data but can use
 * xlist functions to acutally build and manipulate the list.
 *
 * @file      xlist.c
 * @author    Rahul kapur
 * @version   2005/8/01    rkapur      Initial version
 *
 * Copyright (c) 2004 Crossbow Technology, Inc.   All rights reserved.
 *
 * $Id: xlist.h,v 1.9.2.10 2007/03/13 22:31:15 rkapur Exp $
 */

#ifndef _XLIST_H_
#define _XLIST_H_

#include <stdarg.h>
#include "xutil.h"

typedef struct xlistElem{
	void * element;
	struct xlistElem* next;
	struct xlistElem* prev;
}XListElem;

typedef struct xlist{
	int length;
	struct xlistElem* head;
	struct xlistElem* tail;
}XList;


typedef int (*EvalListElem)(void* item,va_list);

XList* xlist_create_list();
void xlist_append_list(XList* to_list, XList* from_list);
void xlist_add_element(XList* list, void* item);
void xlist_remove_element(XList* list, XListElem* relem);
void xlist_destroy_list(XList* list);
XListElem* xlist_iterate(XList* list, XListElem* curr);
void xlist_swap_elems(XList* list, XListElem* e1, XListElem* e2);

#endif
