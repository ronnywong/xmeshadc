/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: Oscope.nc,v 1.1.4.1 2007/04/25 23:26:49 njain Exp $
 */
 
/*
 * Authors:		Jason Hill, Nelson Lee
 * Date last modified:  6/28/02
 *
 *
 */

/**
 * @author Jason Hill
 * @author Nelson Lee
 */


interface Oscope {
  command result_t activate();
  command result_t deactivate();
  command result_t resetSampleCount();
  command result_t setMaxSamples(uint8_t maxSamples);
  command result_t setDataChannel(uint8_t channel);
  command result_t setBytesPerSample(uint8_t numBytes);
  command result_t setSendType(uint8_t sendType);
}

