/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: InjectMsg.nc,v 1.1.4.1 2007/04/26 00:11:02 njain Exp $
 */
 
/*
 *
 * Authors:		David Gay
 *
 */

/* component that may inject messages directly into GenericComm */

/**
 * @author David Gay
 */

module InjectMsg {
  provides interface ReceiveMsg;
}
implementation
{
  /* Do nothing. We don't inject anything. */
  int dummy;			/* oops, will be fixed in next version of nesc */
}

