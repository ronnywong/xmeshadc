/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: Bcast.h,v 1.1.4.1 2007/04/25 23:35:15 njain Exp $
 */

/*
 *
 * Authors:		Philip Buonadonna
 * Date last modified:  3/12/03
 *
 */

/**
 * @author Philip Buonadonna
 */


#ifndef _TOS_BCAST_H
#define _TOS_BCAST_H

#include "AM.h"

typedef struct _BcastMsg {
  int16_t seqno;
  uint8_t data[(TOSH_DATA_LENGTH-2)];
} __attribute__ ((packed)) TOS_BcastMsg;

#endif /* _TOS_BCAST_H */
