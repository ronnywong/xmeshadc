/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: TelosbDefaultM.nc,v 1.1.4.1 2007/04/27 05:06:00 njain Exp $
 */

module TelosbDefaultM {
  provides {
      interface BareSendMsg as SendActual;
  }
  uses {
      interface BareSendMsg as Send;
  }
}

implementation {
}
