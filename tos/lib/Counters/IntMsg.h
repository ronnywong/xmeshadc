/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: IntMsg.h,v 1.1.4.1 2007/04/25 23:35:59 njain Exp $
 */

/*
 * Authors:		Jason Hill, David Gay, Philip Levis
 * Date last modified:  6/25/02
 *
 */

// The message type for IntToRfm/RfmToInt


/**
 * @author Jason Hill
 * @author David Gay
 * @author Philip Levis
 */

typedef struct IntMsg {
  uint16_t val;
  uint16_t src;
} IntMsg;

enum {
  AM_INTMSG = 4
};
