/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: Sample.nc,v 1.1.4.1 2007/04/27 05:32:41 njain Exp $
 */


interface Sample {
    command result_t getSample(uint8_t RTDNum); 
    async event result_t dataReady(uint8_t channel,uint16_t data1,uint16_t data2,uint16_t data3); 
}
