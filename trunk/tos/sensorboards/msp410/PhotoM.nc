/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: PhotoM.nc,v 1.1.4.1 2007/04/27 05:28:40 njain Exp $
 */

/*
 *
 * Authors:    Mike Grimmer
 * Date last modified:  3/15/04
 *
 */

includes sensorboard;
module PhotoM 
{
  provides interface StdControl;
  provides interface Photo;
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
	TOSH_MAKE_PHOTO_CTL_INPUT();
	TOSH_CLR_PHOTO_CTL_PIN();
	TOSH_MAKE_THERM_PWR_INPUT();
	TOSH_CLR_THERM_PWR_PIN();

    return call ADCControl.init();
  }

  command result_t StdControl.start() 
  {
    atomic 
	{
      TOSH_MAKE_THERM_PWR_INPUT();
      TOSH_CLR_THERM_PWR_PIN();
      TOSH_MAKE_PHOTO_CTL_INPUT();
      TOSH_CLR_PHOTO_CTL_PIN();
    }
    return SUCCESS;
  }

  command result_t StdControl.stop() 
  {
    atomic 
	{
      TOSH_CLR_PHOTO_CTL_PIN();
      TOSH_MAKE_PHOTO_CTL_INPUT();
    }
    return SUCCESS;
  }

  command result_t Photo.On()
  {
    atomic 
	{
      TOSH_MAKE_THERM_PWR_INPUT();
      TOSH_CLR_THERM_PWR_PIN();
      TOSH_MAKE_PHOTO_CTL_OUTPUT();
      TOSH_SET_PHOTO_CTL_PIN();
    }
    return SUCCESS;
  }

  command result_t Photo.Off()
  {
    atomic 
	{
      TOSH_MAKE_THERM_PWR_INPUT();
      TOSH_CLR_THERM_PWR_PIN();
      TOSH_MAKE_PHOTO_CTL_INPUT();
      TOSH_CLR_PHOTO_CTL_PIN();
    }
    return SUCCESS;
  }

}
