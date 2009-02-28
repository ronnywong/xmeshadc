/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: list.h,v 1.1.4.1 2007/04/27 06:07:54 njain Exp $
 */

/* Authors:   Philip Levis, inherited from David Powell?
 * History:   created 1998?, added to TinyOS 5/1/2002
 */

/**
 * @author Philip Levis
 * @author inherited from David Powell?
 */

#ifndef __LIST_H__
#define __LIST_H__

/*
/*                                                                      tab:42
 * list.h - Generic embedded linked list functionality.
 *
 * Generic circular doubly linked list implementation.
 *
 * list_t is the head of the list.
 * list_link_t should be included in structures which want to be
 *     linked on a list_t.
 *
 * All of the list functions take pointers to list_t and list_link_t
 * types, unless otherwise specified.
 *
 * list_init(list) initializes a list_t to an empty list.
 *
 * list_empty(list) returns 1 iff the list is empty.
 *
 * Insertion functions.
 *   list_insert_head(list, link) inserts at the front of the list.
 *   list_insert_tail(list, link) inserts at the end of the list.
 *   list_insert_before(olink, nlink) inserts nlink before olink in list.
 *
 * Removal functions.
 * Head is list->l_next.  Tail is list->l_prev.
 * The following functions should only be called on non-empty lists.
 *   list_remove(link) removes a specific element from the list.
 *   list_remove_head(list) removes the first element.
 *   list_remove_tail(list) removes the last element.
 *
 * Item accessors.
 *   list_item(link, type, member) given a list_link_t* and the name
 *      of the type of structure which contains the list_link_t and
 *      the name of the member corresponding to the list_link_t,
 *      returns a pointer (of type "type*") to the item.
 *
 * To iterate over a list,
 *
 *    list_link_t *link;
 *    for (link = list->l_next;
 *         link != list; link = link->l_next)
 *       ...
 */

typedef struct list {
	struct list *l_next;
	struct list *l_prev;
} list_t, list_link_t;


#endif /* __LIST_H__ */
