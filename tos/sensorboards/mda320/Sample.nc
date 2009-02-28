/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: Sample.nc,v 1.1.4.2 2007/04/27 05:15:58 njain Exp $
 */

/*
 *
 * Authors:   Mohammad Rahimi mhr@cens.ucla.edu
 * History:   created 08/14/2003
 *
 *
 */

interface Sample {
    command int8_t getSample(uint8_t channel,uint8_t channelType,uint16_t interval,uint8_t param); 
    command result_t set_digital_output(uint8_t channel,uint8_t state);
    event result_t dataReady(uint8_t channel,uint8_t channelType,uint16_t data); 
    command result_t reTask(int8_t record,uint16_t interval);
    command result_t stop(int8_t record);
    command result_t sampleNow();
}

