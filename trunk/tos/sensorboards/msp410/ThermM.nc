/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: ThermM.nc,v 1.1.4.1 2007/04/27 05:30:29 njain Exp $
 */

/*
 *
 * Authors:  Mike Grimmer
 * Revision:		$Rev$
 *
 */
includes sensorboard;
module ThermM 
{
  provides interface StdControl;
  provides interface Therm;
  uses 
  {
    interface ADCControl;
  }
}
implementation 
{
  command result_t StdControl.init() 
  {
    call ADCControl.bindPort(TOS_ADC_PHOTO_PORT, TOSH_ACTUAL_PHOTO_PORT);
    call ADCControl.init();
    TOSH_MAKE_PHOTO_CTL_INPUT();
	TOSH_CLR_PHOTO_CTL_PIN();
    TOSH_MAKE_THERM_PWR_INPUT();
	TOSH_CLR_THERM_PWR_PIN();
    return SUCCESS;
  }

  command result_t StdControl.start() 
  {
    TOSH_MAKE_THERM_PWR_INPUT();
    TOSH_CLR_THERM_PWR_PIN();

    return SUCCESS;
  }

  command result_t StdControl.stop() 
  {
    TOSH_MAKE_THERM_PWR_INPUT();
    TOSH_CLR_THERM_PWR_PIN();
    return SUCCESS;
  }

  command result_t Therm.On() 
  {
    TOSH_MAKE_PHOTO_CTL_INPUT();
	TOSH_CLR_PHOTO_CTL_PIN();
    TOSH_MAKE_THERM_PWR_OUTPUT();
    TOSH_SET_THERM_PWR_PIN();
    return SUCCESS;
  }

  command result_t Therm.Off() 
  {
    TOSH_MAKE_PHOTO_CTL_INPUT();
	TOSH_CLR_PHOTO_CTL_PIN();
    TOSH_MAKE_THERM_PWR_INPUT();
    TOSH_CLR_THERM_PWR_PIN();
    return SUCCESS;
  }

}

