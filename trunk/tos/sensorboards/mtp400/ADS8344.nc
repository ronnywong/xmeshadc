/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: ADS8344.nc,v 1.1.4.1 2007/04/27 05:31:17 njain Exp $
 */

 
 /*
 *
 *
 * driver for ADS8344 on mtp400ca
 *
 * Authors: Hu Siquan <husq@xbow.com>
 *
 */

includes sensorboard;

configuration ADS8344
{
  provides {
    interface StdControl;
    interface ADConvert[uint8_t port];
  }
}
implementation
{
    components Main, ADS8344M;

    StdControl = ADS8344M;
    ADConvert = ADS8344M;
}
